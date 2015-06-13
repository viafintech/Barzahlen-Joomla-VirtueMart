<?php
/**
 * Barzahlen Payment Module (ViruteMart)
 *
 * @copyright   Copyright (c) 2015 Cash Payment Solutions GmbH (https://www.barzahlen.de)
 * @author      Alexander Diebler
 * @license     http://opensource.org/licenses/GPL-3.0  GNU General Public License, version 3 (GPL-3.0)
 */

defined('_JEXEC') or die('Restricted access');

if (!class_exists('vmPSPlugin')) {
    require(JPATH_VM_PLUGINS . DS . 'vmpsplugin.php');
}

if (!class_exists('Barzahlen_Base')) {
    require(dirname(__FILE__) . DS . 'barzahlen' . DS . 'api' . DS . 'loader.php');
}

class plgVmpaymentBarzahlen extends vmPSPlugin
{
    const REFUNDDB = "#__virtuemart_payment_plg_barzahlen_refund";
    const STATE_PENDING = 'pending';
    const STATE_PAID = 'paid';
    const STATE_COMPLETE = 'completed';
    const STATE_EXPIRED = 'expired';
    const STATE_DENIED = 'denied';
    const STATUS_OK = 200;
    const STATUS_BAD_REQUEST = 400;

    // instance of class
    public static $_this = false;
    protected $_debug;
    protected $_logFile;

    /**
     * Constructor
     *
     * @param object $subject The object to observe
     * @param array  $config  An array that holds the plugin configuration
     * @since 1.5
     */
    public function __construct(& $subject, $config)
    {
        parent::__construct($subject, $config);

        $this->_loggable = true;
        $this->_tablepkey = 'id';
        $this->_tableId = 'id';
        $this->tableFields = array_keys($this->getTableSQLFields());
        $varsToPush = array(
            'payment_logos' => array('', 'char'),
            'sandbox' => array(0, 'int'),
            'debug' => array(0, 'int'),
            'shop_id' => array('', 'char'),
            'payment_key' => array('', 'char'),
            'notification_key' => array('', 'char'),
            'payment_pending_status' => array('', 'char'),
            'payment_paid_status' => array('', 'char'),
            'payment_expired_status' => array('', 'char'),
            'payment_denied_status' => array('', 'char'),
            'min_amount' => array(0, 'int'),
            'max_amount' => array(0, 'int'),
            'cost_per_transaction' => array('', 'char'),
            'cost_percent_total' => array('', 'char'),
            'payment_currency' => array('', 'char'),
            'countries' => array('', 'char')
        );

        $this->_logFile = JPATH_ROOT . "/logs/barzahlen.log";
        $this->setConfigParameterable($this->_configTableFieldName, $varsToPush);
    }

    /**
     * Creates the Barzahlen payment table.
     */
    protected function getVmPluginCreateTableSQL()
    {
        return $this->createTableSQL('Payment Barzahlen Table');
    }

    /**
     * Returns sql query for payment table.
     *
     * @return array with database fields
     */
    public function getTableSQLFields()
    {
        $SQLfields = array(
            'id' => 'INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT',
            'virtuemart_order_id' => 'INTEGER(11) UNSIGNED',
            'virtuemart_paymentmethod_id' => 'INTEGER(11) UNSIGNED',
            'payment_name' => 'VARCHAR(500)',
            'transaction_id' => 'INTEGER NOT NULL',
            'order_number' => 'VARCHAR(64) NOT NULL',
            'amount' => 'DECIMAL(6,2) NOT NULL',
            'currency' => 'VARCHAR(3) NOT NULL',
            'state' => 'VARCHAR(20) NOT NULL'
        );

        return $SQLfields;
    }

