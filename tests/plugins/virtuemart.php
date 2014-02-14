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

class db {

  protected $cursor = 0;

  public function setQuery($query) {
    $this->query = str_replace("#__", DB_PREFIX, $query);
  }

  public function loadResult() {

    $query = mysql_query($this->query);
    $row = mysql_fetch_array($query);
    $ret = $row[0];

    return $ret;
  }

  public function loadObject() {

    $query = $this->cursor != 0 ? $this->query . " LIMIT ".$this->cursor.", 1" : $this->query;
    $query = mysql_query($query);
    $ret = mysql_fetch_object($query);

    return $ret != false ? $ret : null;
  }

  public function loadObjectList() {

    $array = array();

    while($row = $this->loadObject()) {
      $array[] = $row;
      $this->cursor++;
    }

    return $array;
  }

  public function query() {

    mysql_query($this->query);
  }
}

class bt {

  public $email;
  public $address_1;
  public $zip;
  public $city;
  public $order_number;
  public $order_total;
  public $order_status;
  public $virtuemart_order_id;
  public $virtuemart_paymentmethod_id;
  public $virtuemart_country_id;

  public function setEmail($email) {
    $this->email = $email;
  }

  public function setAddress1($address_1) {
    $this->address_1 = $address_1;
  }

  public function setZip($zip) {
    $this->zip = $zip;
  }

  public function setCity($city) {
    $this->city = $city;
  }

  public function setOrderStatus($order_status) {
    $this->order_status = $order_status;
  }

  public function setOrderId($order_number) {
    $this->order_number = $order_number;
  }

  public function setAmount($amount) {
    $this->order_total = $amount;
  }

  public function setVmOrderId($virtuemart_order_id) {
    $this->virtuemart_order_id = $virtuemart_order_id;
  }

  public function setPaymentmethod($pm) {
    $this->virtuemart_paymentmethod_id = $pm;
  }

  public function setCountryId($virtuemart_country_id) {
    $this->virtuemart_country_id = $virtuemart_country_id;
  }
}

class method {

  public $payment_element = '';
  public $_tbl_lang = '';

  public function loadConfig($id) {

    $query = mysql_query("SELECT payment_element, payment_params FROM ". DB_PREFIX ."virtuemart_paymentmethods WHERE virtuemart_paymentmethod_id = '". $id ."'");
    $result = mysql_fetch_array($query, MYSQL_ASSOC);

    $this->payment_element = $result['payment_element'];
    $this->_tbl_lang = '#__virtuemart_paymentmethods_en_gb';

    $params = explode("|", $result['payment_params']);

    foreach($params as $param) {
      if($param != "") {
        $value = explode("=", $param);
        $this->{$value[0]} = str_replace("\"", "", $value[1]);
      }
    }
  }
}

class app {
  function redirect($link, $text) {
    $_SESSION['message'] = $text;
  }
}

class VirtueMartCart {

  public $BT;

  function setCountry($id) {
    $this->BT = is_int($id) ? array('virtuemart_country_id' => '['.$id.']') : array();
  }

  function emptyCart() {
    // do nothing
  }
}

class orders {

  function updateStatusForOneOrder($orderId, $config, $bool) {
    // do nothing
  }

  function _updateOrderHist($id, $order, $notify, $comment) {
    // do nothing
  }


  function getOrder($id) {

    $order = array('details' => array());
    $order['details']['BT'] = new bt;
    $order['details']['BT']->setEmail("foo@bar.com");
    $order['details']['BT']->setAddress1("Musterstr. 1a");
    $order['details']['BT']->setZip("12345");
    $order['details']['BT']->setCity("Musterstadt");
    $order['details']['BT']->setOrderId(1);
    $order['details']['BT']->setOrderStatus('paid');
    $order['details']['BT']->setAmount("24.95");
    $order['details']['BT']->setVmOrderId(1);
    $order['details']['BT']->setPaymentmethod(1);
    $order['details']['BT']->setCountryId('41');

    return $order;
  }
}

class VmModel {

  static function getModel($model) {
    return new $model;
  }
}

class CurrencyDisplay {
  static function getInstance($instance = null) {
    return new paymentCurrency;
  }
}

class ShopFunctions {
  static function getCountryByID($countryId, $type = 'country_2_code') {
    return "DE";
  }
}

class paymentCurrency {

  function convertCurrencyTo($currency = "EUR", $order_total, $bla = false) {
    return $order_total;
  }
}
