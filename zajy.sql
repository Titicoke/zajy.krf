# Host: localhost  (Version: 5.7.26)
# Date: 2025-04-09 17:46:19
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
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT '排序序号',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`dept_id`),
  UNIQUE KEY `idx_name` (`dept_name`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COMMENT='81个标准科室';

#
# Data for table "departments"
#

INSERT INTO `departments` VALUES (1,'急诊科',1,NULL,0,'2025-04-04 09:21:18'),(2,'重症医学科',1,NULL,0,'2025-04-04 09:21:18'),(3,'心血管内科',1,NULL,0,'2025-04-04 09:21:18'),(4,'神经内科',1,NULL,0,'2025-04-04 09:21:18'),(5,'呼吸与危重症医学科',1,NULL,0,'2025-04-04 09:21:18'),(6,'消化内科',1,NULL,0,'2025-04-04 09:21:18'),(7,'内分泌科',1,NULL,0,'2025-04-04 09:21:18'),(8,'风湿免疫科',1,NULL,0,'2025-04-04 09:21:18'),(9,'肾病科',1,NULL,0,'2025-04-04 09:21:18'),(10,'血液内科',1,NULL,0,'2025-04-04 09:21:18'),(11,'普外科一病区',1,NULL,0,'2025-04-04 09:21:18'),(12,'普外科二病区',1,NULL,0,'2025-04-04 09:21:18'),(13,'普外科三病区',1,NULL,0,'2025-04-04 09:21:18'),(14,'甲乳外科',1,NULL,0,'2025-04-04 09:21:18'),(15,'心胸外科',1,NULL,0,'2025-04-04 09:21:18'),(16,'神经外科',1,NULL,0,'2025-04-04 09:21:18'),(17,'骨科一病区',1,NULL,0,'2025-04-04 09:21:18'),(18,'骨科二病区',1,NULL,0,'2025-04-04 09:21:18'),(19,'骨科三病区',1,NULL,0,'2025-04-04 09:21:18'),(20,'骨科四病区',1,NULL,0,'2025-04-04 09:21:18'),(21,'骨科五病区',1,NULL,0,'2025-04-04 09:21:18'),(22,'泌尿外科',1,NULL,0,'2025-04-04 09:21:18'),(23,'疼痛科',1,NULL,0,'2025-04-04 09:21:18'),(24,'肿瘤科',1,NULL,0,'2025-04-04 09:21:18'),(25,'介入放射科',1,NULL,0,'2025-04-04 09:21:18'),(26,'妇科',1,NULL,0,'2025-04-04 09:21:18'),(27,'产科',1,NULL,0,'2025-04-04 09:21:18'),(28,'儿科',1,NULL,0,'2025-04-04 09:21:18'),(29,'眼科',1,NULL,0,'2025-04-04 09:21:18'),(30,'耳鼻喉科',1,NULL,0,'2025-04-04 09:21:18'),(31,'口腔科',1,NULL,0,'2025-04-04 09:21:18'),(32,'皮肤性病科',1,NULL,0,'2025-04-04 09:21:18'),(33,'感染性疾病科',1,NULL,0,'2025-04-04 09:21:18'),(34,'医疗美容科',1,NULL,0,'2025-04-04 09:21:18'),(35,'中医科',1,NULL,0,'2025-04-04 09:21:18'),(36,'康复医学科',1,NULL,0,'2025-04-04 09:21:18'),(37,'临床营养部',1,NULL,0,'2025-04-04 09:21:18'),(38,'全科医疗科',1,NULL,0,'2025-04-04 09:21:18'),(39,'老年医学科',1,NULL,0,'2025-04-04 09:21:18'),(40,'麻醉科',1,NULL,0,'2025-04-04 09:21:18'),(41,'日间病房',1,NULL,0,'2025-04-04 09:21:18'),(42,'医学影像科',2,NULL,0,'2025-04-04 09:21:18'),(43,'检验科',2,NULL,0,'2025-04-04 09:21:18'),(44,'超声医学科',2,NULL,0,'2025-04-04 09:21:18'),(45,'核医学科',2,NULL,0,'2025-04-04 09:21:18'),(46,'病理科',2,NULL,0,'2025-04-04 09:21:18'),(47,'手术室',2,NULL,0,'2025-04-04 09:21:18'),(48,'消毒供应中心',2,NULL,0,'2025-04-04 09:21:18'),(49,'输血科',2,NULL,0,'2025-04-04 09:21:18'),(50,'高压氧室',2,NULL,0,'2025-04-04 09:21:18'),(51,'病案统计科',2,NULL,0,'2025-04-04 09:21:18'),(52,'药学部',2,NULL,0,'2025-04-04 09:21:18'),(53,'健康管理中心',2,NULL,0,'2025-04-04 09:21:18'),(54,'介入导管室',2,NULL,0,'2025-04-04 09:21:18'),(55,'营养科',2,NULL,0,'2025-04-04 09:21:18'),(56,'特需体检部',2,NULL,0,'2025-04-04 09:21:18'),(57,'党委办公室',3,NULL,0,'2025-04-04 09:21:18'),(58,'院长办公室',3,NULL,0,'2025-04-04 09:21:18'),(59,'人事科',3,NULL,0,'2025-04-04 09:21:18'),(60,'纪检监察室',3,NULL,0,'2025-04-04 09:21:18'),(61,'宣传科',3,NULL,0,'2025-04-04 09:21:18'),(62,'医务科',3,NULL,0,'2025-04-04 09:21:18'),(63,'护理部',3,NULL,0,'2025-04-04 09:21:18'),(64,'绿色通道服务处',3,NULL,0,'2025-04-04 09:21:18'),(65,'门诊部',3,NULL,0,'2025-04-04 09:21:18'),(66,'医保科',3,NULL,0,'2025-04-04 09:21:18'),(67,'感染管理科',3,NULL,0,'2025-04-04 09:21:18'),(68,'预防保健科',3,NULL,0,'2025-04-04 09:21:18'),(69,'科教科',3,NULL,0,'2025-04-04 09:21:18'),(70,'信息科',3,NULL,0,'2025-04-04 09:21:18'),(71,'财务科',3,NULL,0,'2025-04-04 09:21:18'),(72,'审计科',3,NULL,0,'2025-04-04 09:21:18'),(73,'基建科',3,NULL,0,'2025-04-04 09:21:18'),(74,'后勤管理中心',3,NULL,0,'2025-04-04 09:21:18'),(75,'医学装备管理部',3,NULL,0,'2025-04-04 09:21:18'),(76,'医患关系协调办公室',3,NULL,0,'2025-04-04 09:21:18'),(77,'经营管理办公室',3,NULL,0,'2025-04-04 09:21:18'),(78,'工会办公室',3,NULL,0,'2025-04-04 09:21:18'),(79,'团委',3,NULL,0,'2025-04-04 09:21:18'),(80,'保卫科',3,NULL,0,'2025-04-04 09:21:18'),(81,'动力科',3,NULL,0,'2025-04-04 09:21:18'),(82,'宿管科',3,NULL,0,'2025-04-04 09:21:18');

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
  `sort_order` int(11) DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

#
# Data for table "menu"
#

/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` VALUES (1,'all','用户中心','/home',0,'tools',1),(2,'all','人员管理','/user',0,'user',2),(3,'all','活动专区','/admin',0,'postcard',3),(4,'all','学习专区','/mall',0,'goods',4),(5,'all','积分商城','/study',0,'present',5),(6,'all','添加活动','/q',3,'user',6),(7,'all','活动报名','/w',3,'notebook-2',1),(8,'all','报名查看','/e',3,'data-line',2),(9,'all','添加学习','/o',4,'tickets',1),(10,'all','学习查看','/r',4,'document-che',2),(11,'all','商品管理','/t',5,'user',1),(12,'all','兑换商品','/i',5,'user',2),(13,'all','兑换管理','/d',5,'user',0),(14,'all','开始学习','/z',4,'user',8),(15,'all','学习记录','/s',4,'user',9),(16,'all','兑换记录','/ss',5,'user',10),(17,'all','积分查看','/sss',3,'user',5);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;

#
# Structure for table "party_branches"
#

DROP TABLE IF EXISTS `party_branches`;
CREATE TABLE `party_branches` (
  `branch_id` int(11) NOT NULL AUTO_INCREMENT,
  `branch_name` varchar(100) NOT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`branch_id`),
  UNIQUE KEY `idx_name` (`branch_name`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COMMENT='26个党支部';

#
# Data for table "party_branches"
#

INSERT INTO `party_branches` VALUES (1,'神经内科党支部',NULL,'2025-04-04 09:24:00'),(2,'心血管内科党支部',NULL,'2025-04-04 09:24:00'),(3,'骨科党支部',NULL,'2025-04-04 09:24:00'),(4,'消化内科党支部',NULL,'2025-04-04 09:24:00'),(5,'呼吸与危重症医学科党支部',NULL,'2025-04-04 09:24:00'),(6,'普通外科党支部',NULL,'2025-04-04 09:24:00'),(7,'儿科党支部',NULL,'2025-04-04 09:24:00'),(8,'妇产科党支部',NULL,'2025-04-04 09:24:00'),(9,'麻醉手术科党支部',NULL,'2025-04-04 09:24:00'),(10,'急诊重症科党支部',NULL,'2025-04-04 09:24:00'),(11,'内科综合第一党支部',NULL,'2025-04-04 09:24:00'),(12,'内科综合第二党支部',NULL,'2025-04-04 09:24:00'),(13,'内科综合第三党支部',NULL,'2025-04-04 09:24:00'),(14,'内科综合第四党支部',NULL,'2025-04-04 09:24:00'),(15,'外科综合第一党支部',NULL,'2025-04-04 09:24:00'),(16,'外科综合第二党支部',NULL,'2025-04-04 09:24:00'),(17,'医技第一党支部',NULL,'2025-04-04 09:24:00'),(18,'医技第二党支部',NULL,'2025-04-04 09:24:00'),(19,'医技第三党支部',NULL,'2025-04-04 09:24:00'),(20,'职能第一党支部',NULL,'2025-04-04 09:24:00'),(21,'职能第二党支部',NULL,'2025-04-04 09:24:00'),(22,'职能第三党支部',NULL,'2025-04-04 09:24:00'),(23,'离退休第一党支部',NULL,'2025-04-04 09:24:00'),(24,'离退休第二党支部',NULL,'2025-04-04 09:24:00');

#
# Structure for table "position_types"
#

DROP TABLE IF EXISTS `position_types`;
CREATE TABLE `position_types` (
  `position_id` int(11) NOT NULL AUTO_INCREMENT,
  `dept_id` int(11) NOT NULL COMMENT '关联科室ID',
  `position_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `sort_order` int(11) NOT NULL DEFAULT '0' COMMENT '排序序号',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`position_id`),
  KEY `fk_dept_position` (`dept_id`),
  CONSTRAINT `fk_dept_position` FOREIGN KEY (`dept_id`) REFERENCES `departments` (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='科室关联岗位类型表';

#
# Data for table "position_types"
#

INSERT INTO `position_types` VALUES (1,1,'医疗',1,'2025-04-08 08:23:52'),(2,1,'护理',2,'2025-04-08 08:23:52'),(3,1,'医技',3,'2025-04-08 08:23:52'),(4,1,'行政后勤',4,'2025-04-08 09:52:33'),(5,1,'国投',5,'2025-04-08 09:52:50'),(6,1,'第三方',6,'2025-04-08 09:53:12'),(7,1,'住培生',7,'2025-04-08 09:53:33'),(8,1,'本科生',8,'2025-04-08 09:53:44'),(9,1,'社会工',9,'2025-04-08 09:53:59');

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
INSERT INTO `role` VALUES (0,'vol','[1, 3,4,5, 7, 8,12,14,15,16,17]'),(1,'admin','[1,2,3,4,5, 6,  8,9,10,11,13]');
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
  `post_id` int(11) DEFAULT NULL COMMENT '职位',
  `title` varchar(50) DEFAULT NULL COMMENT '职称',
  `wx_openid` varchar(32) DEFAULT NULL COMMENT '微信openid',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `idx_phone` (`phone`),
  UNIQUE KEY `idx_id_card` (`id_card`),
  UNIQUE KEY `username` (`username`),
  KEY `idx_dept` (`dept_id`),
  KEY `idx_branch` (`branch_id`),
  KEY `idx_gender` (`gender`) COMMENT '加速性别筛选'
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COMMENT='志愿者用户表';

#
# Data for table "users"
#

INSERT INTO `users` VALUES (1,'admin','$2y$10$pbASbW3ragtbwmpwbvk9de2aWeyjqAYCFhzj0S52sg7CM0cez2R1W','张伟','310225199004041234',NULL,1,'13800138000',NULL,1,1,1,70,20,1,NULL,NULL,'2025-04-04 09:29:18','2025-04-09 16:37:39'),(2,'xiaoxiao','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','王芳','32068319950305789X',NULL,1,'13912345678',NULL,1,0,0,3,NULL,1,NULL,NULL,'2025-04-04 09:29:18','2025-04-09 16:37:38'),(3,'secretary01','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','李建国','330206198812121234',NULL,1,'13676543210',NULL,1,0,1,57,20,1,NULL,NULL,'2025-04-04 09:29:18','2025-04-09 16:37:41'),(4,'xiaoxiaos','$2y$10$VSLqnB4.p6C7nb98tk0q/uzt9oTuJWjdPwpFS2MLMGEqbA1DXG7JC','对对对','111111111111111111','1111-11-11',1,'13111166579',NULL,0,0,1,2,2,1,'副主任医师',NULL,'2025-04-07 13:02:36','2025-04-08 09:19:01'),(5,'xiaoxiaos1122','$2y$10$sAS2EeqcZA9kuEDeYVYareeGKos9ijQOjL6QHX7lkOctOQqywGdtS','对对对','111111111111111114','1111-11-11',1,'13111166570',NULL,0,0,1,2,2,1,'副主任医师',NULL,'2025-04-07 13:07:21','2025-04-08 09:19:01'),(6,'xiaoxiaos11225','$2y$10$tfhMGX59QkHtZg.WITFwLO4HmvLIb4sIQvgEVJ6MRL2EOzoqzC7Jq','对对对','111111111111111154','1111-11-11',1,'13111166550',NULL,0,0,1,2,2,1,'副主任医师',NULL,'2025-04-07 13:09:24','2025-04-08 09:19:01'),(7,'xiaoxiaos112251','$2y$10$o6xfIz/.wfpTT1DojXn/oexhZFagxj3CBVvrRv.OzDmvfe5/GkL9a','对对对','111111111111111124','1111-11-11',0,'13111166551',NULL,0,0,1,2,2,1,'副主任医师',NULL,'2025-04-07 13:10:57','2025-04-08 09:19:02'),(8,'xiaoxiaos112252','$2y$10$.aYUcqMYU0elfm8/7VYFR.JzBNE6GGPwIZgqagdP2nmlzoMDmsf/m','对对对','111111111111211124','1111-11-21',0,'13111166552',NULL,0,0,1,2,2,1,'副主任医师',NULL,'2025-04-07 13:12:18','2025-04-08 09:19:02'),(9,'xiaoxiaodd','$2y$10$2K3RJY8QpHUUuDP0ge6NguT6xP..NwMKdhRamgVVmEqvOYx3uvYNG','对对对','111411111111111111','1111-11-11',1,'13111166479',NULL,0,0,0,6,NULL,1,'主任医师',NULL,'2025-04-07 13:42:27','2025-04-08 09:19:02'),(10,'xiaoxiaoss','$2y$10$u08g3PYfnE/jlZk.rJPVQeKz9sMYTj1Q83oP0ZXnzgYTdAAPfQpgy','孔瑞锋','140511198006105412','1980-06-10',1,'13111166578',NULL,0,0,1,2,6,1,'副主任医师',NULL,'2025-04-07 14:52:16','2025-04-08 09:19:02'),(11,'xiaqoxiao','$2y$10$IP6hLfIRI.dhy7VoFBzIjuEUwr.xnKtlHCK1PIsSRnHIbjEh3xUJ.','来看看','140525201307280091','2013-07-28',1,'16111166579',NULL,0,0,1,2,6,1,'主任医师',NULL,'2025-04-07 16:10:40','2025-04-08 09:19:03'),(12,'xiaoxiaddd','$2y$10$FZCeWrLaJe7zqkvIVkfhFe13NalL07NlMH4KkD3cz16ve27YZHNEi','孔负担','140511198006105416','1980-06-10',1,'13111166576',NULL,0,0,1,7,2,1,'主任医师',NULL,'2025-04-07 16:17:31','2025-04-08 09:19:03'),(13,'ffffffffffff','$2y$10$7pujLh6IAiRE0Qk2oIchaeZiQlRQ7as/o/fDDE2r9vHOgxlIhqCeC','顶顶顶顶','140511198006105419','1980-06-10',1,'13222222222',NULL,0,0,0,2,NULL,1,'副主任医师',NULL,'2025-04-07 16:20:44','2025-04-08 09:19:03'),(14,'dddddddddd','$2y$10$kDb9JbEUHk7kwQFC5YITuuneW/fO8z.4eKuXZxonadAKBJqxbZTpG','对对对的点点滴滴','140511198006105494','1980-06-10',1,'13111166573',NULL,0,0,1,2,3,1,'主任医师',NULL,'2025-04-07 16:47:04','2025-04-08 09:19:03'),(15,'dddddddddddd','$2y$10$7vuY6y8FAQPTGWizwi33DulmlABSPFlX7ewp24SEKPpI42R0XDmzq','对对对','5555','1980-06-10',1,'13222222229',NULL,0,0,1,1,6,1,'副主任医师',NULL,'2025-04-07 16:52:11','2025-04-08 09:19:04'),(16,'dddddddddddd55','$2y$10$AzNZDdIiANSjCp3CngCvw.Y4MXNbJx4gU8nB4K72cbEH2aYuIiS7q','对对对','140511198006105418','1980-06-10',1,'13222222220',NULL,0,0,1,1,6,1,'副主任医师',NULL,'2025-04-07 16:55:16','2025-04-08 09:19:04'),(17,'dddddddddddd553','$2y$10$O8xVoCJ.CXe7GCcN5MYV9O.pzpMSsgb8OnDCPN.oU9G6eAoEVyrb.','对对对','1405111980061054','1980-06-10',1,'13222222227',NULL,0,0,1,1,6,1,'副主任医师',NULL,'2025-04-07 16:56:14','2025-04-08 09:19:04'),(18,'434324324324','$2y$10$Psq0Cqih/bwYK/0WQK3Cyu8omm8PU4hd0iRyCbnjGSiWQjEC2hot.','地方','14051119800610他','1980-06-10',1,'13111116666',NULL,0,0,0,2,NULL,1,'副主任医师',NULL,'2025-04-07 16:58:18','2025-04-08 09:19:04'),(19,'ppppppppppppppppp','$2y$10$jzvhJvHuGMVi4iaClORmn.WHRerwZrR8Jbdh0eNGaxC5oWI.6AmMa','孔辅导费','呃呃','1980-06-10',1,'13666666666',NULL,0,0,1,7,2,1,'副主任医师',NULL,'2025-04-07 17:00:38','2025-04-08 09:19:05'),(20,'sssssssss','$2y$10$4fA2YtcVWvVpxgzTh36uf.6iFJCMo/BaNUtCkENN8F/TaWjrCgOM.','但是收得到吗','单独','1980-06-10',1,'18988888888',NULL,0,0,1,2,5,1,'主任医师',NULL,'2025-04-07 17:04:53','2025-04-08 09:19:05'),(21,'ooopp3','$2y$10$KjeV1YekH7D8RtTMpggEF./ifTmXHRIk4ab2kmBqS2iHmaLHZn/be','十点多','v','1980-06-10',1,'13566666666',NULL,0,0,1,2,1,1,'主任医师',NULL,'2025-04-07 17:18:08','2025-04-08 09:19:55'),(22,'44444444','$2y$10$iNTldwsPHXer1yeDajQUGuQMLnpIJys/Q9ifgaJSlpsPJAFX.Hku.','的方法','44','1980-06-10',1,'13111165555',NULL,0,0,1,1,5,1,'主任医师',NULL,'2025-04-08 09:24:02','2025-04-08 10:08:16'),(23,'3534543543','$2y$10$osOJ61V1DK0gWJtb3C5jBeWG2wjHfSJDXRhiKhkQiy1ePBRqDnuEm','发多少','地方','1980-06-10',1,'13555555555',NULL,0,0,1,3,6,3,'副高',NULL,'2025-04-08 10:09:15','2025-04-08 17:36:45'),(24,'sxaukrf','$2y$10$pbASbW3ragtbwmpwbvk9de2aWeyjqAYCFhzj0S52sg7CM0cez2R1W','孔瑞锋','140511的5414','1980-06-10',1,'13111163333',NULL,0,0,1,6,5,5,'正高',NULL,'2025-04-08 17:38:15','2025-04-09 14:46:49'),(25,'999999','$2y$10$a6I3JZDkLeTOZaQXPaSFg.XNdgxBykpuecpBMjhwGw1VmIFglyRLy','多少度','140511198006105414','1980-06-10',1,'13555555558',NULL,0,0,1,2,6,3,'副高',NULL,'2025-04-09 16:52:53','2025-04-09 16:52:53');
