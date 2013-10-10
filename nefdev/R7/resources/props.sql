/*
Navicat MySQL Data Transfer

Source Server         : dev
Source Server Version : 50169
Source Host           : 176.28.51.84:3306
Source Database       : stuntevodev

Target Server Type    : MYSQL
Target Server Version : 50169
File Encoding         : 65001

Date: 2013-06-10 17:01:33
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `props`
-- ----------------------------
DROP TABLE IF EXISTS `props`;
CREATE TABLE `props` (
  `ID` mediumint(6) NOT NULL AUTO_INCREMENT,
  `Owner` varchar(24) NOT NULL,
  `XPos` float(24,2) NOT NULL,
  `YPos` float(24,2) NOT NULL,
  `ZPos` float(24,2) NOT NULL,
  `Level` tinyint(2) NOT NULL DEFAULT '1',
  `Sold` tinyint(1) NOT NULL,
  `Date` int(10) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=254 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of props
-- ----------------------------
INSERT INTO `props` VALUES ('1', 'ForSale', '2467.03', '-1743.32', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('2', 'ForSale', '2448.45', '-1740.27', '13.69', '1', '0', '0');
INSERT INTO `props` VALUES ('3', 'ForSale', '2423.44', '-1742.04', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('4', 'ForSale', '2421.84', '-1761.29', '13.53', '1', '0', '0');
INSERT INTO `props` VALUES ('5', 'ForSale', '2439.08', '-1940.99', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('6', 'ForSale', '2444.13', '-1940.72', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('7', 'ForSale', '2433.93', '-1940.86', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('8', 'ForSale', '2422.77', '-1955.00', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('9', 'ForSale', '2400.48', '-1980.63', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('10', 'ForSale', '2424.13', '-1923.18', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('11', 'ForSale', '2435.56', '-1923.06', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('12', 'ForSale', '2472.90', '-1923.31', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('13', 'ForSale', '2702.86', '-1969.98', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('14', 'ForSale', '2722.24', '-2026.66', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('15', 'ForSale', '2722.06', '-2033.55', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('16', 'ForSale', '2261.52', '-2091.50', '13.65', '1', '0', '0');
INSERT INTO `props` VALUES ('17', 'ForSale', '1958.33', '-2183.59', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('18', 'ForSale', '1969.99', '-2084.94', '13.55', '1', '0', '0');
INSERT INTO `props` VALUES ('19', 'ForSale', '1992.47', '-2102.01', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('20', 'ForSale', '1936.25', '-2086.48', '13.57', '1', '0', '0');
INSERT INTO `props` VALUES ('21', 'ForSale', '1975.28', '-2036.77', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('22', 'ForSale', '1953.56', '-2021.21', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('23', 'ForSale', '1953.32', '-2003.93', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('24', 'ForSale', '1950.97', '-1985.01', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('25', 'ForSale', '2089.89', '-1925.38', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('26', 'ForSale', '2090.06', '-1929.80', '13.53', '1', '0', '0');
INSERT INTO `props` VALUES ('27', 'ForSale', '2090.22', '-1934.24', '13.53', '1', '0', '0');
INSERT INTO `props` VALUES ('28', 'ForSale', '2090.20', '-1938.84', '13.53', '1', '0', '0');
INSERT INTO `props` VALUES ('29', 'ForSale', '2228.94', '-1722.36', '13.55', '1', '0', '0');
INSERT INTO `props` VALUES ('30', 'ForSale', '2255.64', '-1333.24', '23.98', '1', '0', '0');
INSERT INTO `props` VALUES ('31', 'ForSale', '2311.60', '-1362.99', '24.02', '1', '0', '0');
INSERT INTO `props` VALUES ('32', 'ForSale', '2311.52', '-1347.67', '24.02', '1', '0', '0');
INSERT INTO `props` VALUES ('33', 'ForSale', '2351.08', '-1412.07', '23.99', '1', '0', '0');
INSERT INTO `props` VALUES ('34', 'ForSale', '2351.36', '-1463.42', '24.00', '1', '0', '0');
INSERT INTO `props` VALUES ('35', 'ForSale', '2351.97', '-1485.19', '24.00', '1', '0', '0');
INSERT INTO `props` VALUES ('36', 'ForSale', '2353.51', '-1512.58', '24.00', '1', '0', '0');
INSERT INTO `props` VALUES ('37', 'ForSale', '2367.27', '-1532.18', '23.99', '1', '0', '0');
INSERT INTO `props` VALUES ('38', 'ForSale', '2390.09', '-1547.44', '24.16', '1', '0', '0');
INSERT INTO `props` VALUES ('39', 'ForSale', '2397.25', '-1547.49', '24.16', '1', '0', '0');
INSERT INTO `props` VALUES ('40', 'ForSale', '2419.23', '-1547.39', '24.16', '1', '0', '0');
INSERT INTO `props` VALUES ('41', 'ForSale', '2403.87', '-1453.58', '24.00', '1', '0', '0');
INSERT INTO `props` VALUES ('42', 'ForSale', '2395.66', '-1453.70', '24.01', '1', '0', '0');
INSERT INTO `props` VALUES ('43', 'ForSale', '2468.98', '-1512.80', '24.00', '1', '0', '0');
INSERT INTO `props` VALUES ('44', 'ForSale', '2481.31', '-1496.33', '24.00', '1', '0', '0');
INSERT INTO `props` VALUES ('45', 'ForSale', '2501.89', '-1496.62', '24.00', '1', '0', '0');
INSERT INTO `props` VALUES ('46', 'ForSale', '2508.93', '-1495.27', '24.00', '1', '0', '0');
INSERT INTO `props` VALUES ('47', 'ForSale', '2529.62', '-1495.14', '24.01', '1', '0', '0');
INSERT INTO `props` VALUES ('48', 'ForSale', '2560.48', '-1482.17', '24.01', '1', '0', '0');
INSERT INTO `props` VALUES ('49', 'ForSale', '2560.86', '-1474.86', '24.01', '1', '0', '0');
INSERT INTO `props` VALUES ('50', 'ForSale', '2561.11', '-1467.53', '24.00', '1', '0', '0');
INSERT INTO `props` VALUES ('51', 'ForSale', '2578.77', '-1389.83', '28.85', '1', '0', '0');
INSERT INTO `props` VALUES ('52', 'ForSale', '2578.85', '-1398.07', '27.36', '1', '0', '0');
INSERT INTO `props` VALUES ('53', 'ForSale', '2578.60', '-1405.90', '25.83', '1', '0', '0');
INSERT INTO `props` VALUES ('54', 'ForSale', '2563.12', '-1358.95', '34.44', '1', '0', '0');
INSERT INTO `props` VALUES ('55', 'ForSale', '2562.98', '-1329.79', '39.71', '1', '0', '0');
INSERT INTO `props` VALUES ('56', 'ForSale', '2407.26', '-1241.17', '23.81', '1', '0', '0');
INSERT INTO `props` VALUES ('57', 'ForSale', '2421.56', '-1221.30', '25.42', '1', '0', '0');
INSERT INTO `props` VALUES ('58', 'ForSale', '2379.34', '-1213.68', '27.42', '1', '0', '0');
INSERT INTO `props` VALUES ('59', 'ForSale', '2379.25', '-1197.85', '27.42', '1', '0', '0');
INSERT INTO `props` VALUES ('60', 'ForSale', '2436.52', '-1191.01', '36.32', '1', '0', '0');
INSERT INTO `props` VALUES ('61', 'ForSale', '2702.50', '-1278.28', '58.94', '1', '0', '0');
INSERT INTO `props` VALUES ('62', 'ForSale', '2714.67', '-1341.66', '46.46', '1', '0', '0');
INSERT INTO `props` VALUES ('63', 'ForSale', '2714.55', '-1361.46', '42.89', '1', '0', '0');
INSERT INTO `props` VALUES ('64', 'ForSale', '2714.77', '-1377.01', '40.08', '1', '0', '0');
INSERT INTO `props` VALUES ('65', 'ForSale', '2714.90', '-1419.41', '32.43', '1', '0', '0');
INSERT INTO `props` VALUES ('66', 'ForSale', '2715.09', '-1444.45', '30.45', '1', '0', '0');
INSERT INTO `props` VALUES ('67', 'ForSale', '2714.70', '-1460.49', '30.51', '1', '0', '0');
INSERT INTO `props` VALUES ('68', 'ForSale', '2715.04', '-1468.33', '30.54', '1', '0', '0');
INSERT INTO `props` VALUES ('69', 'ForSale', '2751.02', '-1468.48', '30.45', '1', '0', '0');
INSERT INTO `props` VALUES ('70', 'ForSale', '2845.59', '-1480.94', '10.90', '1', '0', '0');
INSERT INTO `props` VALUES ('71', 'ForSale', '2861.80', '-1480.53', '10.93', '1', '0', '0');
INSERT INTO `props` VALUES ('72', 'ForSale', '2867.54', '-1473.91', '10.95', '1', '0', '0');
INSERT INTO `props` VALUES ('73', 'ForSale', '2867.27', '-1465.88', '10.95', '1', '0', '0');
INSERT INTO `props` VALUES ('74', 'ForSale', '2867.11', '-1457.96', '10.95', '1', '0', '0');
INSERT INTO `props` VALUES ('75', 'ForSale', '2864.06', '-1406.07', '11.40', '1', '0', '0');
INSERT INTO `props` VALUES ('76', 'ForSale', '2794.98', '-1087.45', '30.71', '1', '0', '0');
INSERT INTO `props` VALUES ('77', 'ForSale', '2659.76', '-1093.60', '69.53', '1', '0', '0');
INSERT INTO `props` VALUES ('78', 'ForSale', '2665.16', '-1093.69', '69.44', '1', '0', '0');
INSERT INTO `props` VALUES ('79', 'ForSale', '2672.73', '-1093.90', '69.31', '1', '0', '0');
INSERT INTO `props` VALUES ('80', 'ForSale', '2689.81', '-1093.75', '69.29', '1', '0', '0');
INSERT INTO `props` VALUES ('81', 'ForSale', '2699.33', '-1093.80', '69.37', '1', '0', '0');
INSERT INTO `props` VALUES ('82', 'ForSale', '2704.17', '-1093.70', '69.45', '1', '0', '0');
INSERT INTO `props` VALUES ('83', 'ForSale', '2710.25', '-1093.75', '69.49', '1', '0', '0');
INSERT INTO `props` VALUES ('84', 'ForSale', '2715.29', '-1116.02', '69.57', '1', '0', '0');
INSERT INTO `props` VALUES ('85', 'ForSale', '2715.66', '-1108.56', '69.57', '1', '0', '0');
INSERT INTO `props` VALUES ('86', 'ForSale', '2193.20', '-1001.68', '62.62', '1', '0', '0');
INSERT INTO `props` VALUES ('87', 'ForSale', '2192.15', '-1017.83', '62.45', '1', '0', '0');
INSERT INTO `props` VALUES ('88', 'ForSale', '2153.83', '-1013.00', '62.95', '1', '0', '0');
INSERT INTO `props` VALUES ('89', 'ForSale', '1631.95', '-1169.92', '24.07', '1', '0', '0');
INSERT INTO `props` VALUES ('90', 'ForSale', '1581.75', '-1168.08', '24.07', '1', '0', '0');
INSERT INTO `props` VALUES ('91', 'ForSale', '1564.96', '-1168.97', '24.07', '1', '0', '0');
INSERT INTO `props` VALUES ('92', 'ForSale', '1544.01', '-1169.56', '24.07', '1', '0', '0');
INSERT INTO `props` VALUES ('93', 'ForSale', '1530.24', '-1153.45', '24.07', '1', '0', '0');
INSERT INTO `props` VALUES ('94', 'ForSale', '1507.20', '-1153.63', '24.07', '1', '0', '0');
INSERT INTO `props` VALUES ('95', 'ForSale', '1457.81', '-1138.88', '24.03', '1', '0', '0');
INSERT INTO `props` VALUES ('96', 'ForSale', '1314.13', '-1157.07', '23.82', '1', '0', '0');
INSERT INTO `props` VALUES ('97', 'ForSale', '1307.57', '-1157.24', '23.82', '1', '0', '0');
INSERT INTO `props` VALUES ('98', 'ForSale', '1287.16', '-1156.99', '23.82', '1', '0', '0');
INSERT INTO `props` VALUES ('99', 'ForSale', '1248.17', '-1156.32', '23.76', '1', '0', '0');
INSERT INTO `props` VALUES ('100', 'ForSale', '1234.67', '-1156.86', '23.54', '1', '0', '0');
INSERT INTO `props` VALUES ('101', 'ForSale', '1181.25', '-1156.87', '23.86', '1', '0', '0');
INSERT INTO `props` VALUES ('102', 'ForSale', '1145.25', '-1132.12', '23.82', '1', '0', '0');
INSERT INTO `props` VALUES ('103', 'ForSale', '1139.72', '-1132.78', '23.82', '1', '0', '0');
INSERT INTO `props` VALUES ('104', 'ForSale', '1122.94', '-1130.79', '23.81', '1', '0', '0');
INSERT INTO `props` VALUES ('105', 'ForSale', '1112.84', '-1156.74', '23.82', '1', '0', '0');
INSERT INTO `props` VALUES ('106', 'ForSale', '1107.01', '-1156.52', '23.82', '1', '0', '0');
INSERT INTO `props` VALUES ('107', 'ForSale', '1101.25', '-1156.51', '23.82', '1', '0', '0');
INSERT INTO `props` VALUES ('108', 'ForSale', '1095.53', '-1156.82', '23.82', '1', '0', '0');
INSERT INTO `props` VALUES ('109', 'ForSale', '1079.91', '-1156.64', '23.82', '1', '0', '0');
INSERT INTO `props` VALUES ('110', 'ForSale', '1057.42', '-1132.88', '23.82', '1', '0', '0');
INSERT INTO `props` VALUES ('111', 'ForSale', '1046.28', '-1132.63', '23.82', '1', '0', '0');
INSERT INTO `props` VALUES ('112', 'ForSale', '1022.70', '-1122.90', '23.87', '1', '0', '0');
INSERT INTO `props` VALUES ('113', 'ForSale', '1003.84', '-1158.22', '23.85', '1', '0', '0');
INSERT INTO `props` VALUES ('114', 'ForSale', '988.54', '-1159.94', '24.33', '1', '0', '0');
INSERT INTO `props` VALUES ('115', 'ForSale', '998.98', '-1132.68', '23.82', '1', '0', '0');
INSERT INTO `props` VALUES ('116', 'ForSale', '984.52', '-1133.08', '23.82', '1', '0', '0');
INSERT INTO `props` VALUES ('117', 'ForSale', '977.32', '-1132.97', '23.82', '1', '0', '0');
INSERT INTO `props` VALUES ('118', 'ForSale', '963.49', '-1156.98', '23.84', '1', '0', '0');
INSERT INTO `props` VALUES ('119', 'ForSale', '956.38', '-1157.19', '23.83', '1', '0', '0');
INSERT INTO `props` VALUES ('120', 'ForSale', '912.22', '-1231.17', '16.97', '1', '0', '0');
INSERT INTO `props` VALUES ('121', 'ForSale', '950.08', '-1236.30', '16.64', '1', '0', '0');
INSERT INTO `props` VALUES ('122', 'ForSale', '949.48', '-1242.29', '16.36', '1', '0', '0');
INSERT INTO `props` VALUES ('123', 'ForSale', '949.15', '-1249.90', '16.01', '1', '0', '0');
INSERT INTO `props` VALUES ('124', 'ForSale', '949.57', '-1256.05', '15.84', '1', '0', '0');
INSERT INTO `props` VALUES ('125', 'ForSale', '949.71', '-1262.10', '15.69', '1', '0', '0');
INSERT INTO `props` VALUES ('126', 'ForSale', '949.87', '-1268.59', '15.53', '1', '0', '0');
INSERT INTO `props` VALUES ('127', 'ForSale', '949.82', '-1278.66', '15.10', '1', '0', '0');
INSERT INTO `props` VALUES ('128', 'ForSale', '949.74', '-1286.62', '14.72', '1', '0', '0');
INSERT INTO `props` VALUES ('129', 'ForSale', '949.34', '-1294.72', '14.31', '1', '0', '0');
INSERT INTO `props` VALUES ('130', 'ForSale', '960.21', '-1313.08', '13.52', '1', '0', '0');
INSERT INTO `props` VALUES ('131', 'ForSale', '953.59', '-1334.30', '13.53', '1', '0', '0');
INSERT INTO `props` VALUES ('132', 'ForSale', '974.69', '-1334.66', '13.53', '1', '0', '0');
INSERT INTO `props` VALUES ('133', 'ForSale', '983.78', '-1334.76', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('134', 'ForSale', '986.68', '-1385.30', '13.60', '1', '0', '0');
INSERT INTO `props` VALUES ('135', 'ForSale', '979.71', '-1297.84', '13.38', '1', '0', '0');
INSERT INTO `props` VALUES ('136', 'ForSale', '987.02', '-1298.01', '13.38', '1', '0', '0');
INSERT INTO `props` VALUES ('137', 'ForSale', '994.53', '-1298.10', '13.38', '1', '0', '0');
INSERT INTO `props` VALUES ('138', 'ForSale', '1001.94', '-1298.31', '13.38', '1', '0', '0');
INSERT INTO `props` VALUES ('139', 'ForSale', '1009.01', '-1298.57', '13.38', '1', '0', '0');
INSERT INTO `props` VALUES ('140', 'ForSale', '1038.21', '-1338.26', '13.72', '1', '0', '0');
INSERT INTO `props` VALUES ('141', 'ForSale', '1069.63', '-1331.97', '13.55', '1', '0', '0');
INSERT INTO `props` VALUES ('142', 'ForSale', '1069.91', '-1354.53', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('143', 'ForSale', '1046.31', '-1371.53', '13.57', '1', '0', '0');
INSERT INTO `props` VALUES ('144', 'ForSale', '1044.90', '-1385.74', '13.68', '1', '0', '0');
INSERT INTO `props` VALUES ('145', 'ForSale', '1072.13', '-1386.04', '13.85', '1', '0', '0');
INSERT INTO `props` VALUES ('146', 'ForSale', '1104.98', '-1371.03', '13.98', '1', '0', '0');
INSERT INTO `props` VALUES ('147', 'ForSale', '1126.44', '-1371.40', '13.98', '1', '0', '0');
INSERT INTO `props` VALUES ('148', 'ForSale', '1130.33', '-1419.37', '14.06', '1', '0', '0');
INSERT INTO `props` VALUES ('149', 'ForSale', '1182.91', '-1581.42', '13.52', '1', '0', '0');
INSERT INTO `props` VALUES ('150', 'ForSale', '1152.25', '-1565.12', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('151', 'ForSale', '1160.57', '-1583.38', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('152', 'ForSale', '1157.66', '-1602.66', '13.73', '1', '0', '0');
INSERT INTO `props` VALUES ('153', 'ForSale', '1159.14', '-1656.69', '13.95', '1', '0', '0');
INSERT INTO `props` VALUES ('154', 'ForSale', '1161.58', '-1670.54', '14.18', '1', '0', '0');
INSERT INTO `props` VALUES ('155', 'ForSale', '1161.55', '-1691.04', '14.18', '1', '0', '0');
INSERT INTO `props` VALUES ('156', 'ForSale', '1054.23', '-1580.47', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('157', 'ForSale', '1033.91', '-1482.15', '13.55', '1', '0', '0');
INSERT INTO `props` VALUES ('158', 'ForSale', '1003.73', '-1498.88', '13.53', '1', '0', '0');
INSERT INTO `props` VALUES ('159', 'ForSale', '984.85', '-1498.69', '13.53', '1', '0', '0');
INSERT INTO `props` VALUES ('160', 'ForSale', '966.21', '-1498.69', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('161', 'ForSale', '929.02', '-1501.70', '13.54', '1', '0', '0');
INSERT INTO `props` VALUES ('162', 'ForSale', '893.50', '-1387.10', '13.45', '1', '0', '0');
INSERT INTO `props` VALUES ('163', 'ForSale', '887.89', '-1387.22', '13.44', '1', '0', '0');
INSERT INTO `props` VALUES ('164', 'ForSale', '882.05', '-1387.12', '13.47', '1', '0', '0');
INSERT INTO `props` VALUES ('165', 'ForSale', '876.37', '-1387.51', '13.49', '1', '0', '0');
INSERT INTO `props` VALUES ('166', 'ForSale', '870.74', '-1387.35', '13.50', '1', '0', '0');
INSERT INTO `props` VALUES ('167', 'ForSale', '835.94', '-1387.57', '13.61', '1', '0', '0');
INSERT INTO `props` VALUES ('168', 'ForSale', '816.34', '-1387.99', '13.61', '1', '0', '0');
INSERT INTO `props` VALUES ('169', 'ForSale', '777.90', '-1384.32', '13.71', '1', '0', '0');
INSERT INTO `props` VALUES ('170', 'ForSale', '705.04', '-1416.02', '13.53', '1', '0', '0');
INSERT INTO `props` VALUES ('171', 'ForSale', '566.12', '-1289.67', '24.64', '1', '0', '0');
INSERT INTO `props` VALUES ('172', 'ForSale', '476.18', '-1279.84', '16.48', '1', '0', '0');
INSERT INTO `props` VALUES ('173', 'ForSale', '425.89', '-1320.47', '15.01', '1', '0', '0');
INSERT INTO `props` VALUES ('174', 'ForSale', '366.06', '-1355.52', '14.54', '1', '0', '0');
INSERT INTO `props` VALUES ('175', 'ForSale', '331.00', '-1345.17', '14.50', '1', '0', '0');
INSERT INTO `props` VALUES ('176', 'ForSale', '332.51', '-1338.55', '14.50', '1', '0', '0');
INSERT INTO `props` VALUES ('177', 'ForSale', '330.97', '-1515.59', '35.86', '1', '0', '0');
INSERT INTO `props` VALUES ('178', 'ForSale', '143.69', '-1468.66', '25.20', '1', '0', '0');
INSERT INTO `props` VALUES ('179', 'ForSale', '-69.08', '-1116.98', '1.07', '1', '0', '0');
INSERT INTO `props` VALUES ('180', 'ForSale', '-49.87', '-274.81', '5.42', '1', '0', '0');
INSERT INTO `props` VALUES ('181', 'ForSale', '142.25', '-202.58', '1.57', '1', '0', '0');
INSERT INTO `props` VALUES ('182', 'ForSale', '173.28', '-202.07', '1.57', '1', '0', '0');
INSERT INTO `props` VALUES ('183', 'ForSale', '254.64', '-64.20', '1.57', '1', '0', '0');
INSERT INTO `props` VALUES ('184', 'ForSale', '321.29', '-50.44', '1.56', '1', '0', '0');
INSERT INTO `props` VALUES ('185', 'ForSale', '342.22', '-76.56', '1.43', '1', '0', '0');
INSERT INTO `props` VALUES ('186', 'ForSale', '320.42', '-165.02', '1.57', '1', '0', '0');
INSERT INTO `props` VALUES ('187', 'ForSale', '290.67', '-195.63', '1.57', '1', '0', '0');
INSERT INTO `props` VALUES ('188', 'ForSale', '274.91', '-195.58', '1.57', '1', '0', '0');
INSERT INTO `props` VALUES ('189', 'ForSale', '275.48', '-180.36', '1.57', '1', '0', '0');
INSERT INTO `props` VALUES ('190', 'ForSale', '275.37', '-158.01', '1.57', '1', '0', '0');
INSERT INTO `props` VALUES ('191', 'ForSale', '207.73', '-64.53', '1.57', '1', '0', '0');
INSERT INTO `props` VALUES ('192', 'ForSale', '164.39', '-51.30', '1.57', '1', '0', '0');
INSERT INTO `props` VALUES ('193', 'ForSale', '217.29', '15.31', '2.34', '1', '0', '0');
INSERT INTO `props` VALUES ('194', 'ForSale', '246.26', '29.17', '2.31', '1', '0', '0');
INSERT INTO `props` VALUES ('195', 'ForSale', '-84.59', '-11.72', '2.88', '1', '0', '0');
INSERT INTO `props` VALUES ('196', 'ForSale', '1260.71', '202.99', '19.55', '1', '0', '0');
INSERT INTO `props` VALUES ('197', 'ForSale', '1269.84', '223.79', '19.55', '1', '0', '0');
INSERT INTO `props` VALUES ('198', 'ForSale', '1276.05', '237.66', '19.55', '1', '0', '0');
INSERT INTO `props` VALUES ('199', 'ForSale', '1290.99', '270.47', '19.55', '1', '0', '0');
INSERT INTO `props` VALUES ('200', 'ForSale', '1297.99', '287.02', '19.54', '1', '0', '0');
INSERT INTO `props` VALUES ('201', 'ForSale', '1305.90', '304.46', '19.55', '1', '0', '0');
INSERT INTO `props` VALUES ('202', 'ForSale', '1311.04', '328.90', '19.91', '1', '0', '0');
INSERT INTO `props` VALUES ('203', 'ForSale', '1350.25', '349.11', '20.23', '1', '0', '0');
INSERT INTO `props` VALUES ('204', 'ForSale', '1339.35', '380.43', '19.56', '1', '0', '0');
INSERT INTO `props` VALUES ('205', 'ForSale', '1370.47', '406.42', '19.75', '1', '0', '0');
INSERT INTO `props` VALUES ('206', 'ForSale', '1412.94', '262.66', '19.55', '1', '0', '0');
INSERT INTO `props` VALUES ('207', 'ForSale', '1223.80', '243.35', '19.54', '1', '0', '0');
INSERT INTO `props` VALUES ('208', 'ForSale', '1214.48', '224.03', '19.55', '1', '0', '0');
INSERT INTO `props` VALUES ('209', 'ForSale', '1243.74', '203.03', '19.55', '1', '0', '0');
INSERT INTO `props` VALUES ('210', 'ForSale', '1228.64', '183.71', '20.11', '1', '0', '0');
INSERT INTO `props` VALUES ('211', 'ForSale', '1234.18', '358.28', '19.55', '1', '0', '0');
INSERT INTO `props` VALUES ('212', 'ForSale', '2305.70', '84.49', '26.47', '1', '0', '0');
INSERT INTO `props` VALUES ('213', 'ForSale', '2301.02', '56.35', '26.48', '1', '0', '0');
INSERT INTO `props` VALUES ('214', 'ForSale', '2301.31', '30.83', '26.48', '1', '0', '0');
INSERT INTO `props` VALUES ('215', 'ForSale', '2301.40', '13.95', '26.48', '1', '0', '0');
INSERT INTO `props` VALUES ('216', 'ForSale', '2301.45', '-16.40', '26.48', '1', '0', '0');
INSERT INTO `props` VALUES ('217', 'ForSale', '2331.21', '-35.66', '26.48', '1', '0', '0');
INSERT INTO `props` VALUES ('218', 'ForSale', '2280.27', '-50.32', '27.03', '1', '0', '0');
INSERT INTO `props` VALUES ('219', 'ForSale', '2269.75', '-77.11', '26.58', '1', '0', '0');
INSERT INTO `props` VALUES ('220', 'ForSale', '2277.74', '48.31', '26.48', '1', '0', '0');
INSERT INTO `props` VALUES ('221', 'ForSale', '2260.98', '49.25', '26.48', '1', '0', '0');
INSERT INTO `props` VALUES ('222', 'ForSale', '2243.56', '52.77', '26.66', '1', '0', '0');
INSERT INTO `props` VALUES ('223', 'ForSale', '2334.75', '-19.43', '26.48', '1', '0', '0');
INSERT INTO `props` VALUES ('224', 'ForSale', '2301.56', '-61.50', '26.48', '1', '0', '0');
INSERT INTO `props` VALUES ('225', 'ForSale', '2301.59', '-49.68', '26.48', '1', '0', '0');
INSERT INTO `props` VALUES ('226', 'ForSale', '1921.07', '149.20', '37.27', '1', '0', '0');
INSERT INTO `props` VALUES ('227', 'ForSale', '681.67', '-476.30', '16.33', '1', '0', '0');
INSERT INTO `props` VALUES ('228', 'ForSale', '720.12', '-468.97', '16.34', '1', '0', '0');
INSERT INTO `props` VALUES ('229', 'ForSale', '714.35', '-498.27', '16.33', '1', '0', '0');
INSERT INTO `props` VALUES ('230', 'ForSale', '702.49', '-522.67', '16.33', '1', '0', '0');
INSERT INTO `props` VALUES ('231', 'ForSale', '673.45', '-521.03', '16.32', '1', '0', '0');
INSERT INTO `props` VALUES ('232', 'ForSale', '648.70', '-522.43', '16.33', '1', '0', '0');
INSERT INTO `props` VALUES ('233', 'ForSale', '610.65', '-518.52', '16.33', '1', '0', '0');
INSERT INTO `props` VALUES ('234', 'ForSale', '630.63', '-571.23', '16.33', '1', '0', '0');
INSERT INTO `props` VALUES ('235', 'ForSale', '660.42', '-573.49', '16.33', '1', '0', '0');
INSERT INTO `props` VALUES ('236', 'ForSale', '689.37', '-614.05', '16.33', '1', '0', '0');
INSERT INTO `props` VALUES ('237', 'ForSale', '689.03', '-621.92', '16.33', '1', '0', '0');
INSERT INTO `props` VALUES ('238', 'ForSale', '689.22', '-633.13', '16.33', '1', '0', '0');
INSERT INTO `props` VALUES ('239', 'ForSale', '689.05', '-640.24', '16.29', '1', '0', '0');
INSERT INTO `props` VALUES ('240', 'ForSale', '674.60', '-646.64', '16.33', '1', '0', '0');
INSERT INTO `props` VALUES ('241', 'ForSale', '674.43', '-634.72', '16.33', '1', '0', '0');
INSERT INTO `props` VALUES ('242', 'ForSale', '674.58', '-627.57', '16.33', '1', '0', '0');
INSERT INTO `props` VALUES ('243', 'ForSale', '688.93', '-583.61', '16.33', '1', '0', '0');
INSERT INTO `props` VALUES ('244', 'ForSale', '689.68', '-547.02', '16.33', '1', '0', '0');
INSERT INTO `props` VALUES ('245', 'ForSale', '744.97', '-552.51', '17.30', '1', '0', '0');
INSERT INTO `props` VALUES ('246', 'ForSale', '824.45', '-557.03', '16.33', '1', '0', '0');
INSERT INTO `props` VALUES ('247', 'ForSale', '824.38', '-575.82', '16.33', '1', '0', '0');
INSERT INTO `props` VALUES ('248', 'ForSale', '854.45', '-603.27', '18.42', '1', '0', '0');
INSERT INTO `props` VALUES ('249', 'ForSale', '694.97', '-498.05', '16.33', '1', '0', '0');
INSERT INTO `props` VALUES ('250', 'ForSale', '701.87', '-493.75', '16.33', '1', '0', '0');
INSERT INTO `props` VALUES ('251', 'ForSale', '-579.69', '-1475.05', '10.95', '1', '0', '0');
INSERT INTO `props` VALUES ('252', 'ForSale', '-571.65', '-1113.69', '22.64', '1', '0', '0');
INSERT INTO `props` VALUES ('253', 'ForSale', '-2167.61', '-2320.87', '30.62', '1', '0', '0');
