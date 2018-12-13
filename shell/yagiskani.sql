-- MySQL dump 10.16  Distrib 10.1.30-MariaDB, for Win32 (AMD64)
--
-- Host: localhost    Database: cake_demo
-- ------------------------------------------------------
-- Server version	10.1.30-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `yagis`
--

DROP TABLE IF EXISTS `yagis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `yagis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `yagi_name` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '山羊名',
  `yagi_val1` int(11) DEFAULT NULL COMMENT '山羊値１',
  `yagi_date` date DEFAULT NULL,
  `yagi_x_date` date NOT NULL COMMENT '山羊X日付',
  `yagi_group` int(11) DEFAULT NULL COMMENT '山羊種別',
  `yagi_dt` datetime DEFAULT NULL,
  `note` text CHARACTER SET utf8 NOT NULL COMMENT '備考',
  `sort_no` int(11) DEFAULT '0' COMMENT '順番',
  `delete_flg` tinyint(1) DEFAULT '0' COMMENT '無効フラグ',
  `update_user` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT '更新者',
  `ip_addr` varchar(40) CHARACTER SET utf8 DEFAULT NULL COMMENT 'IPアドレス',
  `created` datetime DEFAULT NULL COMMENT '生成日時',
  `modified` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `yagis`
--

LOCK TABLES `yagis` WRITE;
/*!40000 ALTER TABLE `yagis` DISABLE KEYS */;
INSERT INTO `yagis` VALUES (1,'大山やぎたつ',NULL,NULL,'0000-00-00',1,NULL,'',NULL,1,'kani','::1','2018-04-28 15:51:34','2018-04-28 06:52:32'),(2,'TEST2',NULL,NULL,'0000-00-00',1,NULL,'',-1,1,'kani','::1','2018-04-28 15:52:25','2018-04-28 06:52:33'),(3,'TEST32',100,'2018-04-28','0000-00-00',1,NULL,'',-1,0,'kani','::1','2018-04-28 15:52:39','2018-04-28 13:02:56'),(4,'TEST4',1235,'2018-03-12','2018-03-12',NULL,NULL,'',-2,0,'kani','::1','2018-04-29 06:55:45','2018-04-28 21:56:14'),(5,'',NULL,'2018-04-02','0000-00-00',1,NULL,'',-3,0,'kani','::1','2018-04-29 07:13:25','2018-04-28 22:13:25');
/*!40000 ALTER TABLE `yagis` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-12-13 15:26:44
