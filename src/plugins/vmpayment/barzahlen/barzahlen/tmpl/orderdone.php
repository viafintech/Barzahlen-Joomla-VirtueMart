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
?>

<iframe src="<?php echo $viewData["PaymentSlipLink"]; ?>" width="0" height="1" frameborder="0"></iframe>
<img src="http://cdn.barzahlen.de/images/barzahlen_logo.png" height="57" width="168" alt="" style="padding:0; margin:0; margin-bottom: 10px;"/>
<hr/>

<br/>
<div style="width:100%;">
  <div style="position: relative; float: left; width: 180px; text-align: center;">
    <a href="<?php echo $viewData["PaymentSlipLink"]; ?>" target="_blank" style="color: #63A924; text-decoration: none; font-size: 1.2em;">
      <img src="http://cdn.barzahlen.de/images/barzahlen_checkout_success_payment_slip.png" height="192" width="126" alt="" style="margin-bottom: 5px;"/><br/>
      <strong>Download PDF</strong>
    </a>
  </div>

  <span style="font-weight: bold; color: #63A924; font-size: 1.5em;"><?php echo $viewData["SuccessTitle"]; ?></span>
  <p><?php echo $viewData["Infotext1"]; ?></p>
  <p><?php echo $viewData["ExpirationNotice"]; ?></p>
  <div style="width:100%;">
    <div style="position: relative; float: left; width: 50px;"><img src="http://cdn.barzahlen.de/images/barzahlen_mobile.png" height="52" width="41" alt="" style="float: left;"/></div>
    <p><?php echo $viewData["Infotext2"]; ?></p>
  </div>

  <br style="clear:both;" /><br/>
</div>
<hr/><br/>