    /**
     * Payment process.
     *
     * @param VirtueMartCart $cart cart object
     * @param VirtueMartModelOrders $order order object
     * @return null|boolean
     */
    public function plgVmConfirmedOrder($cart, $order)
    {
        if (!($method = $this->getVmPluginMethod($order['details']['BT']->virtuemart_paymentmethod_id))) {
            return null; // Another method was selected, do nothing
        }
        if (!$this->selectedThisElement($method->payment_element)) {
            return false;
        }

        $this->_debug = $method->debug == '1' ? true : false;
        $sandbox = $method->sandbox == '1' ? true : false;

        $modelOrder = VmModel::getModel('orders');

        $this->getPaymentCurrency($method);
        $q = 'SELECT `currency_code_3` FROM `#__virtuemart_currencies` WHERE `virtuemart_currency_id`="' . $method->payment_currency . '" ';
        $db = JFactory::getDBO();
        $db->setQuery($q);
        $currency_code_3 = $db->loadResult();

        $paymentCurrency = CurrencyDisplay::getInstance($method->payment_currency);
        $totalInPaymentCurrency = round($paymentCurrency->convertCurrencyTo($method->payment_currency, $order['details']['BT']->order_total, false), 2);

        $request = new Barzahlen_Request_Payment($order['details']['BT']->email, $order['details']['BT']->address_1,
                        $order['details']['BT']->zip, $order['details']['BT']->city,
                        $this->_loadCountry($order['details']['BT']->virtuemart_country_id), (string) $totalInPaymentCurrency,
                        $currency_code_3, $order['details']['BT']->order_number);

        $payment = $this->_connectBarzahlenApi($method->shop_id, $method->payment_key, $sandbox, $request);

        if ($payment->isValid()) {

            // Prepare data that should be stored in the database
            $dbValues = array();
            $dbValues['payment_name'] = $this->_renderLogo('88px');
            $dbValues['virtuemart_paymentmethod_id'] = $order['details']['BT']->virtuemart_paymentmethod_id;
            $dbValues['transaction_id'] = $payment->getTransactionId();
            $dbValues['order_number'] = $order['details']['BT']->order_number;
            $dbValues['amount'] = $totalInPaymentCurrency;
            $dbValues['cost_per_transaction'] = $method->cost_per_transaction;
            $dbValues['cost_percent_total'] = $method->cost_percent_total;
            $dbValues['currency'] = $currency_code_3;
            $dbValues['state'] = self::STATE_PENDING;
            $this->storePSPluginInternalData($dbValues);

            $order['customer_notified'] = 0;
            $order['order_status'] = $method->payment_pending_status;
            $order['comments'] = JText::sprintf('VMPAYMENT_BARZAHLEN_COMMENT_PENDING_STATUS');
            $modelOrder->updateStatusForOneOrder($order['details']['BT']->virtuemart_order_id, $order, TRUE);

            $html = $this->renderByLayout('orderdone', array('Infotext1' => $payment->getInfotext1()));
            JRequest::setVar('html', $html);

            $cart->emptyCart();
        } else {
            $order['customer_notified'] = 0;
            $order['order_status'] = $method->payment_denied_status;
            $order['comments'] = JText::sprintf('VMPAYMENT_BARZAHLEN_COMMENT_DENIED_STATUS');
            $modelOrder->updateStatusForOneOrder($order['details']['BT']->virtuemart_order_id, $order, TRUE);

            $dbValues = array();
            $dbValues['payment_name'] = $this->_renderLogo('88px');
            $dbValues['virtuemart_paymentmethod_id'] = $order['details']['BT']->virtuemart_paymentmethod_id;
            $dbValues['transaction_id'] = null;
            $dbValues['order_number'] = $order['details']['BT']->order_number;
            $dbValues['amount'] = $totalInPaymentCurrency;
            $dbValues['currency'] = $currency_code_3;
            $dbValues['state'] = self::STATE_DENIED;
            $this->storePSPluginInternalData($dbValues);

            $app = JFactory::getApplication();
            $app->redirect(JRoute::_('index.php?option=com_virtuemart&view=cart&task=editpayment'), JText::_('VMPAYMENT_BARZAHLEN_PAYMENT_FAILURE'), 'error');
        }
    }

