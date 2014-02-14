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
