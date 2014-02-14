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

/**
 * JFactory
 */
class JFactory {

  static function getDBO () {
    return new db;
  }

  static function getApplication() {
    return new app;
  }
}

/**
 *
 */
class JRoute {

  static function _($link) {
    return $link;
  }
}

/**
 *
 */
class JRequest {
  static function setVar ($var, $value) {
    $_SESSION[$var] = $value;
  }
}

/**
 *
 */
class JText {

  static function _($text) {
    return $text;
  }

  static function sprintf($text) {
    return $text;
  }
}