    /**
     * Handles payment / refund notifications from Barzahlen.
     * Looks up the requested order and checks if everything is valid.
     *
     * @throws Barzahlen_Exception
     */
    public function plgVmOnSelfCallFE()
    {
        if (isset($_GET['transaction_id'])) {
            $query = "SELECT virtuemart_paymentmethod_id, virtuemart_order_id
                FROM " . $this->_tablename . "
                WHERE transaction_id = '" . $_GET['transaction_id'] . "'
                AND order_number = '" . $_GET['order_id'] . "'
                AND state = '" . self::STATE_PENDING . "'";
        } elseif (isset($_GET['origin_transaction_id'])) {
            $query = "SELECT virtuemart_paymentmethod_id, virtuemart_order_id
                FROM " . $this->_tablename . "
                WHERE transaction_id = '" . $_GET['origin_transaction_id'] . "'
                AND order_number = '" . $_GET['origin_order_id'] . "'
                AND state = '" . self::STATE_PAID . "'";
        } else {
            $this->_sendHeader(self::STATUS_BAD_REQUEST);
            throw new Barzahlen_Exception("Unknown notification type.");
        }

        $db = JFactory::getDBO();
        $db->setQuery($query);
        $paymentTable = $db->loadObject();

        if ($paymentTable === null) {
            $this->_bzLog("Transaction not found.");
            $this->_sendHeader(self::STATUS_BAD_REQUEST);
            throw new Barzahlen_Exception("Transaction not found.");
        }

        $method = $this->getVmPluginMethod($paymentTable->virtuemart_paymentmethod_id);
        $notification = new Barzahlen_Notification($method->shop_id, $method->notification_key, $_GET);

        try {
            $notification->validate();
        } catch (Exception $e) {
            $this->_bzLog($e);
        }

        if ($notification->isValid()) {
            $this->_sendHeader(self::STATUS_OK);
            $this->_updateDatabase($paymentTable->virtuemart_order_id, $method);
        } else {
            $this->_sendHeader(self::STATUS_BAD_REQUEST);
            throw new Barzahlen_Exception("Notification not valid.");
        }
    }

    /**
     * Routes the request backend action to the right method.
     */
    public function plgVmOnSelfCallBE()
    {
        switch ($_POST['action']) {
            case "resend":
                $this->_selfCallResendBE();
                break;
            case "refund":
                $this->_selfCallRefundBE();
                break;
            case "cancel":
                $this->_selfCallCancelBE();
                break;
            default:
                $app = JFactory::getApplication();
                $app->redirect(JRoute::_('index.php?option=com_virtuemart'), JText::_(VMPAYMENT_BARZAHLEN_BE_ACTION_FAILURE));
        }
    }

    /**
     * Catches the resend request data and sends the request to Barzahlen.
     * Provides an error or success message after the request.
     */
    function _selfCallResendBE()
    {
        $vmOrderId = filter_var($_POST['vm_order_id'], FILTER_SANITIZE_STRING);
        $vmMethodId = filter_var($_POST['vm_method_id'], FILTER_SANITIZE_NUMBER_INT);
        $transactionId = filter_var($_POST['transaction_id'], FILTER_SANITIZE_NUMBER_INT);

        $method = $this->getVmPluginMethod($vmMethodId);
        $this->_debug = $method->debug == '1' ? true : false;
        $sandbox = $method->sandbox == '1' ? true : false;

        $request = new Barzahlen_Request_Resend($transactionId);
        $resend = $this->_connectBarzahlenApi($method->shop_id, $method->payment_key, $sandbox, $request);

        if ($resend->isValid()) {
            $message = VMPAYMENT_BARZAHLEN_RESEND_SUCCESS;
            $type = 'message';
        } else {
            $message = VMPAYMENT_BARZAHLEN_RESEND_FAILURE;
            $type = 'error';
        }

        $app = JFactory::getApplication();
        $app->redirect(JRoute::_('index.php?option=com_virtuemart&view=orders&task=edit&virtuemart_order_id=' . $vmOrderId, false), JText::_($message), $type);
    }

    /**
     * Catches the cancel request data and sends the request to Barzahlen.
     * Provides an error or success message after the request.
     */
    function _selfCallCancelBE()
    {
        $vmOrderId = filter_var($_POST['vm_order_id'], FILTER_SANITIZE_STRING);
        $vmMethodId = filter_var($_POST['vm_method_id'], FILTER_SANITIZE_NUMBER_INT);
        $transactionId = filter_var($_POST['transaction_id'], FILTER_SANITIZE_NUMBER_INT);

        $method = $this->getVmPluginMethod($vmMethodId);
        $this->_debug = $method->debug == '1' ? true : false;
        $sandbox = $method->sandbox == '1' ? true : false;

        $request = new Barzahlen_Request_Cancel($transactionId);
        $cancel = $this->_connectBarzahlenApi($method->shop_id, $method->payment_key, $sandbox, $request);

        if ($cancel->isValid()) {
            $message = VMPAYMENT_BARZAHLEN_CANCEL_SUCCESS;
            $type = 'message';

            $query = "UPDATE " . $this->_tablename . "
                  SET state = 'canceled'
                  WHERE transaction_id = '" . $transactionId . "'";

            $db = JFactory::getDBO();
            $db->setQuery($query);
            $db->query();
        } else {
            $message = VMPAYMENT_BARZAHLEN_CANCEL_FAILURE;
            $type = 'error';
        }

        $app = JFactory::getApplication();
        $app->redirect(JRoute::_('index.php?option=com_virtuemart&view=orders&task=edit&virtuemart_order_id=' . $vmOrderId, false), JText::_($message), $type);
    }

