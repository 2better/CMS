/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50533
 Source Host           : localhost:3306
 Source Schema         : shishuocms

 Target Server Type    : MySQL
 Target Server Version : 50533
 File Encoding         : 65001

 Date: 17/09/2017 23:27:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` bigint(20) NOT NULL,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `pid` bigint(20) NOT NULL,
  `sort` tinyint(4) NOT NULL,
  `status` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `isLeaf` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否是叶子节点，0不是1是',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (0, '根菜单', ' ', -1, 1, 'display', 0);
INSERT INTO `menu` VALUES (149715099586609, '关于我们', '/article/list.htm?menuId=149715099586609', 0, 2, 'display', 0);
INSERT INTO `menu` VALUES (149715108805446, '新闻动态', '/article/list.htm?menuId=149715108805446', 0, 3, 'display', 0);
INSERT INTO `menu` VALUES (149715110302379, '研究人员', '/article/list.htm?menuId=149715110302379', 0, 4, 'display', 0);
INSERT INTO `menu` VALUES (149715112017201, '学术研究', '/article/list.htm?menuId=149715112017201', 0, 5, 'display', 0);
INSERT INTO `menu` VALUES (149715114562973, '人才培养', '/article/list.htm?menuId=149715114562973', 0, 6, 'display', 0);
INSERT INTO `menu` VALUES (149715115964151, '合作交流', '/article/list.htm?menuId=149715115964151', 0, 7, 'display', 0);
INSERT INTO `menu` VALUES (149715117020733, '研究资源', '/article/list.htm?menuId=149715117020733', 0, 8, 'display', 1);
INSERT INTO `menu` VALUES (149715118080311, '人才招聘', '/article/list.htm?menuId=149715118080311', 0, 9, 'display', 1);
INSERT INTO `menu` VALUES (149715120950670, '智库专报', '/paper/thinkTtank.htm', 0, 10, 'display', 1);
INSERT INTO `menu` VALUES (149715122468202, '首页', '/index.htm', 0, 1, 'display', 1);
INSERT INTO `menu` VALUES (149715128012317, '主任致辞', '/article/list.htm?menuId=149715128012317', 149715099586609, 1, 'display', 1);
INSERT INTO `menu` VALUES (149715129668145, '中心简介', '/article/list.htm?menuId=149715129668145', 149715099586609, 1, 'display', 1);
INSERT INTO `menu` VALUES (149715135268713, '学术委员会', '/article/list.htm?menuId=149715135268713', 149715099586609, 1, 'display', 1);
INSERT INTO `menu` VALUES (149715137137918, '组织机构', '/article/list.htm?menuId=149715137137918', 149715099586609, 1, 'display', 1);
INSERT INTO `menu` VALUES (149715140882566, '中心动态', '/article/list.htm?menuId=149715140882566', 149715108805446, 1, 'display', 1);
INSERT INTO `menu` VALUES (149715141715540, '学术前沿', '/article/list.htm?menuId=149715141715540', 149715108805446, 1, 'display', 1);
INSERT INTO `menu` VALUES (149715143466311, '研究顾问', '/article/list.htm?menuId=149715143466311', 149715110302379, 1, 'display', 1);
INSERT INTO `menu` VALUES (149715145693790, '专职研究员', '/article/list.htm?menuId=149715145693790', 149715110302379, 1, 'display', 1);
INSERT INTO `menu` VALUES (149715147705703, '兼职研究员', '/article/list.htm?menuId=149715147705703', 149715110302379, 1, 'display', 1);
INSERT INTO `menu` VALUES (149715148797574, '其他人员', '/article/list.htm?menuId=149715148797574', 149715110302379, 1, 'display', 1);
INSERT INTO `menu` VALUES (149715150497545, '研究方向', '/article/list.htm?menuId=149715150497545', 149715112017201, 1, 'display', 1);
INSERT INTO `menu` VALUES (149715151450632, '研究成果', '/article/list.htm?menuId=149715151450632', 149715112017201, 1, 'display', 0);
INSERT INTO `menu` VALUES (149715153341548, '本科生教育', '/article/list.htm?menuId=149715153341548', 149715114562973, 1, 'display', 1);
INSERT INTO `menu` VALUES (149715154586939, '研究生教育', '/article/list.htm?menuId=149715154586939', 149715114562973, 1, 'display', 1);
INSERT INTO `menu` VALUES (149715156331056, '高校合作', '/article/list.htm?menuId=149715156331056', 149715115964151, 1, 'display', 1);
INSERT INTO `menu` VALUES (149715156997426, '企业合作', '/article/list.htm?menuId=149715156997426', 149715115964151, 1, 'display', 1);
INSERT INTO `menu` VALUES (149715157911011, '政府合作', '/article/list.htm?menuId=149715157911011', 149715115964151, 1, 'display', 1);
INSERT INTO `menu` VALUES (149746273666579, '学术论文', '/article/list.htm?menuId=149746273666579', 149715151450632, 1, 'display', 0);
INSERT INTO `menu` VALUES (149746288288476, '出版书籍', '/article/list.htm?menuId=149746288288476', 149715151450632, 1, 'display', 0);

SET FOREIGN_KEY_CHECKS = 1;
