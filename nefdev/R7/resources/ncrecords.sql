/*
Navicat MySQL Data Transfer

Source Server         : dev
Source Server Version : 50169
Source Host           : 176.28.51.84:3306
Source Database       : stuntevodev

Target Server Type    : MYSQL
Target Server Version : 50169
File Encoding         : 65001

Date: 2013-06-09 21:43:32
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `ncrecords`
-- ----------------------------
DROP TABLE IF EXISTS `ncrecords`;
CREATE TABLE `ncrecords` (
  `ID` mediumint(6) unsigned NOT NULL AUTO_INCREMENT,
  `OldName` varchar(24) NOT NULL,
  `NewName` varchar(24) NOT NULL,
  `Date` int(10) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of ncrecords
-- ----------------------------