    /**
     * Updates the database entry of the corresponding order.
     *
     * @param integer $virtuemart_order_id order id
     * @param PaymentMethod $method payment method
     */
    protected function _updateDatabase($virtuemart_order_id, $method)
    {
        switch ($_GET['state']) {
            case 'paid':
            case 'expired':
                $modelOrder = VmModel::getModel('orders');
                $order = array();
                $order['customer_notified'] = 0;
                $status = 'payment_' . strtolower($_GET['state']) . '_status';
                $order['order_status'] = $method->{$status};
                $comment = 'VMPAYMENT_BARZAHLEN_COMMENT_' . strtoupper($_GET['state']) . '_STATUS';
                $order['comments'] = JText::sprintf($comment);
                $modelOrder->updateStatusForOneOrder($virtuemart_order_id, $order, TRUE);

                $query = "UPDATE " . $this->_tablename . "
                  SET state = '" . $_GET['state'] . "'
                  WHERE transaction_id = '" . $_GET['transaction_id'] . "'";
                break;

            case 'refund_completed':
            case 'refund_expired':

                $query = "UPDATE " . self::REFUNDDB . "
                  SET state = '" . str_replace("refund_", "", $_GET['state']) . "'
                  WHERE refund_transaction_id = '" . $_GET['refund_transaction_id'] . "'";

                $comment = 'VMPAYMENT_BARZAHLEN_COMMENT_' . strtoupper($_GET['state']) . '_STATUS';
                $this->_addRefundComment($virtuemart_order_id, JText::_($comment));

                break;

            default:
                $query = "";
                break;
        }

        $db = JFactory::getDBO();
        $db->setQuery($query);
        $db->query();
    }

    /**
     * Catches the refund request data and sends the request to Barzahlen.
     * Provides an error or success message after the request.
     */
    protected function _selfCallRefundBE()
    {
        $vmOrderId = filter_var($_POST['vm_order_id'], FILTER_SANITIZE_STRING);
        $vmMethodId = filter_var($_POST['vm_method_id'], FILTER_SANITIZE_NUMBER_INT);
        $transactionId = filter_var($_POST['transaction_id'], FILTER_SANITIZE_NUMBER_INT);
        $refundAmount = round(filter_var(str_replace(",", ".", $_POST['refund_amount']), FILTER_SANITIZE_NUMBER_FLOAT, FILTER_FLAG_ALLOW_FRACTION), 2);
        $currency = filter_var($_POST['currency'], FILTER_SANITIZE_STRING);

        $method = $this->getVmPluginMethod($vmMethodId);
        $this->_debug = $method->debug == '1' ? true : false;
        $sandbox = $method->sandbox == '1' ? true : false;

        $request = new Barzahlen_Request_Refund($transactionId, $refundAmount, $currency);
        $refund = $this->_connectBarzahlenApi($method->shop_id, $method->payment_key, $sandbox, $request);

        if ($refund->isValid() && $refund->getOriginTransactionId() == $transactionId) {
            $query = "INSERT INTO " . self::REFUNDDB . " (refund_transaction_id, origin_transaction_id, amount, currency, state)
                VALUES ('" . $refund->getRefundTransactionId() . "', '" . $transactionId . "', '" . $refundAmount . "', '" . $currency . "', '" . self::STATE_PENDING . "')";

            $db = JFactory::getDBO();
            $db->setQuery($query);
            $db->query();

            $message = VMPAYMENT_BARZAHLEN_REFUND_SUCCESS;
            $this->_addRefundComment($vmOrderId, JText::_($message));
            $type = 'message';
        } else {
            $message = VMPAYMENT_BARZAHLEN_REFUND_FAILURE;
            $type = 'error';
        }

        $app = JFactory::getApplication();
        $app->redirect(JRoute::_('index.php?option=com_virtuemart&view=orders&task=edit&virtuemart_order_id=' . $vmOrderId, false), JText::_($message), $type);
    }

