<?php
/**
 * Barzahlen Payment Module (ViruteMart2)
 *
 * NOTICE OF LICENSE
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3 of the License
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see http://www.gnu.org/licenses/
 *
 * @copyright   Copyright (c) 2012 Zerebro Internet GmbH (http://www.barzahlen.de)
 * @author      Alexander Diebler (alexander.diebler@barzahlen.de)
 * @license     http://opensource.org/licenses/GPL-3.0  GNU General Public License, version 3 (GPL-3.0)
 */

abstract class vmPSPlugin {

  protected $_configTableFieldName = '';
  protected $_tablename;

  function __construct () {
    $this->_tablename = DB_PREFIX . 'virtuemart_payment_plg_barzahlen';
  }

  function displayListFE (VirtueMartCart $cart, $method, array $cart_prices) {

    return $this->checkConditions ($cart, $method, $cart_prices);
  }

  function setConfigParameterable($paramsFieldName, $varsToPushParam) {
    // do nothing
  }

  function getVmPluginMethod($payment_method_id) {

    $method = new method;
    $method->loadConfig($payment_method_id);
    $method->cost_per_transaction = 0;
    $method->cost_percent_total = 0;
    return isset($method->debug) ? $method : null;
  }

  function selectedThisElement($payment_method) {

    return $payment_method === 'barzahlen';
  }

  function getPaymentCurrency($method) {
    // do nothing
  }

  function renderByLayout($tmpl, array $vars = array()) {
    return $tmpl;
  }

  function storePSPluginInternalData(array $dbValues) {

    $paymentName = $dbValues["payment_name"];
    $vmPaymentMethod = $dbValues["virtuemart_paymentmethod_id"];
    $transactionId = $dbValues["transaction_id"];
    $orderNumber = $dbValues["order_number"];
    $amount = $dbValues["amount"];
    $currency = $dbValues["currency"];
    $state = $dbValues["state"];

    mysql_query("INSERT INTO ". DB_PREFIX ."virtuemart_payment_plg_barzahlen
                 (payment_name, virtuemart_paymentmethod_id, transaction_id, order_number, amount, currency, state)
                 VALUES ('". $paymentName ."', '". $vmPaymentMethod ."', '". $transactionId ."', '". $orderNumber ."', '". $amount ."', '". $currency ."', '". $state ."')");
  }

  function selectedThisByMethodId($id) {

    if($id == 1) {
      return true;
    }
    return false;
  }

  function getHtmlHeaderBE() {
    return "<tr><th colspan=\"2\">Payment Method</th></tr>";
  }

  function getHtmlRowBE($key, $value) {
    return "<tr><td>".$key."</td><td>".$value."</td></tr>";
  }

  function onStoreInstallPluginTable($jplugin_id) {
    // do nothing
  }

  function OnSelectCheck($cart) {
    // do nothing
  }

  function onSelectedCalculatePrice($cart, $cart_prices, $cart_prices_name) {
    // do nothing
  }

  function onCheckAutomaticSelected($cart, $cart_prices,  $paymentCounter) {
    // do nothing
  }

  function onShowOrderFE($virtuemart_order_id, $virtuemart_paymentmethod_id, $payment_name) {
    // do nothing
  }

  function onShowOrderPrint($order_number, $method_id) {
    // do nothing
  }

  function declarePluginParams($type, $name, $id, $data) {
    // do nothing
  }

  function setOnTablePluginParams($name, $id, $table) {
    // do nothing
  }
}
