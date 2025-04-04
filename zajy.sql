# Host: localhost  (Version: 5.7.26)
# Date: 2025-04-04 13:36:51
# Generator: MySQL-Front 5.3  (Build 4.234)

/*!40101 SET NAMES utf8 */;

#
# Structure for table "departments"
#

DROP TABLE IF EXISTS `departments`;
CREATE TABLE `departments` (
  `dept_id` int(11) NOT NULL AUTO_INCREMENT,
  `dept_name` varchar(100) NOT NULL,
  `dept_type` tinyint(1) NOT NULL COMMENT '1临床2医技3职能',
  `parent_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`dept_id`),
  UNIQUE KEY `idx_name` (`dept_name`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COMMENT='81个标准科室';

#
# Data for table "departments"
#

INSERT INTO `departments` VALUES (1,'急诊科',1,NULL,'2025-04-04 09:21:18'),(2,'重症医学科',1,NULL,'2025-04-04 09:21:18'),(3,'心血管内科',1,NULL,'2025-04-04 09:21:18'),(4,'神经内科',1,NULL,'2025-04-04 09:21:18'),(5,'呼吸与危重症医学科',1,NULL,'2025-04-04 09:21:18'),(6,'消化内科',1,NULL,'2025-04-04 09:21:18'),(7,'内分泌科',1,NULL,'2025-04-04 09:21:18'),(8,'风湿免疫科',1,NULL,'2025-04-04 09:21:18'),(9,'肾病科',1,NULL,'2025-04-04 09:21:18'),(10,'血液内科',1,NULL,'2025-04-04 09:21:18'),(11,'普外科一病区',1,NULL,'2025-04-04 09:21:18'),(12,'普外科二病区',1,NULL,'2025-04-04 09:21:18'),(13,'普外科三病区',1,NULL,'2025-04-04 09:21:18'),(14,'甲乳外科',1,NULL,'2025-04-04 09:21:18'),(15,'心胸外科',1,NULL,'2025-04-04 09:21:18'),(16,'神经外科',1,NULL,'2025-04-04 09:21:18'),(17,'骨科一病区',1,NULL,'2025-04-04 09:21:18'),(18,'骨科二病区',1,NULL,'2025-04-04 09:21:18'),(19,'骨科三病区',1,NULL,'2025-04-04 09:21:18'),(20,'骨科四病区',1,NULL,'2025-04-04 09:21:18'),(21,'骨科五病区',1,NULL,'2025-04-04 09:21:18'),(22,'泌尿外科',1,NULL,'2025-04-04 09:21:18'),(23,'疼痛科',1,NULL,'2025-04-04 09:21:18'),(24,'肿瘤科',1,NULL,'2025-04-04 09:21:18'),(25,'介入放射科',1,NULL,'2025-04-04 09:21:18'),(26,'妇科',1,NULL,'2025-04-04 09:21:18'),(27,'产科',1,NULL,'2025-04-04 09:21:18'),(28,'儿科',1,NULL,'2025-04-04 09:21:18'),(29,'眼科',1,NULL,'2025-04-04 09:21:18'),(30,'耳鼻喉科',1,NULL,'2025-04-04 09:21:18'),(31,'口腔科',1,NULL,'2025-04-04 09:21:18'),(32,'皮肤性病科',1,NULL,'2025-04-04 09:21:18'),(33,'感染性疾病科',1,NULL,'2025-04-04 09:21:18'),(34,'医疗美容科',1,NULL,'2025-04-04 09:21:18'),(35,'中医科',1,NULL,'2025-04-04 09:21:18'),(36,'康复医学科',1,NULL,'2025-04-04 09:21:18'),(37,'临床营养部',1,NULL,'2025-04-04 09:21:18'),(38,'全科医疗科',1,NULL,'2025-04-04 09:21:18'),(39,'老年医学科',1,NULL,'2025-04-04 09:21:18'),(40,'麻醉科',1,NULL,'2025-04-04 09:21:18'),(41,'日间病房',1,NULL,'2025-04-04 09:21:18'),(42,'医学影像科',2,NULL,'2025-04-04 09:21:18'),(43,'检验科',2,NULL,'2025-04-04 09:21:18'),(44,'超声医学科',2,NULL,'2025-04-04 09:21:18'),(45,'核医学科',2,NULL,'2025-04-04 09:21:18'),(46,'病理科',2,NULL,'2025-04-04 09:21:18'),(47,'手术室',2,NULL,'2025-04-04 09:21:18'),(48,'消毒供应中心',2,NULL,'2025-04-04 09:21:18'),(49,'输血科',2,NULL,'2025-04-04 09:21:18'),(50,'高压氧室',2,NULL,'2025-04-04 09:21:18'),(51,'病案统计科',2,NULL,'2025-04-04 09:21:18'),(52,'药学部',2,NULL,'2025-04-04 09:21:18'),(53,'健康管理中心',2,NULL,'2025-04-04 09:21:18'),(54,'介入导管室',2,NULL,'2025-04-04 09:21:18'),(55,'营养科',2,NULL,'2025-04-04 09:21:18'),(56,'特需体检部',2,NULL,'2025-04-04 09:21:18'),(57,'党委办公室',3,NULL,'2025-04-04 09:21:18'),(58,'院长办公室',3,NULL,'2025-04-04 09:21:18'),(59,'人事科',3,NULL,'2025-04-04 09:21:18'),(60,'纪检监察室',3,NULL,'2025-04-04 09:21:18'),(61,'宣传科',3,NULL,'2025-04-04 09:21:18'),(62,'医务科',3,NULL,'2025-04-04 09:21:18'),(63,'护理部',3,NULL,'2025-04-04 09:21:18'),(64,'绿色通道服务处',3,NULL,'2025-04-04 09:21:18'),(65,'门诊部',3,NULL,'2025-04-04 09:21:18'),(66,'医保科',3,NULL,'2025-04-04 09:21:18'),(67,'感染管理科',3,NULL,'2025-04-04 09:21:18'),(68,'预防保健科',3,NULL,'2025-04-04 09:21:18'),(69,'科教科',3,NULL,'2025-04-04 09:21:18'),(70,'信息科',3,NULL,'2025-04-04 09:21:18'),(71,'财务科',3,NULL,'2025-04-04 09:21:18'),(72,'审计科',3,NULL,'2025-04-04 09:21:18'),(73,'基建科',3,NULL,'2025-04-04 09:21:18'),(74,'后勤管理中心',3,NULL,'2025-04-04 09:21:18'),(75,'医学装备管理部',3,NULL,'2025-04-04 09:21:18'),(76,'医患关系协调办公室',3,NULL,'2025-04-04 09:21:18'),(77,'经营管理办公室',3,NULL,'2025-04-04 09:21:18'),(78,'工会办公室',3,NULL,'2025-04-04 09:21:18'),(79,'团委',3,NULL,'2025-04-04 09:21:18'),(80,'保卫科',3,NULL,'2025-04-04 09:21:18'),(81,'动力科',3,NULL,'2025-04-04 09:21:18'),(82,'宿管科',3,NULL,'2025-04-04 09:21:18');

#
# Structure for table "menu"
#

DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL,
  `app` varchar(10) NOT NULL COMMENT '所属应用（admin/index）',
  `title` varchar(20) NOT NULL COMMENT '菜单名称',
  `path` varchar(50) NOT NULL COMMENT '路由路径',
  `parent_id` int(11) DEFAULT '0' COMMENT '父菜单ID',
  `icon` varchar(20) DEFAULT NULL COMMENT '图标类名',
  `sort` int(11) DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

#
# Data for table "menu"
#

/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'admin','用户中心','/home',0,'tools',1),(2,'admin','活动管理','/sys/user',0,'user',2),(3,'admin','角色配置','/sys/role',2,'postcard',90),(4,'admin','组织架构','/sys/org',2,'office-build',85),(5,'index','志愿中心','/vol',0,'present',3),(6,'index','活动大厅','/vol/list',5,'tickets',195),(7,'index','我的报名','/vol/my',5,'notebook-2',190),(8,'index','积分排行','/vol/ranking',5,'data-line',185),(9,'admin','数据看板','/dashboard',0,'tickets',4),(10,'admin','日志审计','/dashboard/logs',9,'document-che',295);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;

#
# Structure for table "party_branches"
#

DROP TABLE IF EXISTS `party_branches`;
CREATE TABLE `party_branches` (
  `branch_id` int(11) NOT NULL AUTO_INCREMENT,
  `branch_name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`branch_id`),
  UNIQUE KEY `idx_name` (`branch_name`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COMMENT='26个党支部';

#
# Data for table "party_branches"
#

INSERT INTO `party_branches` VALUES (1,'神经内科党支部','2025-04-04 09:24:00'),(2,'心血管内科党支部','2025-04-04 09:24:00'),(3,'骨科党支部','2025-04-04 09:24:00'),(4,'消化内科党支部','2025-04-04 09:24:00'),(5,'呼吸与危重症医学科党支部','2025-04-04 09:24:00'),(6,'普通外科党支部','2025-04-04 09:24:00'),(7,'儿科党支部','2025-04-04 09:24:00'),(8,'妇产科党支部','2025-04-04 09:24:00'),(9,'麻醉手术科党支部','2025-04-04 09:24:00'),(10,'急诊重症科党支部','2025-04-04 09:24:00'),(11,'内科综合第一党支部','2025-04-04 09:24:00'),(12,'内科综合第二党支部','2025-04-04 09:24:00'),(13,'内科综合第三党支部','2025-04-04 09:24:00'),(14,'内科综合第四党支部','2025-04-04 09:24:00'),(15,'外科综合第一党支部','2025-04-04 09:24:00'),(16,'外科综合第二党支部','2025-04-04 09:24:00'),(17,'医技第一党支部','2025-04-04 09:24:00'),(18,'医技第二党支部','2025-04-04 09:24:00'),(19,'医技第三党支部','2025-04-04 09:24:00'),(20,'职能第一党支部','2025-04-04 09:24:00'),(21,'职能第二党支部','2025-04-04 09:24:00'),(22,'职能第三党支部','2025-04-04 09:24:00'),(23,'离退休第一党支部','2025-04-04 09:24:00'),(24,'离退休第二党支部','2025-04-04 09:24:00');

#
# Structure for table "role"
#

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL COMMENT '角色名称',
  `menus` varchar(255) DEFAULT NULL COMMENT '菜单ID集合',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

#
# Data for table "role"
#

/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (0,'vol','[1, 5, 6, 7, 8]'),(1,'admin','[1,2,3,4,5, 6, 7, 8,9,10]');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;

#
# Structure for table "users"
#

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '工号/用户名',
  `password` varchar(255) NOT NULL,
  `real_name` varchar(50) NOT NULL COMMENT '真实姓名',
  `id_card` varchar(18) NOT NULL COMMENT '身份证号，可用于PHP计算性别/生日',
  `birth_date` date DEFAULT NULL COMMENT '实际存储字段（需通过PHP填充）',
  `gender` tinyint(1) DEFAULT NULL COMMENT '0女1男（PHP计算后写入）',
  `phone` varchar(20) NOT NULL COMMENT '手机号',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像地址',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0待审核1正常2禁用',
  `role_id` int(11) NOT NULL COMMENT '角色ID 0普通志愿者1管理员',
  `is_party_member` tinyint(1) DEFAULT '0' COMMENT '是否党员',
  `dept_id` int(11) DEFAULT NULL COMMENT '所属科室',
  `branch_id` int(11) DEFAULT NULL COMMENT '所属党支部',
  `position` varchar(50) DEFAULT NULL COMMENT '职位',
  `title` varchar(50) DEFAULT NULL COMMENT '职称',
  `wx_openid` varchar(32) DEFAULT NULL COMMENT '微信openid',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `idx_phone` (`phone`),
  UNIQUE KEY `idx_id_card` (`id_card`),
  KEY `idx_dept` (`dept_id`),
  KEY `idx_branch` (`branch_id`),
  KEY `idx_gender` (`gender`) COMMENT '加速性别筛选'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='志愿者用户表';

#
# Data for table "users"
#

INSERT INTO `users` VALUES (1,'admin','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','张伟','310225199004041234',NULL,NULL,'13800138000',NULL,1,1,1,70,20,NULL,NULL,NULL,'2025-04-04 09:29:18','2025-04-04 09:30:19'),(2,'xiaoxiao','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','王芳','32068319950305789X',NULL,NULL,'13912345678',NULL,1,0,0,3,2,NULL,NULL,NULL,'2025-04-04 09:29:18','2025-04-04 13:30:46'),(3,'secretary01','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','李建国','330206198812121234',NULL,NULL,'13676543210',NULL,1,0,1,57,20,NULL,NULL,NULL,'2025-04-04 09:29:18','2025-04-04 09:32:24');