    /**
     * Adds refund comment to the order history.
     *
     * @param integer $id order id
     * @param string $comment comment to be added
     */
    protected function _addRefundComment($id, $comment)
    {
        $modelOrder = VmModel::getModel('orders');
        $order = $modelOrder->getOrder($id);
        $modelOrder->_updateOrderHist($id, $order['details']['BT']->order_status, '0', $comment);
    }

    /**
     * Gets the currency id for the payment.
     *
     * @param integer $virtuemart_paymentmethod_id payment method id
     * @param integer $paymentCurrencyId currency id
     * @return null|boolean
     */
    public function plgVmgetPaymentCurrency($virtuemart_paymentmethod_id, &$paymentCurrencyId)
    {
        if (!($method = $this->getVmPluginMethod($virtuemart_paymentmethod_id))) {
            return null; // Another method was selected, do nothing
        }
        if (!$this->selectedThisElement($method->payment_element)) {
            return false;
        }
        $this->getPaymentCurrency($method);
        $paymentCurrencyId = $method->payment_currency;
    }

    /**
     * Display stored payment data for an order in form of a table.
     * @see components/com_virtuemart/helpers/vmPSPlugin::plgVmOnShowOrderBEPayment()
     *
     * @param integer $virtuemart_order_id order id
     * @param integer $payment_method_id payment method id
     * @return null|string
     */
    public function plgVmOnShowOrderBEPayment($virtuemart_order_id, $payment_method_id)
    {
        if (!$this->selectedThisByMethodId($payment_method_id)) {
            return null; // Another method was selected, do nothing
        }

        if (!($paymentTable = $this->_getBarzahlenInternalData($virtuemart_order_id))) {
            // JError::raiseWarning(500, $db->getErrorMsg());
            return '';
        }

        $html = '<table class="adminlist">' . "\n";
        $html .= $this->getHtmlHeaderBE();
        $html .= $this->getHtmlRowBE('BARZAHLEN_PAYMENT_NAME', $this->_renderLogo('88px', 'admin'));

        $transactionId = $paymentTable->transaction_id;

        if ($paymentTable->state == self::STATE_PENDING) {
            $transactionId .= " " . $this->_renderResendButton("payment", $paymentTable->virtuemart_order_id, $paymentTable->virtuemart_paymentmethod_id, $paymentTable->transaction_id);
            $transactionId .= " " . $this->_renderCancelButton($paymentTable->virtuemart_order_id, $paymentTable->virtuemart_paymentmethod_id, $paymentTable->transaction_id);
        }
        $html .= $this->getHtmlRowBE('BARZAHLEN_PAYMENT_TRANSACTION_ID', $transactionId);

        $html .= $this->getHtmlRowBE('BARZAHLEN_PAYMENT_STATE', $paymentTable->state);

        if ($paymentTable->state == self::STATE_PAID) {
            $html .= $this->_generateRefundTable($paymentTable);
        }

        $html .= '</table>' . "\n";
        return $html;
    }

    /**
     * Gets the payment data for the current order.
     *
     * @param integer $virtuemart_order_id order id
     * @return mixed database object
     */
    protected function _getBarzahlenInternalData($virtuemart_order_id)
    {
        $db = JFactory::getDBO();
        $q = "SELECT bz.*
          FROM " . $this->_tablename . " bz, #__virtuemart_orders vm
          WHERE vm.order_number = bz.order_number
          AND vm.virtuemart_order_id = '" . (int) $virtuemart_order_id . "'";

        $db->setQuery($q);
        if (!($paymentTable = $db->loadObject())) {
            // JError::raiseWarning(500, $db->getErrorMsg());
            return '';
        }
        return $paymentTable;
    }

