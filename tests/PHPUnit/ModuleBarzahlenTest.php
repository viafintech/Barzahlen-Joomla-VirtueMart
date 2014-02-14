<?php
/**
 * Barzahlen Payment Module
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to info@barzahlen.de so we can send you a copy immediately.
 *
 * @category    ZerebroInternet
 * @package     ZerebroInternet_Barzahlen
 * @copyright   Copyright (c) 2012 Zerebro Internet GmbH (http://www.barzahlen.de)
 * @author      Alexander Diebler (alexander.diebler@barzahlen.de)
 * @license     http://opensource.org/licenses/osl-3.0.php  Open Software License (OSL-3.0)
 */

require_once('src/plugins/vmpayment/barzahlen/barzahlen.php');

class ModuleBarzahlenTest extends PHPUnit_Framework_TestCase {

  /**
   * Set everything that is needed for the testing up.
   */
  public function setUp() {

    $subject = '';
    $config = '';
    $this->db = new db_handler;
    $this->object = new plgVmpaymentBarzahlen($subject, $config);
  }

  /**
   * Tests payment settings.
   */
  public function testPaymentSettings() {

    $this->assertEquals('pending', plgVmpaymentBarzahlen::STATE_PENDING);
    $this->assertEquals('paid', plgVmpaymentBarzahlen::STATE_PAID);
    $this->assertEquals('completed', plgVmpaymentBarzahlen::STATE_COMPLETE);
    $this->assertEquals('expired', plgVmpaymentBarzahlen::STATE_EXPIRED);
    $this->assertEquals('denied', plgVmpaymentBarzahlen::STATE_DENIED);
    $this->assertEquals(false, plgVmpaymentBarzahlen::$_this);
    $this->assertObjectHasAttribute('_debug', $this->object);
    $this->assertObjectHasAttribute('_logFile', $this->object);
  }

  /**
   *
   */
  public function testCheckConditionsOK() {

    $cart = new VirtueMartCart;
    $cart->setCountry(81); // DE
    $method = new method;
    $method->loadConfig(1);
    $method->countries = array($method->countries);
    $cart_prices = array('salesPrice' => 1000);

    $this->assertTrue($this->object->displayListFE($cart, $method, $cart_prices));
  }

  /**
   *
   */
  public function testCheckConditionsNoCountry() {

    $cart = new VirtueMartCart;
    $method = new method;
    $method->loadConfig(1);
    $cart_prices = array('salesPrice' => 1000);

    $this->assertFalse($this->object->displayListFE($cart, $method, $cart_prices));
  }

  /**
   *
   */
  public function testCheckConditionsNoCountry2() {

    $cart = new VirtueMartCart;
    $cart->setCountry('');
    $method = new method;
    $method->loadConfig(1);
    $cart_prices = array('salesPrice' => 1000);

    $this->assertFalse($this->object->displayListFE($cart, $method, $cart_prices));
  }

  /**
   *
   */
  public function testCheckConditionsWrongCountry() {

    $cart = new VirtueMartCart;
    $cart->setCountry(223); // USA
    $method = new method;
    $method->loadConfig(1);
    $cart_prices = array('salesPrice' => 1000);

    $this->assertFalse($this->object->displayListFE($cart, $method, $cart_prices));
  }

  /**
   *
   */
  public function testCheckConditionsHigherSalesPrice() {

    $cart = new VirtueMartCart;
    $cart->setCountry(81); // DE
    $method = new method;
    $method->loadConfig(1);
    $cart_prices = array('salesPrice' => 1200);

    $this->assertFalse($this->object->displayListFE($cart, $method, $cart_prices));
  }

  /**
   *
   */
  public function testCheckConditionsLowerSalesPrice() {

    $cart = new VirtueMartCart;
    $cart->setCountry(81); // DE
    $method = new method;
    $method->loadConfig(1);
    $cart_prices = array('salesPrice' => -200);

    $this->assertFalse($this->object->displayListFE($cart, $method, $cart_prices));
  }

  /**
   *
   */
  public function testPlgVmConfirmedOrderPaypal() {

    $cart = new VirtueMartCart;
    $order = array('details' => array());
    $order['details']['BT'] = new bt;
    $order['details']['BT']->setPaymentmethod(2);

    $this->assertFalse($this->object->plgVmConfirmedOrder($cart, $order));
  }

