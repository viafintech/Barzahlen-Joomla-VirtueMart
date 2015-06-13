<?php
/**
 * Barzahlen Payment Module (ViruteMart)
 *
 * @copyright   Copyright (c) 2015 Cash Payment Solutions GmbH (https://www.barzahlen.de)
 * @author      Alexander Diebler
 * @license     http://opensource.org/licenses/GPL-3.0  GNU General Public License, version 3 (GPL-3.0)
 */

defined('_JEXEC') or die('Restricted access');

$callback = JURI::root () . 'administrator/index.php?option=com_virtuemart&view=plugin&type=vmpayment&name=barzahlen';
?>

<form action="<?php echo $callback; ?>" method="post" style="display: inline; margin-left: 5px;">
  <input type="hidden" name="action" value="<?php echo $viewData['action']; ?>"/>
  <input type="hidden" name="vm_order_id" value="<?php echo $viewData['vm_order_id']; ?>"/>
  <input type="hidden" name="vm_method_id" value="<?php echo $viewData['vm_method_id']; ?>"/>
  <input type="hidden" name="transaction_id" value="<?php echo $viewData['transaction_id']; ?>"/>
  <input type="submit" value="<?php echo $viewData['button']; ?>"/>
</form>
