/*
Navicat MySQL Data Transfer

Source Server         : dev
Source Server Version : 50169
Source Host           : 176.28.51.84:3306
Source Database       : stuntevodev

Target Server Type    : MYSQL
Target Server Version : 50169
File Encoding         : 65001

Date: 2013-06-09 21:43:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `creditslog`
-- ----------------------------
DROP TABLE IF EXISTS `creditslog`;
CREATE TABLE `creditslog` (
  `ID` mediumint(6) unsigned NOT NULL AUTO_INCREMENT,
  `Player` varchar(24) NOT NULL,
  `Action` smallint(5) NOT NULL,
  `Date` int(10) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of creditslog
-- ----------------------------