  /**
   *
   */
  public function testPlgVmConfirmedOrderUnknown() {

    $cart = new VirtueMartCart;
    $order = array('details' => array());
    $order['details']['BT'] = new bt;
    $order['details']['BT']->setPaymentmethod(3);

    $this->assertEquals(null, $this->object->plgVmConfirmedOrder($cart, $order));
  }

  /**
   *
   */
  public function testPlgVmConfirmedOrderSuccess() {

    $preQuery = mysql_query("SELECT id FROM ".DB_PREFIX."virtuemart_payment_plg_barzahlen");

    $cart = new VirtueMartCart;
    $order = array('details' => array());
    $order['details']['BT'] = new bt;
    $order['details']['BT']->setEmail("foo@bar.com");
    $order['details']['BT']->setOrderId(5);
    $order['details']['BT']->setAmount("24.95");
    $order['details']['BT']->setVmOrderId(5);
    $order['details']['BT']->setPaymentmethod(1);
    $order['details']['BT']->setCountryId('47');

    $subject = '';
    $config = '';
    $this->object = $this->getMock('plgVmpaymentBarzahlen', array('_connectBarzahlenApi'), array(&$subject, $config));

    $this->object->expects($this->once())
                 ->method('_connectBarzahlenApi')
                 ->will($this->returnCallback('apiMockPaymentSuccess'));

    $this->object->plgVmConfirmedOrder($cart, $order);

    $postQuery = mysql_query("SELECT id FROM ".DB_PREFIX."virtuemart_payment_plg_barzahlen");
    $this->assertTrue(mysql_num_rows($preQuery) + 1 == mysql_num_rows($postQuery));
    $query = mysql_query("SELECT state FROM ".DB_PREFIX."virtuemart_payment_plg_barzahlen WHERE order_number = '5'");
    $result = mysql_fetch_array($query);
    $this->assertEquals('pending', $result['state']);
  }

  /**
   *
   */
  public function testPlgVmConfirmedOrderFailure() {

    $preQuery = mysql_query("SELECT id FROM ".DB_PREFIX."virtuemart_payment_plg_barzahlen");

    $cart = new VirtueMartCart;
    $order = array('details' => array());
    $order['details']['BT'] = new bt;
    $order['details']['BT']->setEmail("foo@bar.com");
    $order['details']['BT']->setOrderId(5);
    $order['details']['BT']->setAmount("24.95");
    $order['details']['BT']->setVmOrderId(5);
    $order['details']['BT']->setPaymentmethod(1);
    $order['details']['BT']->setCountryId('47');

    $subject = '';
    $config = '';
    $this->object = $this->getMock('plgVmpaymentBarzahlen', array('_connectBarzahlenApi'), array(&$subject, $config));

    $this->object->expects($this->once())
                 ->method('_connectBarzahlenApi')
                 ->will($this->returnCallback('apiMockRequestFailure'));

    $this->object->plgVmConfirmedOrder($cart, $order);

    $postQuery = mysql_query("SELECT id FROM ".DB_PREFIX."virtuemart_payment_plg_barzahlen");
    $this->assertTrue(mysql_num_rows($preQuery) + 1 == mysql_num_rows($postQuery));
    $query = mysql_query("SELECT state FROM ".DB_PREFIX."virtuemart_payment_plg_barzahlen WHERE order_number = '5'");
    $result = mysql_fetch_array($query);
    $this->assertEquals('denied', $result['state']);
  }

  /**
   *
   */
  public function testPlgVmOnSelfCallFEValidPaid() {

    $_GET = array('state' => 'paid',
                  'transaction_id' => '1',
                  'shop_id' => '11046',
                  'customer_email' => 'foo@bar.com',
                  'amount' => '24.95',
                  'currency' => 'EUR',
                  'order_id' => '1',
                  'custom_var_0' => '',
                  'custom_var_1' => '',
                  'custom_var_2' => '',
                  'hash' => 'e189151be435a6be419cffb6836f14ee9ce722c43325cdc2046d28e29e07477c9e1adaa576ee00267e98764db5f595e4895e2baf28f7bea211d23e656f96653c'
                 );

    $subject = '';
    $config = '';
    $this->object = $this->getMock('plgVmpaymentBarzahlen', array('_sendHeader'), array(&$subject, $config));

    $this->object->expects($this->once())
                 ->method('_sendHeader')
                 ->will($this->returnValue('200'));

    $this->object->plgVmOnSelfCallFE();
    $query = mysql_query("SELECT state FROM ".DB_PREFIX."virtuemart_payment_plg_barzahlen WHERE order_number = '1'");
    $result = mysql_fetch_array($query);
    $this->assertEquals('paid', $result['state']);
  }

