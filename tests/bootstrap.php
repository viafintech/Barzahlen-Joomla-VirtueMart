<?php
  define('DB_HOST','localhost');
  define('DB_USER','joomla');
  define('DB_PASSWORD','joomla');
  define('DB_NAME','joomla_test');
  define('DB_PREFIX', 't8pdr_');
  define('_JEXEC', true);

  define('DS', '/');
  define('JPATH_ROOT', 'src/');
  define('JPATH_VM_PLUGINS', 'plugins');
  define('JPATH_VM_ADMINISTRATOR', 'plugins');
  define('JPATH_PLUGINS', 'src/plugins');

  define('VMPAYMENT_BARZAHLEN_RESEND_SUCCESS', 'Resend ok.');
  define('VMPAYMENT_BARZAHLEN_RESEND_FAILURE', 'Resend fail.');
  define('VMPAYMENT_BARZAHLEN_REFUND_SUCCESS', 'Refund ok.');
  define('VMPAYMENT_BARZAHLEN_REFUND_FAILURE', 'Refund fail.');
  define('VMPAYMENT_BARZAHLEN_BE_ACTION_FAILURE', 'BE action unknown.');

  require_once 'plugins/joomla.php';
  require_once 'plugins/virtuemart.php';
  require_once 'plugins/vmpsplugin.php';
  require_once 'libraries/helper.php';

  /**
   * DB-Handler
   */
  class db_handler {

    /**
     * Sets up database before every test.
     */
    public function __construct() {
      exec('mysql -h' . DB_HOST . ' -u' . DB_USER . ' --password=' . DB_PASSWORD . ' ' . DB_NAME . '< tests/joomla_test.sql');

      mysql_connect('localhost',DB_USER,DB_PASSWORD);
      mysql_select_db(DB_NAME);
    }

    /**
     * Removes all database data after a test.
     */
    public function __destruct() {

      $delete = mysql_query("TRUNCATE TABLE " . DB_PREFIX . "virtuemart_currencies");
      $delete = mysql_query("TRUNCATE TABLE " . DB_PREFIX . "virtuemart_orders");
      $delete = mysql_query("TRUNCATE TABLE " . DB_PREFIX . "virtuemart_orderstates");
      $delete = mysql_query("TRUNCATE TABLE " . DB_PREFIX . "virtuemart_order_histories");
      $delete = mysql_query("TRUNCATE TABLE " . DB_PREFIX . "virtuemart_paymentmethods");
      $delete = mysql_query("TRUNCATE TABLE " . DB_PREFIX . "virtuemart_payment_plg_barzahlen");
      $delete = mysql_query("TRUNCATE TABLE " . DB_PREFIX . "virtuemart_payment_plg_barzahlen_refund");
      mysql_close();
    }
  }
?>
