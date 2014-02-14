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

$url = $viewData['group'] == 'admin' ? 'https://www.barzahlen.de/merchant-area/' : 'http://www.barzahlen.de/';
?>

<a href="<? echo $url; ?>" target="_blank" style="color: #63A924; font-weight: bold;">
  <img src="http://cdn.barzahlen.de/images/barzahlen_logo.png" width="<?php echo $viewData['width']; ?>" alt="" style="<?php echo $viewData['style']; ?>"/>
</a>