  /**
   *
   */
  public function testPlgVmOnSelfCallFERefunded() {

    $_GET = array('state' => 'refund_completed',
                  'refund_transaction_id' => '1',
                  'origin_transaction_id' => '2',
                  'shop_id' => '11046',
                  'customer_email' => 'foo@bar.com',
                  'amount' => '24.95',
                  'currency' => 'EUR',
                  'origin_order_id' => '2',
                  'custom_var_0' => '',
                  'custom_var_1' => '',
                  'custom_var_2' => '',
                  'hash' => '002cb24cb41de1dacee346fd2abe62f8173c8903c646f5914d3654d511e990e863c82367c039c1ecd392454606d6b241484c6ee2372fe07f91f7d1c518353d5e'
                 );

    $subject = '';
    $config = '';
    $this->object = $this->getMock('plgVmpaymentBarzahlen', array('_sendHeader'), array(&$subject, $config));

    $this->object->expects($this->once())
                 ->method('_sendHeader')
                 ->will($this->returnValue('200'));

    $this->object->plgVmOnSelfCallFE();
    $query = mysql_query("SELECT state FROM ".DB_PREFIX."virtuemart_payment_plg_barzahlen_refund WHERE refund_transaction_id = '1'");
    $result = mysql_fetch_array($query);
    $this->assertEquals('completed', $result['state']);
  }

  /**
   * @expectedException Barzahlen_Exception
   */
  public function testPlgVmOnSelfCallFEInvalidPaid() {

    $_GET = array('state' => 'paid',
                  'transaction_id' => '1',
                  'shop_id' => '11046',
                  'customer_email' => 'foo@bar.com',
                  'amount' => '24.95',
                  'currency' => 'EUR',
                  'order_id' => '1',
                  'custom_var_0' => '',
                  'custom_var_1' => '',
                  'custom_var_2' => '',
                  'hash' => 'f189151be435a6be419cffb6836f14ee9ce722c43325cdc2046d28e29e07477c9e1adaa576ee00267e98764db5f595e4895e2baf28f7bea211d23e656f96653c'
                 );

    $subject = '';
    $config = '';
    $this->object = $this->getMock('plgVmpaymentBarzahlen', array('_sendHeader'), array(&$subject, $config));

    $this->object->expects($this->once())
                 ->method('_sendHeader')
                 ->will($this->returnValue('200'));

    $this->object->plgVmOnSelfCallFE();
    $query = mysql_query("SELECT state FROM ".DB_PREFIX."virtuemart_payment_plg_barzahlen WHERE order_number = '1'");
    $result = mysql_fetch_array($query);
    $this->assertEquals('pending', $result['state']);
  }

  /**
   * @expectedException Barzahlen_Exception
   */
  public function testPlgVmOnSelfCallFEUnknownType() {

    $_GET = array('state' => 'paid',
                  'transactionid' => '1',
                  'shop_id' => '11046',
                  'customer_email' => 'foo@bar.com',
                  'amount' => '24.95',
                  'currency' => 'EUR',
                  'order_id' => '1',
                  'custom_var_0' => '',
                  'custom_var_1' => '',
                  'custom_var_2' => '',
                  'hash' => 'e189151be435a6be419cffb6836f14ee9ce722c43325cdc2046d28e29e07477c9e1adaa576ee00267e98764db5f595e4895e2baf28f7bea211d23e656f96653c'
                 );

    $subject = '';
    $config = '';
    $this->object = $this->getMock('plgVmpaymentBarzahlen', array('_sendHeader'), array(&$subject, $config));

    $this->object->expects($this->once())
                 ->method('_sendHeader')
                 ->will($this->returnValue('400'));

    $this->object->plgVmOnSelfCallFE();
    $query = mysql_query("SELECT state FROM ".DB_PREFIX."virtuemart_payment_plg_barzahlen WHERE order_number = '1'");
    $result = mysql_fetch_array($query);
    $this->assertEquals('pending', $result['state']);
  }

