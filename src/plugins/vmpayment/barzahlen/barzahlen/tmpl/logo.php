<?php
/**
 * Barzahlen Payment Module (ViruteMart)
 *
 * @copyright   Copyright (c) 2015 Cash Payment Solutions GmbH (https://www.barzahlen.de)
 * @author      Alexander Diebler
 * @license     http://opensource.org/licenses/GPL-3.0  GNU General Public License, version 3 (GPL-3.0)
 */

defined('_JEXEC') or die('Restricted access');

$url = $viewData['group'] == 'admin' ? 'https://partner.barzahlen.de' : 'http://www.barzahlen.de/';
?>

<a href="<? echo $url; ?>" target="_blank" style="color: #63A924; font-weight: bold;">
  <img src="https://cdn.barzahlen.de/images/barzahlen_logo.png" width="<?php echo $viewData['width']; ?>" alt="" style="<?php echo $viewData['style']; ?>"/>
</a>
