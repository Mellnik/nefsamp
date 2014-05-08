/*
Navicat MySQL Data Transfer

Source Server         : dev
Source Server Version : 50169
Source Host           : 176.28.51.84:3306
Source Database       : stuntevodev

Target Server Type    : MYSQL
Target Server Version : 50169
File Encoding         : 65001

Date: 2013-06-09 21:42:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `viporder`
-- ----------------------------
DROP TABLE IF EXISTS `viporder`;
CREATE TABLE `viporder` (
  `ID` mediumint(6) unsigned NOT NULL AUTO_INCREMENT,
  `txn_id` varchar(17) NOT NULL,
  `receiver` varchar(24) NOT NULL,
  `payment` varchar(10) NOT NULL,
  `method` tinyint(1) NOT NULL,
  `issue` varchar(20) NOT NULL DEFAULT 'NONE',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of viporder
-- ----------------------------