  /**
   * @expectedException Barzahlen_Exception
   */
  public function testPlgVmOnSelfCallFEUnknownTransaction() {

    $_GET = array('state' => 'paid',
                  'transaction_id' => '123',
                  'shop_id' => '11046',
                  'customer_email' => 'foo@bar.com',
                  'amount' => '24.95',
                  'currency' => 'EUR',
                  'order_id' => '1',
                  'custom_var_0' => '',
                  'custom_var_1' => '',
                  'custom_var_2' => '',
                  'hash' => 'e189151be435a6be419cffb6836f14ee9ce722c43325cdc2046d28e29e07477c9e1adaa576ee00267e98764db5f595e4895e2baf28f7bea211d23e656f96653c'
                 );

    $subject = '';
    $config = '';
    $this->object = $this->getMock('plgVmpaymentBarzahlen', array('_sendHeader'), array(&$subject, $config));

    $this->object->expects($this->once())
                 ->method('_sendHeader')
                 ->will($this->returnValue('400'));

    $this->object->plgVmOnSelfCallFE();
    $query = mysql_query("SELECT state FROM ".DB_PREFIX."virtuemart_payment_plg_barzahlen WHERE order_number = '1'");
    $result = mysql_fetch_array($query);
    $this->assertEquals('pending', $result['state']);
  }

  /**
   *
   */
  public function testPlgVmOnSelfCallFERefundedUnknownState() {

    $_GET = array('state' => 'refund_complet',
                  'refund_transaction_id' => '1',
                  'origin_transaction_id' => '2',
                  'shop_id' => '11046',
                  'customer_email' => 'foo@bar.com',
                  'amount' => '24.95',
                  'currency' => 'EUR',
                  'origin_order_id' => '2',
                  'custom_var_0' => '',
                  'custom_var_1' => '',
                  'custom_var_2' => '',
                  'hash' => 'd728ae3651ab8956930beb37eb0269e38a5123c32476e5abcc2f1ffc410b68508bdc15571187da2eeac6a2b4acfe7b9dee5cac22dbd40df96c11f01a39217cc3'
                 );

    $subject = '';
    $config = '';
    $this->object = $this->getMock('plgVmpaymentBarzahlen', array('_sendHeader'), array(&$subject, $config));

    $this->object->expects($this->once())
                 ->method('_sendHeader')
                 ->will($this->returnValue('200'));

    $this->object->plgVmOnSelfCallFE();
    $query = mysql_query("SELECT state FROM ".DB_PREFIX."virtuemart_payment_plg_barzahlen_refund WHERE refund_transaction_id = '1'");
    $result = mysql_fetch_array($query);
    $this->assertEquals('pending', $result['state']);
  }

  /**
   *
   */
  public function testPlgVmOnSelfCallBEResendSuccess() {

    $_POST = array('action' => 'resend',
                   'vm_order_id' => '1',
                   'vm_method_id' => '1',
                   'transaction_id' => '1');

    $subject = '';
    $config = '';
    $this->object = $this->getMock('plgVmpaymentBarzahlen', array('_connectBarzahlenApi'), array(&$subject, $config));

    $this->object->expects($this->once())
                 ->method('_connectBarzahlenApi')
                 ->will($this->returnCallback('apiMockResendSuccess'));

    $this->object->plgVmOnSelfCallBE();
    $this->assertEquals(VMPAYMENT_BARZAHLEN_RESEND_SUCCESS, $_SESSION['message']);
  }

  /**
   *
   */
  public function testPlgVmOnSelfCallBEResendFailure() {

    $_POST = array('action' => 'resend',
                   'vm_order_id' => '1',
                   'vm_method_id' => '1',
                   'transaction_id' => '1');

    $subject = '';
    $config = '';
    $this->object = $this->getMock('plgVmpaymentBarzahlen', array('_connectBarzahlenApi'), array(&$subject, $config));

    $this->object->expects($this->once())
                 ->method('_connectBarzahlenApi')
                 ->will($this->returnCallback('apiMockRequestFailure'));

    $this->object->plgVmOnSelfCallBE();
    $this->assertEquals(VMPAYMENT_BARZAHLEN_RESEND_FAILURE, $_SESSION['message']);
  }