    /**
     * Generates refund table depending on payment table.
     *
     * @param mixed $paymentTable database object
     * @return string html code
     */
    protected function _generateRefundTable($paymentTable)
    {
        $this->_createRefundTable();
        $refunded = 0;
        $html = "";

        $query = "SELECT * FROM " . self::REFUNDDB . " WHERE origin_transaction_id = '" . $paymentTable->transaction_id . "' ";

        $db = JFactory::getDBO();
        $db->setQuery($query);
        $rows = $db->loadObjectList();
        foreach ($rows as $row) {
            $refunded += $row->state != self::STATE_EXPIRED ? $row->amount : 0;

            $refundId = $row->refund_transaction_id . " [ " . $row->amount . " " . $row->currency . " | " . $row->state . " ] ";

            if ($row->state == self::STATE_PENDING) {
                $refundId .= " " . $this->_renderResendButton("refund", $paymentTable->virtuemart_order_id, $paymentTable->virtuemart_paymentmethod_id, $row->refund_transaction_id);
            }

            $html .= $this->getHtmlRowBE('BARZAHLEN_REFUND', $refundId);
        }

        if ($refunded < $paymentTable->amount) {
            $html .= $this->getHtmlRowBE('BARZAHLEN_NEW_REFUND', $this->_renderRefundButton($paymentTable->virtuemart_order_id, $paymentTable->virtuemart_paymentmethod_id, $paymentTable->transaction_id, $paymentTable->currency)
                    . "[max. " . ($paymentTable->amount - $refunded) . " " . $paymentTable->currency . "]");
        }
        return $html;
    }

    /**
     * Check if the payment conditions are fulfilled for this payment method.
     * @author Valerie Isaksen
     * @author Alexander Diebler
     *
     * @param VirtueMartCart $cart cart object
     * @param PaymentMethod $method payment method
     * @param array $cart_prices cart prices
     * @return boolean depending on the fulfillment of the requirements
     */
    protected function checkConditions($cart, $method, $cart_prices)
    {
        $minAmount = (float) $method->min_amount;
        $maxAmount = (float) $method->max_amount;
        $amount = $cart_prices['salesPrice'];
        if (($amount < $minAmount) || ($maxAmount > 0 && ($amount > $maxAmount) )) {
            return false;
        }

        $address = $cart->BT; // Only billing address matters for Barzahlen payment
        if (!is_array($address)) {
            $address = array();
            $address['virtuemart_country_id'] = '[0]';
        }
        if (!isset($address['virtuemart_country_id'])) {
            $address['virtuemart_country_id'] = '[0]';
        }

        $countries = array();
        if (!empty($method->countries)) {
            if (!is_array($method->countries)) {
                $countries[0] = $method->countries;
            } else {
                $countries = $method->countries;
            }
        }

        if (!in_array($address['virtuemart_country_id'], $countries) || count($countries) == 0) {
            return false;
        }

        return true;
    }

    /**
     * Logs errors into Barzahlen log file.
     *
     * @param string $message error message
     */
    protected function _bzLog($message)
    {
        $time = date("[Y-m-d H:i:s] ");
        error_log($time . $message . "\r", 3, $this->_logFile);
    }

    /**
     * Generates the html code for the Barzahlen logo.
     *
     * @param string $width image width (100% = 168px)
     * @param string $group user group (admin / user)
     * @param string $style additional css settings
     * @return string html text
     */
    protected function _renderLogo($width = '168px', $group = 'user', $style = '')
    {
        $html = $this->renderByLayout('logo', array(
            'width' => $width,
            'group' => $group,
            'style' => $style));

        return $html;
    }

    /**
     * Generates the html code for the resend button.
     *
     * @param string $slip_type type of slip (payment / refund)
     * @param integer $vm_order_id order id
     * @param integer $vm_method_id payment method id
     * @param integer $transaction_id Barzahlen transaction id
     * @return string html text
     */
    protected function _renderResendButton($slip_type, $vm_order_id, $vm_method_id, $transaction_id)
    {
        $button = $slip_type == "payment" ? 'VMPAYMENT_BARZAHLEN_PAYMENT_RESEND' : 'VMPAYMENT_BARZAHLEN_REFUND_RESEND';

        $html = $this->renderByLayout('resend', array(
            'action' => "resend",
            'vm_order_id' => $vm_order_id,
            'vm_method_id' => $vm_method_id,
            'transaction_id' => $transaction_id,
            'button' => JText::_($button)));

        return $html;
    }

