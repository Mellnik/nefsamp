/*
Navicat MySQL Data Transfer

Source Server         : dev
Source Server Version : 50169
Source Host           : 176.28.51.84:3306
Source Database       : stuntevodev

Target Server Type    : MYSQL
Target Server Version : 50169
File Encoding         : 65001

Date: 2013-06-09 21:43:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `queue`
-- ----------------------------
DROP TABLE IF EXISTS `queue`;
CREATE TABLE `queue` (
  `ID` mediumint(6) unsigned NOT NULL AUTO_INCREMENT,
  `Action` tinyint(1) NOT NULL,
  `ExecutionDate` int(10) NOT NULL,
  `Extra` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of queue
-- ----------------------------