  /**
   *
   */
  public function testPlgVmOnSelfCallBERefundSuccess() {

    $_POST = array('action' => 'refund',
                   'vm_order_id' => '2',
                   'vm_method_id' => '1',
                   'transaction_id' => '11259384',
                   'refund_amount' => '24.95',
                   'currency' => 'EUR');

    $subject = '';
    $config = '';
    $this->object = $this->getMock('plgVmpaymentBarzahlen', array('_connectBarzahlenApi'), array(&$subject, $config));

    $this->object->expects($this->once())
                 ->method('_connectBarzahlenApi')
                 ->will($this->returnCallback('apiMockRefundSuccess'));

    $this->object->plgVmOnSelfCallBE();
    $this->assertEquals(VMPAYMENT_BARZAHLEN_REFUND_SUCCESS, $_SESSION['message']);
  }

  /**
   *
   */
  public function testPlgVmOnSelfCallBERefundFailure() {

    $_POST = array('action' => 'refund',
                   'vm_order_id' => '2',
                   'vm_method_id' => '1',
                   'transaction_id' => '11259384',
                   'refund_amount' => '24.95',
                   'currency' => 'EUR');

    $subject = '';
    $config = '';
    $this->object = $this->getMock('plgVmpaymentBarzahlen', array('_connectBarzahlenApi'), array(&$subject, $config));

    $this->object->expects($this->once())
                 ->method('_connectBarzahlenApi')
                 ->will($this->returnCallback('apiMockRequestFailure'));

    $this->object->plgVmOnSelfCallBE();
    $this->assertEquals(VMPAYMENT_BARZAHLEN_REFUND_FAILURE, $_SESSION['message']);
  }

  /**
   *
   */
  public function testPlgVmOnSelfCallBEActionUnknown() {

    $_POST = array('action' => 'repay',
                   'vm_method_id' => '1',
                   'transaction_id' => '1');

    $this->object->plgVmOnSelfCallBE();
    $this->assertEquals(VMPAYMENT_BARZAHLEN_BE_ACTION_FAILURE, $_SESSION['message']);
  }

  /**
   *
   */
  public function testVmOnShowOrderBEPayment() {

    $this->assertTrue(substr($this->object->plgVmOnShowOrderBEPayment('1', '1'), 0, 6) == "<table");
    $this->assertTrue(substr($this->object->plgVmOnShowOrderBEPayment('2', '1'), 0, 6) == "<table");
    $this->assertTrue(substr($this->object->plgVmOnShowOrderBEPayment('3', '1'), 0, 6) == "<table");
    $this->assertTrue(substr($this->object->plgVmOnShowOrderBEPayment('4', '1'), 0, 6) == "<table");
    $this->assertTrue("" == $this->object->plgVmOnShowOrderBEPayment('5', '1'));
    $this->assertTrue("" == $this->object->plgVmOnShowOrderBEPayment('1', '2'));
  }

  /**
   *
   */
  public function testPlgVmgetPaymentCurrency() {

    $methodId = 1;
    $currencyId = 47;
    $this->object->plgVmgetPaymentCurrency($methodId, $currencyId);

    $methodId = 2;
    $currencyId = 47;
    $this->assertFalse($this->object->plgVmgetPaymentCurrency($methodId, $currencyId));

    $methodId = 3;
    $currencyId = 47;
    $this->assertEquals(null,$this->object->plgVmgetPaymentCurrency($methodId, $currencyId));
  }

  /**
   *
   */
  public function testOldFunctions() {

    $var1 = 1;
    $var2 = 2;
    $var3 = 3;
    $cart = new VirtueMartCart;
    $method = new method;
    $method->loadConfig(1);
    $array = array('salesPrice' => '13.37');

    $this->object->plgVmOnStoreInstallPaymentPluginTable($var1);
    $this->object->plgVmOnSelectCheckPayment($cart);
    $this->object->plgVmDisplayListFEPayment($cart, $method, $array);
    $this->object->plgVmonSelectedCalculatePricePayment($cart, $array, $var1);
    $this->object->plgVmOnCheckAutomaticSelectedPayment($cart, $array, $var1);
    $this->object->plgVmOnShowOrderFEPayment($var1, $var2, $var3);
    $this->object->plgVmonShowOrderPrintPayment($var1, $var2);
    $this->object->plgVmDeclarePluginParamsPayment($var1, $var2, $var3);
    $this->object->plgVmSetOnTablePluginParamsPayment($var1, $var2, $var3);
  }