    /**
     * Generates the html code for the cancel button.
     *
     * @param integer $vm_order_id order id
     * @param integer $vm_method_id payment method id
     * @param integer $transaction_id Barzahlen transaction id
     * @return string html text
     */
    protected function _renderCancelButton($vm_order_id, $vm_method_id, $transaction_id)
    {
        $html = $this->renderByLayout('cancel', array(
            'action' => "cancel",
            'vm_order_id' => $vm_order_id,
            'vm_method_id' => $vm_method_id,
            'transaction_id' => $transaction_id,
            'button' => JText::_('VMPAYMENT_BARZAHLEN_PAYMENT_CANCEL')));

        return $html;
    }

    /**
     * Generates the html code for the refund field and button.
     *
     * @param integer $vm_order_id order id
     * @param integer $vm_method_id payment method id
     * @param integer $transaction_id Barzahlen transaction id
     * @param string $currency currency of the order (ISO 4217)
     * @return string html text
     */
    protected function _renderRefundButton($vm_order_id, $vm_method_id, $transaction_id, $currency)
    {
        $html = $this->renderByLayout('refund', array(
            'action' => "refund",
            'vm_order_id' => $vm_order_id,
            'vm_method_id' => $vm_method_id,
            'transaction_id' => $transaction_id,
            'currency' => $currency,
            'button' => JText::_('VMPAYMENT_BARZAHLEN_REQUEST_REFUND')));

        return $html;
    }

    /**
     * SQL query for refund database.
     */
    protected function _createRefundTable()
    {
        $query = "CREATE TABLE IF NOT EXISTS `" . self::REFUNDDB . "` (";
        $query .= "`id` INTEGER(11) UNSIGNED NOT NULL AUTO_INCREMENT,";
        $query .= "`refund_transaction_id` INTEGER(11) UNSIGNED,";
        $query .= "`origin_transaction_id` INTEGER(11) UNSIGNED,";
        $query .= "`amount` DECIMAL(6,2) NOT NULL,";
        $query .= "`currency` VARCHAR(3) NOT NULL,";
        $query .= "`state` VARCHAR(9) NOT NULL,";
        $query .= "PRIMARY KEY (`id`)";
        $query .= ") ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Barzahlen Refund Table' AUTO_INCREMENT=1 ;";

        $db = JFactory::getDBO();
        $db->setQuery($query);
        $db->query();
    }

    protected function _loadCountry($id)
    {
        $query = "SELECT country_2_code FROM #__virtuemart_countries
              WHERE virtuemart_country_id = '" . (int) $id . "'";

        $db = JFactory::getDBO();
        $db->setQuery($query);
        $result = $db->loadObject();

        return $result->country_2_code;
    }

    /**
     * Connects to Barzahlen and returns the updated request object.
     *
     * @param integer $shopId shop id
     * @param string $paymentKey payment key
     * @param boolean $sandbox sandbox setting
     * @param Barzahlen_Request_Base $request Barzahlen request object
     * @return Barzahlen_Request_Base updated Barzahlen request object
     */
    protected function _connectBarzahlenApi($shopId, $paymentKey, $sandbox, $request)
    {
        $api = new Barzahlen_Api($shopId, $paymentKey, $sandbox);
        $api->setDebug($this->_debug, $this->_logFile);
        $api->setLanguage(substr(JLanguageHelper::detectLanguage(), 0, 2));
        $api->setUserAgent('VirtueMart / Plugin v1.1.7');

        try {
            $api->handleRequest($request);
        } catch (Exception $e) {
            $this->_bzLog($e);
        }

        return $request;
    }

    /**
     * Sends out an http response depending on notification result.
     *
     * @param integer $code http status code
     */
    protected function _sendHeader($code)
    {
        switch ($code) {

            case self::STATUS_OK:
                header("HTTP/1.1 200 OK");
                header("Status: 200 OK");
                break;

            case self::STATUS_BAD_REQUEST:
                header("HTTP/1.1 400 Bad Request");
                header("Status: 400 Bad Request");
                break;
        }
    }

