-- phpMyAdmin SQL Dump
-- version 3.3.9.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Erstellungszeit: 02. Juli 2012 um 17:16
-- Server Version: 5.5.9
-- PHP-Version: 5.3.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Datenbank: `joomla_test`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `t8pdr_virtuemart_currencies`
--

CREATE TABLE IF NOT EXISTS `t8pdr_virtuemart_currencies` (
  `virtuemart_currency_id` smallint(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_vendor_id` smallint(1) unsigned NOT NULL DEFAULT '1',
  `currency_name` char(64) DEFAULT NULL,
  `currency_code_2` char(2) DEFAULT NULL,
  `currency_code_3` char(3) DEFAULT NULL,
  `currency_numeric_code` int(4) DEFAULT NULL,
  `currency_exchange_rate` decimal(10,5) DEFAULT NULL,
  `currency_symbol` char(4) DEFAULT NULL,
  `currency_decimal_place` char(4) DEFAULT NULL,
  `currency_decimal_symbol` char(4) DEFAULT NULL,
  `currency_thousands` char(4) DEFAULT NULL,
  `currency_positive_style` char(64) DEFAULT NULL,
  `currency_negative_style` char(64) DEFAULT NULL,
  `ordering` int(2) NOT NULL DEFAULT '0',
  `shared` tinyint(1) NOT NULL DEFAULT '1',
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_currency_id`),
  KEY `virtuemart_vendor_id` (`virtuemart_vendor_id`),
  KEY `idx_currency_code_3` (`currency_code_3`),
  KEY `idx_currency_numeric_code` (`currency_numeric_code`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Used to store currencies' AUTO_INCREMENT=202 ;

--
-- Daten für Tabelle `t8pdr_virtuemart_currencies`
--

INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(2, 1, 'United Arab Emirates dirham', '', 'AED', 784, 0.00000, 'د.إ', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(4, 1, 'Albanian lek', '', 'ALL', 8, 0.00000, 'Lek', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(5, 1, 'Netherlands Antillean gulden', '', 'ANG', 532, 0.00000, 'ƒ', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(7, 1, 'Argentine peso', '', 'ARS', 32, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(9, 1, 'Australian dollar', '', 'AUD', 36, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(10, 1, 'Aruban florin', '', 'AWG', 533, 0.00000, 'ƒ', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(11, 1, 'Barbadian dollar', '', 'BBD', 52, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(12, 1, 'Bangladeshi taka', '', 'BDT', 50, 0.00000, '৳', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(15, 1, 'Bahraini dinar', '', 'BHD', 48, 0.00000, 'ب.د', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(16, 1, 'Burundian franc', '', 'BIF', 108, 0.00000, 'Fr', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(17, 1, 'Bermudian dollar', '', 'BMD', 60, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(18, 1, 'Brunei dollar', '', 'BND', 96, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(19, 1, 'Bolivian boliviano', '', 'BOB', 68, 0.00000, '$b', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(20, 1, 'Brazilian real', '', 'BRL', 986, 0.00000, 'R$', '2', '.', ',', '{symbol} {number}', '{symbol} {sign}{number}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(21, 1, 'Bahamian dollar', '', 'BSD', 44, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(22, 1, 'Bhutanese ngultrum', '', 'BTN', 64, 0.00000, 'BTN', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(24, 1, 'Botswana pula', '', 'BWP', 72, 0.00000, 'P', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(25, 1, 'Belize dollar', '', 'BZD', 84, 0.00000, 'BZ$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(26, 1, 'Canadian dollar', '', 'CAD', 124, 0.00000, '$', '2', '.', ',', '{symbol}{number}', '{symbol}{sign}{number}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(27, 1, 'Swiss franc', '', 'CHF', 756, 0.00000, 'CHF', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(28, 1, 'Unidad de Fomento', '', 'CLF', 990, 0.00000, 'CLF', '0', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(29, 1, 'Chilean peso', '', 'CLP', 152, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(30, 1, 'Chinese renminbi yuan', '', 'CNY', 156, 0.00000, '元', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(31, 1, 'Colombian peso', '', 'COP', 170, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(32, 1, 'Costa Rican colón', '', 'CRC', 188, 0.00000, '₡', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(33, 1, 'Czech koruna', '', 'CZK', 203, 0.00000, 'Kč', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(34, 1, 'Cuban peso', '', 'CUP', 192, 0.00000, '₱', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(35, 1, 'Cape Verdean escudo', '', 'CVE', 132, 0.00000, '$', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(40, 1, 'Danish krone', '', 'DKK', 208, 0.00000, 'kr', '2', '.', ',', '{symbol}{number}', '{symbol}{sign}{number}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(41, 1, 'Dominican peso', '', 'DOP', 214, 0.00000, 'RD$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(42, 1, 'Algerian dinar', '', 'DZD', 12, 0.00000, 'د.ج', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(44, 1, 'Egyptian pound', '', 'EGP', 818, 0.00000, '£', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(46, 1, 'Ethiopian birr', '', 'ETB', 230, 0.00000, 'ETB', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(47, 1, 'Euro', '', 'EUR', 978, 0.00000, '€', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(49, 1, 'Fijian dollar', '', 'FJD', 242, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(50, 1, 'Falkland pound', '', 'FKP', 238, 0.00000, '£', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(52, 1, 'British pound', '', 'GBP', 826, 0.00000, '£', '2', '.', ',', '{symbol}{number}', '{symbol}{sign}{number}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(54, 1, 'Gibraltar pound', '', 'GIP', 292, 0.00000, '£', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(55, 1, 'Gambian dalasi', '', 'GMD', 270, 0.00000, 'D', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(56, 1, 'Guinean franc', '', 'GNF', 324, 0.00000, 'Fr', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(58, 1, 'Guatemalan quetzal', '', 'GTQ', 320, 0.00000, 'Q', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(60, 1, 'Guyanese dollar', '', 'GYD', 328, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(61, 1, 'Hong Kong dollar', '', 'HKD', 344, 0.00000, '元', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(62, 1, 'Honduran lempira', '', 'HNL', 340, 0.00000, 'L', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(63, 1, 'Haitian gourde', '', 'HTG', 332, 0.00000, 'G', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(64, 1, 'Hungarian forint', '', 'HUF', 348, 0.00000, 'Ft', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(65, 1, 'Indonesian rupiah', '', 'IDR', 360, 0.00000, 'Rp', '0', '', '', '{symbol}{number}', '{symbol}{sign}{number}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(67, 1, 'Israeli new sheqel', '', 'ILS', 376, 0.00000, '₪', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(68, 1, 'Indian rupee', '', 'INR', 356, 0.00000, '₨', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(69, 1, 'Iraqi dinar', '', 'IQD', 368, 0.00000, 'ع.د', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(70, 1, 'Iranian rial', '', 'IRR', 364, 0.00000, '﷼', '2', ',', '', '{number} {symbol}', '{sign}{number}{symb0l}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(73, 1, 'Jamaican dollar', '', 'JMD', 388, 0.00000, 'J$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(74, 1, 'Jordanian dinar', '', 'JOD', 400, 0.00000, 'د.ا', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(75, 1, 'Japanese yen', '', 'JPY', 392, 0.00000, '¥', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(76, 1, 'Kenyan shilling', '', 'KES', 404, 0.00000, 'Sh', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(77, 1, 'Cambodian riel', '', 'KHR', 116, 0.00000, '៛', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(78, 1, 'Comorian franc', '', 'KMF', 174, 0.00000, 'Fr', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(79, 1, 'North Korean won', '', 'KPW', 408, 0.00000, '₩', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(80, 1, 'South Korean won', '', 'KRW', 410, 0.00000, '₩', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(81, 1, 'Kuwaiti dinar', '', 'KWD', 414, 0.00000, 'د.ك', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(82, 1, 'Cayman Islands dollar', '', 'KYD', 136, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(83, 1, 'Lao kip', '', 'LAK', 418, 0.00000, '₭', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(84, 1, 'Lebanese pound', '', 'LBP', 422, 0.00000, '£', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(85, 1, 'Sri Lankan rupee', '', 'LKR', 144, 0.00000, '₨', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(86, 1, 'Liberian dollar', '', 'LRD', 430, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(87, 1, 'Lesotho loti', '', 'LSL', 426, 0.00000, 'L', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(89, 1, 'Libyan dinar', '', 'LYD', 434, 0.00000, 'ل.د', '3', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(90, 1, 'Moroccan dirham', '', 'MAD', 504, 0.00000, 'د.م.', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(92, 1, 'Mongolian tögrög', '', 'MNT', 496, 0.00000, '₮', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(93, 1, 'Macanese pataca', '', 'MOP', 446, 0.00000, 'P', '1', ',', '', '{symbol}{number}', '{symbol}{sign}{number}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(94, 1, 'Mauritanian ouguiya', '', 'MRO', 478, 0.00000, 'UM', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(96, 1, 'Mauritian rupee', '', 'MUR', 480, 0.00000, '₨', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(97, 1, 'Maldivian rufiyaa', '', 'MVR', 462, 0.00000, 'ރ.', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(98, 1, 'Malawian kwacha', '', 'MWK', 454, 0.00000, 'MK', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(100, 1, 'Malaysian ringgit', '', 'MYR', 458, 0.00000, 'RM', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(102, 1, 'Nigerian naira', '', 'NGN', 566, 0.00000, '₦', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(105, 1, 'Norwegian krone', '', 'NOK', 578, 0.00000, 'kr', '2', ',', '', '{symbol}{number}', '{symbol}{sign}{number}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(106, 1, 'Nepalese rupee', '', 'NPR', 524, 0.00000, '₨', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(107, 1, 'New Zealand dollar', '', 'NZD', 554, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(108, 1, 'Omani rial', '', 'OMR', 512, 0.00000, '﷼', '3', '.', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(109, 1, 'Panamanian balboa', '', 'PAB', 590, 0.00000, 'B/.', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(110, 1, 'Peruvian nuevo sol', '', 'PEN', 604, 0.00000, 'S/.', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(111, 1, 'Papua New Guinean kina', '', 'PGK', 598, 0.00000, 'K', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(112, 1, 'Philippine peso', '', 'PHP', 608, 0.00000, '₱', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(113, 1, 'Pakistani rupee', '', 'PKR', 586, 0.00000, '₨', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(114, 1, 'Polish Złoty', '', 'PLN', 985, 0.00000, 'zł', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(116, 1, 'Paraguayan guaraní', '', 'PYG', 600, 0.00000, '₲', '0', '', '.', '{symbol} {number}', '{symbol} {sign}{number}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(117, 1, 'Qatari riyal', '', 'QAR', 634, 0.00000, '﷼', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(118, 1, 'Romanian leu', '', 'RON', 946, 0.00000, 'lei', '2', ',', '.', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(119, 1, 'Rwandan franc', '', 'RWF', 646, 0.00000, 'Fr', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(120, 1, 'Saudi riyal', '', 'SAR', 682, 0.00000, '﷼', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(121, 1, 'Solomon Islands dollar', '', 'SBD', 90, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(122, 1, 'Seychellois rupee', '', 'SCR', 690, 0.00000, '₨', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(124, 1, 'Swedish krona', '', 'SEK', 752, 0.00000, 'kr', '2', ',', '.', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(125, 1, 'Singapore dollar', '', 'SGD', 702, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(126, 1, 'Saint Helenian pound', '', 'SHP', 654, 0.00000, '£', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(127, 1, 'Sierra Leonean leone', '', 'SLL', 694, 0.00000, 'Le', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(128, 1, 'Somali shilling', '', 'SOS', 706, 0.00000, 'S', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(130, 1, 'São Tomé and Príncipe dobra', '', 'STD', 678, 0.00000, 'Db', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(131, 1, 'Russian ruble', '', 'RUB', 643, 0.00000, 'руб', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(132, 1, 'Salvadoran colón', '', 'SVC', 222, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(133, 1, 'Syrian pound', '', 'SYP', 760, 0.00000, '£', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(134, 1, 'Swazi lilangeni', '', 'SZL', 748, 0.00000, 'L', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(135, 1, 'Thai baht', '', 'THB', 764, 0.00000, '฿', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(136, 1, 'Tunisian dinar', '', 'TND', 788, 0.00000, 'د.ت', '3', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(137, 1, 'Tongan paʻanga', '', 'TOP', 776, 0.00000, 'T$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(139, 1, 'Turkish new lira', '', 'TRY', 949, 0.00000, 'YTL', '2', ',', '.', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(140, 1, 'Trinidad and Tobago dollar', '', 'TTD', 780, 0.00000, 'TT$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(141, 1, 'New Taiwan dollar', '', 'TWD', 901, 0.00000, 'NT$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(142, 1, 'Tanzanian shilling', '', 'TZS', 834, 0.00000, 'Sh', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(144, 1, 'United States dollar', '', 'USD', 840, 0.00000, '$', '2', '.', ',', '{symbol}{number}', '{symbol}{sign}{number}', 0, 0, 1, '0000-00-00 00:00:00', 0, '2012-06-26 14:28:36', 42, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(147, 1, 'Vietnamese Dong', '', 'VND', 704, 0.00000, '₫', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(148, 1, 'Vanuatu vatu', '', 'VUV', 548, 0.00000, 'Vt', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(149, 1, 'Samoan tala', '', 'WST', 882, 0.00000, 'T', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(151, 1, 'Yemeni rial', '', 'YER', 886, 0.00000, '﷼', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(152, 1, 'Serbian dinar', '', 'RSD', 941, 0.00000, 'Дин.', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(153, 1, 'South African rand', '', 'ZAR', 710, 0.00000, 'R', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(154, 1, 'Zambian kwacha', '', 'ZMK', 894, 0.00000, 'ZK', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(156, 1, 'Zimbabwean dollar', '', 'ZWD', 932, 0.00000, 'Z$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(158, 1, 'Armenian dram', '', 'AMD', 51, 0.00000, 'դր.', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(159, 1, 'Myanmar kyat', '', 'MMK', 104, 0.00000, 'K', '2', ',', '', '{number} {symbol}', '{symbol} {sign}{number}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(160, 1, 'Croatian kuna', '', 'HRK', 191, 0.00000, 'kn', '2', ',', '.', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(161, 1, 'Eritrean nakfa', '', 'ERN', 232, 0.00000, 'Nfk', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(162, 1, 'Djiboutian franc', '', 'DJF', 262, 0.00000, 'Fr', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(163, 1, 'Icelandic króna', '', 'ISK', 352, 0.00000, 'kr', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(164, 1, 'Kazakhstani tenge', '', 'KZT', 398, 0.00000, 'лв', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(165, 1, 'Kyrgyzstani som', '', 'KGS', 417, 0.00000, 'лв', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(166, 1, 'Latvian lats', '', 'LVL', 428, 0.00000, 'Ls', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(167, 1, 'Lithuanian litas', '', 'LTL', 440, 0.00000, 'Lt', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(168, 1, 'Mexican peso', '', 'MXN', 484, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(169, 1, 'Moldovan leu', '', 'MDL', 498, 0.00000, 'L', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(170, 1, 'Namibian dollar', '', 'NAD', 516, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(171, 1, 'Nicaraguan córdoba', '', 'NIO', 558, 0.00000, 'C$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(172, 1, 'Ugandan shilling', '', 'UGX', 800, 0.00000, 'Sh', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(173, 1, 'Macedonian denar', '', 'MKD', 807, 0.00000, 'ден', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(174, 1, 'Uruguayan peso', '', 'UYU', 858, 0.00000, '$', '0', '', '', '{symbol}number}', '{symbol}{sign}{number}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(175, 1, 'Uzbekistani som', '', 'UZS', 860, 0.00000, 'лв', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(176, 1, 'Azerbaijani manat', '', 'AZN', 934, 0.00000, 'ман', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(177, 1, 'Ghanaian cedi', '', 'GHS', 936, 0.00000, '₵', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(178, 1, 'Venezuelan bolívar', '', 'VEF', 937, 0.00000, 'Bs', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(179, 1, 'Sudanese pound', '', 'SDG', 938, 0.00000, '£', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(180, 1, 'Uruguay Peso', '', 'UYI', 940, 0.00000, 'UYI', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(181, 1, 'Mozambican metical', '', 'MZN', 943, 0.00000, 'MT', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(182, 1, 'WIR Euro', '', 'CHE', 947, 0.00000, '€', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(183, 1, 'WIR Franc', '', 'CHW', 948, 0.00000, 'CHW', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(184, 1, 'Central African CFA franc', '', 'XAF', 950, 0.00000, 'Fr', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(185, 1, 'East Caribbean dollar', '', 'XCD', 951, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(186, 1, 'West African CFA franc', '', 'XOF', 952, 0.00000, 'Fr', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(187, 1, 'CFP franc', '', 'XPF', 953, 0.00000, 'Fr', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(188, 1, 'Surinamese dollar', '', 'SRD', 968, 0.00000, '$', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(189, 1, 'Malagasy ariary', '', 'MGA', 969, 0.00000, 'MGA', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(190, 1, 'Unidad de Valor Real', '', 'COU', 970, 0.00000, 'COU', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(191, 1, 'Afghan afghani', '', 'AFN', 971, 0.00000, '؋', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(192, 1, 'Tajikistani somoni', '', 'TJS', 972, 0.00000, 'ЅМ', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(193, 1, 'Angolan kwanza', '', 'AOA', 973, 0.00000, 'Kz', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(194, 1, 'Belarusian ruble', '', 'BYR', 974, 0.00000, 'p.', '0', '', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 0, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(195, 1, 'Bulgarian lev', '', 'BGN', 975, 0.00000, 'лв', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(196, 1, 'Congolese franc', '', 'CDF', 976, 0.00000, 'Fr', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(197, 1, 'Bosnia and Herzegovina convert', '', 'BAM', 977, 0.00000, 'KM', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(198, 1, 'Mexican Unid', '', 'MXV', 979, 0.00000, 'MXV', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(199, 1, 'Ukrainian hryvnia', '', 'UAH', 980, 0.00000, '₴', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(200, 1, 'Georgian lari', '', 'GEL', 981, 0.00000, 'ლ', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_currencies` VALUES(201, 1, 'Mvdol', '', 'BOV', 984, 0.00000, 'BOV', '2', ',', '', '{number} {symbol}', '{sign}{number} {symbol}', 0, 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `t8pdr_virtuemart_orders`
--

CREATE TABLE IF NOT EXISTS `t8pdr_virtuemart_orders` (
  `virtuemart_order_id` int(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_user_id` int(1) unsigned NOT NULL DEFAULT '0',
  `virtuemart_vendor_id` smallint(1) unsigned NOT NULL DEFAULT '0',
  `order_number` char(64) DEFAULT NULL,
  `order_pass` char(8) DEFAULT NULL,
  `order_total` decimal(15,5) NOT NULL DEFAULT '0.00000',
  `order_salesPrice` decimal(15,5) NOT NULL DEFAULT '0.00000',
  `order_billTaxAmount` decimal(15,5) NOT NULL DEFAULT '0.00000',
  `order_billDiscountAmount` decimal(15,5) NOT NULL DEFAULT '0.00000',
  `order_discountAmount` decimal(15,5) NOT NULL DEFAULT '0.00000',
  `order_subtotal` decimal(15,5) DEFAULT NULL,
  `order_tax` decimal(10,5) DEFAULT NULL,
  `order_shipment` decimal(10,2) DEFAULT NULL,
  `order_shipment_tax` decimal(10,5) DEFAULT NULL,
  `order_payment` decimal(10,2) DEFAULT NULL,
  `order_payment_tax` decimal(10,5) DEFAULT NULL,
  `coupon_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `coupon_code` char(32) DEFAULT NULL,
  `order_discount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `order_currency` smallint(1) DEFAULT NULL,
  `order_status` char(1) DEFAULT NULL,
  `user_currency_id` char(4) DEFAULT NULL,
  `user_currency_rate` decimal(10,5) NOT NULL DEFAULT '1.00000',
  `virtuemart_paymentmethod_id` mediumint(1) unsigned DEFAULT NULL,
  `virtuemart_shipmentmethod_id` mediumint(1) unsigned DEFAULT NULL,
  `customer_note` text,
  `ip_address` char(15) NOT NULL DEFAULT '',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_order_id`),
  KEY `idx_orders_virtuemart_user_id` (`virtuemart_user_id`),
  KEY `idx_orders_virtuemart_vendor_id` (`virtuemart_vendor_id`),
  KEY `idx_orders_order_number` (`order_number`),
  KEY `idx_orders_virtuemart_paymentmethod_id` (`virtuemart_paymentmethod_id`),
  KEY `idx_orders_virtuemart_shipmentmethod_id` (`virtuemart_shipmentmethod_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Used to store all orders' AUTO_INCREMENT=5 ;

--
-- Daten für Tabelle `t8pdr_virtuemart_orders`
--

INSERT IGNORE INTO `t8pdr_virtuemart_orders` VALUES(1, 42, 1, '1', 'p_66091', 24.95, 24.95, 4.95, 0.00000, 0.00000, 24.95, 4.95, 0.00, 0.00000, 0.00, 0.00000, 0.00, NULL, 0.00, 47, 'P', '47', 1.00000, 1, 2, '', '127.0.0.1', '2012-06-28 09:54:21', 43, '2012-06-28 09:54:21', 43, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_orders` VALUES(2, 42, 1, '2', 'p_242b8', 24.95, 24.95, 4.95, 0.00000, 0.00000, 24.95, 4.95, 0.00, 0.00000, 0.00, 0.00000, 0.00, NULL, 0.00, 47, 'C', '47', 1.00000, 1, 2, '', '127.0.0.1', '2012-07-02 12:22:11', 43, '2012-07-02 12:22:11', 43, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_orders` VALUES(3, 42, 1, '3', 'p_d3664', 24.95, 24.95, 4.95, 0.00000, 0.00000, 24.95, 4.95, 0.00, 0.00000, 0.00, 0.00000, 0.00, NULL, 0.00, 47, 'X', '47', 1.00000, 1, 2, '', '127.0.0.1', '2012-06-28 10:41:12', 43, '2012-06-28 10:41:12', 43, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_orders` VALUES(4, 42, 1, '4', 'p_242c8', 24.95, 24.95, 4.95, 0.00000, 0.00000, 24.95, 4.95, 0.00, 0.00000, 0.00, 0.00000, 0.00, NULL, 0.00, 47, 'C', '47', 1.00000, 1, 2, '', '127.0.0.1', '2012-07-02 12:22:11', 43, '2012-07-02 12:22:11', 43, '0000-00-00 00:00:00', 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `t8pdr_virtuemart_orderstates`
--

CREATE TABLE IF NOT EXISTS `t8pdr_virtuemart_orderstates` (
  `virtuemart_orderstate_id` tinyint(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_vendor_id` smallint(11) NOT NULL DEFAULT '1',
  `order_status_code` char(1) NOT NULL DEFAULT '',
  `order_status_name` char(64) DEFAULT NULL,
  `order_status_description` text,
  `order_stock_handle` char(1) NOT NULL DEFAULT 'A',
  `ordering` int(2) NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_orderstate_id`),
  KEY `idx_order_status_ordering` (`ordering`),
  KEY `idx_order_status_virtuemart_vendor_id` (`virtuemart_vendor_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='All available order statuses' AUTO_INCREMENT=6 ;

--
-- Daten für Tabelle `t8pdr_virtuemart_orderstates`
--

INSERT IGNORE INTO `t8pdr_virtuemart_orderstates` VALUES(1, 1, 'P', 'Pending', '', 'R', 1, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_orderstates` VALUES(2, 1, 'C', 'Confirmed', '', 'R', 2, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_orderstates` VALUES(3, 1, 'X', 'Cancelled', '', 'A', 3, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_orderstates` VALUES(4, 1, 'R', 'Refunded', '', 'A', 4, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_orderstates` VALUES(5, 1, 'S', 'Shipped', '', 'O', 5, 1, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `t8pdr_virtuemart_order_histories`
--

CREATE TABLE IF NOT EXISTS `t8pdr_virtuemart_order_histories` (
  `virtuemart_order_history_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_order_id` int(1) unsigned NOT NULL DEFAULT '0',
  `order_status_code` char(1) NOT NULL DEFAULT '0',
  `customer_notified` tinyint(1) NOT NULL DEFAULT '0',
  `comments` text,
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_order_history_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores all actions and changes that occur to an order' AUTO_INCREMENT=1 ;

--
-- Daten für Tabelle `t8pdr_virtuemart_order_histories`
--


-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `t8pdr_virtuemart_paymentmethods`
--

CREATE TABLE IF NOT EXISTS `t8pdr_virtuemart_paymentmethods` (
  `virtuemart_paymentmethod_id` mediumint(1) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_vendor_id` smallint(11) NOT NULL DEFAULT '1',
  `payment_jplugin_id` int(11) NOT NULL DEFAULT '0',
  `slug` char(255) NOT NULL DEFAULT '',
  `payment_element` char(50) NOT NULL DEFAULT '',
  `payment_params` text,
  `shared` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'valide for all vendors?',
  `ordering` int(2) NOT NULL DEFAULT '0',
  `published` tinyint(1) NOT NULL DEFAULT '1',
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`virtuemart_paymentmethod_id`),
  KEY `idx_payment_jplugin_id` (`payment_jplugin_id`),
  KEY `idx_payment_method_ordering` (`ordering`),
  KEY `idx_payment_element` (`payment_element`,`virtuemart_vendor_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='The payment methods of your store' AUTO_INCREMENT=2 ;

--
-- Daten für Tabelle `t8pdr_virtuemart_paymentmethods`
--

INSERT IGNORE INTO `t8pdr_virtuemart_paymentmethods` VALUES(1, 1, 839, '', 'barzahlen', 'payment_logos=["barzahlen.png"]|sandbox="1"|debug="0"|shop_id="11046"|payment_key="210a6f440a5c2b1252a6cedf06e40d8a9dfaf19f"|notification_key="947feb222dc8c731e58946d051c50e88e578d24c"|payment_pending_status="P"|payment_paid_status="C"|payment_expired_status="X"|payment_denied_status="X"|min_amount="0"|max_amount="1000"|payment_currency="47"|countries=["81"]|', 0, 1, 1, '0000-00-00 00:00:00', 0, '2012-06-28 10:49:18', 42, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_paymentmethods` VALUES(2, 1, 826, '', 'paypal', 'paypal_merchant_email="your-PayPal-Merchant-email@domain.com"|paypal_verified_only="0"|payment_currency="0"|sandbox="0"|sandbox_merchant_email="your-PayPal-Sandbox-Merchant-email@domain.com"|payment_logos=""|debug="0"|status_pending="P"|status_success="C"|status_canceled="X"|countries=""|min_amount=""|max_amount=""|secure_post=""|ipn_test=""|no_shipping="0"|address_override="0"|cost_per_transaction=""|cost_percent_total=""|tax_id="0"|', 0, 2, 1, '0000-00-00 00:00:00', 0, '2012-06-28 10:49:18', 42, '0000-00-00 00:00:00', 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `t8pdr_virtuemart_payment_plg_barzahlen`
--

CREATE TABLE IF NOT EXISTS `t8pdr_virtuemart_payment_plg_barzahlen` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `virtuemart_order_id` int(11) unsigned DEFAULT NULL,
  `virtuemart_paymentmethod_id` int(11) unsigned DEFAULT NULL,
  `payment_name` varchar(500) DEFAULT NULL,
  `transaction_id` int(11) NOT NULL,
  `order_number` varchar(64) NOT NULL,
  `amount` decimal(6,2) NOT NULL,
  `currency` varchar(3) NOT NULL,
  `state` varchar(7) NOT NULL,
  `created_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `created_by` int(11) NOT NULL DEFAULT '0',
  `modified_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `modified_by` int(11) NOT NULL DEFAULT '0',
  `locked_on` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked_by` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Payment Barzahlen Table' AUTO_INCREMENT=4 ;

--
-- Daten für Tabelle `t8pdr_virtuemart_payment_plg_barzahlen`
--

INSERT IGNORE INTO `t8pdr_virtuemart_payment_plg_barzahlen` VALUES(1, 1, 1, 'Barzahlen', 1, '1', 24.95, 'EUR', 'pending', '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_payment_plg_barzahlen` VALUES(2, 2, 1, 'Barzahlen', 2, '2', 24.95, 'EUR', 'paid', '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_payment_plg_barzahlen` VALUES(3, 3, 1, 'Barzahlen', 3, '3', 24.95, 'EUR', 'expired', '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);
INSERT IGNORE INTO `t8pdr_virtuemart_payment_plg_barzahlen` VALUES(4, 4, 1, 'Barzahlen', 4, '4', 24.95, 'EUR', 'paid', '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0, '0000-00-00 00:00:00', 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `t8pdr_virtuemart_payment_plg_barzahlen_refund`
--

CREATE TABLE IF NOT EXISTS `t8pdr_virtuemart_payment_plg_barzahlen_refund` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `refund_transaction_id` int(11) unsigned DEFAULT NULL,
  `origin_transaction_id` int(11) unsigned DEFAULT NULL,
  `amount` decimal(6,2) NOT NULL,
  `currency` varchar(3) NOT NULL,
  `state` varchar(9) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Barzahlen Refund Table' AUTO_INCREMENT=1 ;

--
-- Daten für Tabelle `t8pdr_virtuemart_payment_plg_barzahlen_refund`
--

INSERT IGNORE INTO `t8pdr_virtuemart_payment_plg_barzahlen_refund` VALUES(1, 1, 2, 24.95, 'EUR', 'pending');
