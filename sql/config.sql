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

 Date: 17/09/2017 23:27:29
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config`  (
  `id` smallint(6) NOT NULL AUTO_INCREMENT,
  `key` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'Key',
  `value` varchar(45) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '值',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '网站配置' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of config
-- ----------------------------
INSERT INTO `config` VALUES (1, 'index_title', '创新理论与创新管理研究中心', '首页title');
INSERT INTO `config` VALUES (2, 'seo_description', 'ITIMRC', '网站描述');
INSERT INTO `config` VALUES (3, 'ICP', 'ICP备13010980号', '备案号');
INSERT INTO `config` VALUES (4, 'phonenum', '123456', '联系电话');
INSERT INTO `config` VALUES (5, 'copyright', '@创新理论与创新管理研究中心', '网站版权');
INSERT INTO `config` VALUES (6, 'pagination_num', '2', '分页每页显示条数');
-- INSERT INTO `config` VALUES (7, 'bigheight', '330', '首页展示图大图高');
-- INSERT INTO `config` VALUES (8, 'bigwidth', '1200', '首页展示图大图宽');
-- INSERT INTO `config` VALUES (9, 'smallheight', '280', '首页展示图小图高');
-- INSERT INTO `config` VALUES (10, 'smallwidth', '790', '首页展示图小图宽');

SET FOREIGN_KEY_CHECKS = 1;