  /**
   * Unset everything before the next test.
   */
  public function tearDown() {

    unset($this->object);
    unset($this->db);
  }
}

function apiMockPaymentSuccess($shopId, $paymentKey, $sandbox, $request) {

  $xmlResponse = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
    <response>
      <transaction-id>11259384</transaction-id>
      <payment-slip-link>https://api-online-sandbox.barzahlen.de:904/download/2001048300000/8ae4dd4754a272db030b6a81e3bf287c17a51e653e5ec783686bf5bbee8ec710/Zahlschein_Barzahlen.pdf</payment-slip-link>
      <expiration-notice>Ihr Zahlschein ist 12 Tage gültig. Bitte bezahlen Sie Ihre Bestellung innerhalb der nächsten 12 Tage.</expiration-notice>
      <infotext-1>Drucken Sie diesen Zahlschein aus und nehmen Sie ihn mit zum Barzahlen-Partner in Ihrer Nähe. Den nächsten Barzahlen-Partner finden Sie unter &lt;a href=\"http://www.barzahlen.de/filialfinder\" target=\"_blank\"&gt;www.barzahlen.de/filialfinder&lt;/a&gt; oder unterwegs mit unserer App.&lt;br /&gt;Wir haben Ihnen den Zahlschein als PDF zusätzlich an folgende E-Mail geschickt: foo@bar.com.&lt;br /&gt;Sollte sich kein Popup mit dem Barzahlen-Zahlschein geöffnet haben, klicken Sie bitte &lt;a href=\"https://api-online-sandbox.barzahlen.de:904/download/2001048300000/8ae4dd4754a272db030b6a81e3bf287c17a51e653e5ec783686bf5bbee8ec710/Zahlschein_Barzahlen.pdf\" target=\"_blank\"&gt;hier&lt;/a&gt; für den manuellen Download.</infotext-1>
      <infotext-2>Wenn Sie keinen Drucker besitzen, können Sie sich den Zahlschein alternativ auf Ihr Handy schicken lassen. &lt;a href=\"https://83.169.20.111:903/customer/sms/2001048300000/8ae4dd4754a272db030b6a81e3bf287c17a51e653e5ec783686bf5bbee8ec710\" target=\"_blank\"&gt;Klicken Sie dazu hier.&lt;/a&gt;</infotext-2>
      <result>0</result>
      <hash>6fba7d65bd9f34e2a93ec732e5ac9664a05af1a7af6a874a14a327b54f7a1f71ef0032f466834ec5bf1096b99b7821011634aa8c73720e29c1ca712f83be83cf</hash>
    </response>";

  $request->parseXml($xmlResponse, $paymentKey);

  return $request;
}

function apiMockRefundSuccess($shopId, $paymentKey, $sandbox, $request) {

  $xmlResponse = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
    <response>
      <origin-transaction-id>11259384</origin-transaction-id>
      <refund-transaction-id>11325236</refund-transaction-id>
      <result>0</result>
      <hash>4978fc9f6971ae91c6cd8203bb61cfe09d7608f5bdc263caeb9e499041c7a2bfd76c2b5e0a34650b65f16e2fb0b6a6fd3eab7cbc09d8e096e58cab43b1d383ad</hash>
    </response>";

  $request->parseXml($xmlResponse, $paymentKey);

  return $request;
}

function apiMockResendSuccess($shopId, $paymentKey, $sandbox, $request) {

  $xmlResponse = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
    <response>
      <transaction-id>11325236</transaction-id>
      <result>0</result>
      <hash>ff38bbfc2910ac164e190f6a037de2b932086e98fa031e2602399f4a0a8342fe6da8d39c83c6cf773e3d7b9cf8702347be3a94c2fc9da70551621bf8efc945e9</hash>
    </response>";

  $request->parseXml($xmlResponse, $paymentKey);

  return $request;
}

function apiMockRequestFailure($shopId, $paymentKey, $sandbox, $request) {

  return $request; // return still invalid request
}

?>