    /**
     * plgVmDisplayListFEPayment
     * This event is fired to display the pluginmethods in the cart (edit shipment/payment) for example
     * Is used to set description text and partner logos for Barzahlen
     *
     * @param object $cart Cart object
     * @param integer $selected ID of the method selected
     * @return boolean True on succes, false on failures, null when this plugin was not selected.
     * On errors, JError::raiseWarning (or JError::raiseError) must be used to set a message.
     *
     * @author Valerie Isaksen
     * @author Max Milbers
     * @author Alexander Diebler
     */
    public function plgVmDisplayListFEPayment(VirtueMartCart $cart, $selected = 0, &$htmlIn)
    {
        return $this->displayListFE($cart, $selected, $htmlIn);
    }

    /**
     * We must reimplement this triggers for joomla 1.7
     */

    /**
     * Create the table for this plugin if it does not yet exist.
     * This functions checks if the called plugin is active one.
     * When yes it is calling the standard method to create the tables
     * @author Valérie Isaksen
     *
     */
    function plgVmOnStoreInstallPaymentPluginTable($jplugin_id)
    {
        return $this->onStoreInstallPluginTable($jplugin_id);
    }

    /**
     * This event is fired after the payment method has been selected. It can be used to store
     * additional payment info in the cart.
     *
     * @author Max Milbers
     * @author Valérie isaksen
     *
     * @param VirtueMartCart $cart: the actual cart
     * @return null if the payment was not selected, true if the data is valid, error message if the data is not vlaid
     *
     */
    public function plgVmOnSelectCheckPayment(VirtueMartCart $cart)
    {
        return $this->OnSelectCheck($cart);
    }

    /**
     * plgVmonSelectedCalculatePricePayment
     * Calculate the price (value, tax_id) of the selected method
     * It is called by the calculator
     * This function does NOT to be reimplemented. If not reimplemented, then the default values from this function are taken.
     * @author Valerie Isaksen
     * @cart: VirtueMartCart the current cart
     * @cart_prices: array the new cart prices
     * @return null if the method was not selected, false if the shiiping rate is not valid any more, true otherwise
     *
     *
     */
    public function plgVmonSelectedCalculatePricePayment(VirtueMartCart $cart, array &$cart_prices, &$cart_prices_name)
    {
        return $this->onSelectedCalculatePrice($cart, $cart_prices, $cart_prices_name);
    }

    /**
     * plgVmOnCheckAutomaticSelectedPayment
     * Checks how many plugins are available. If only one, the user will not have the choice. Enter edit_xxx page
     * The plugin must check first if it is the correct type
     * @author Valerie Isaksen
     * @param VirtueMartCart cart: the cart object
     * @return null if no plugin was found, 0 if more then one plugin was found,  virtuemart_xxx_id if only one plugin is found
     *
     */
    function plgVmOnCheckAutomaticSelectedPayment(VirtueMartCart $cart, array $cart_prices = array(), &$paymentCounter)
    {
        return $this->onCheckAutomaticSelected($cart, $cart_prices, $paymentCounter);
    }

    /**
     * This method is fired when showing the order details in the frontend.
     * It displays the method-specific data.
     *
     * @param integer $order_id The order ID
     * @return mixed Null for methods that aren't active, text (HTML) otherwise
     * @author Max Milbers
     * @author Valerie Isaksen
     */
    public function plgVmOnShowOrderFEPayment($virtuemart_order_id, $virtuemart_paymentmethod_id, &$payment_name)
    {
        $this->onShowOrderFE($virtuemart_order_id, $virtuemart_paymentmethod_id, $payment_name);
    }

    /**
     * This method is fired when showing when priting an Order
     * It displays the the payment method-specific data.
     *
     * @param integer $_virtuemart_order_id The order ID
     * @param integer $method_id  method used for this order
     * @return mixed Null when for payment methods that were not selected, text (HTML) otherwise
     * @author Valerie Isaksen
     */
    function plgVmonShowOrderPrintPayment($order_number, $method_id)
    {
        return $this->onShowOrderPrint($order_number, $method_id);
    }

    function plgVmDeclarePluginParamsPayment($name, $id, &$data)
    {
        return $this->declarePluginParams('payment', $name, $id, $data);
    }

    function plgVmSetOnTablePluginParamsPayment($name, $id, &$table)
    {
        return $this->setOnTablePluginParams($name, $id, $table);
    }
}
// No closing tag