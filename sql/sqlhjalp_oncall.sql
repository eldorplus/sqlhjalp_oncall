-- MySQL dump 10.13  Distrib 5.6.10, for Linux (i686)
--
-- Host: localhost    Database: sqlhjalp_oncall
-- ------------------------------------------------------
-- Server version	5.6.10-log

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
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact` (
  `contact_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile_phone` varchar(255) DEFAULT NULL,
  `mobile_domain` enum('archwireless.net','cellcom.quiktxt.com','cellularonewest.com','email.uscc.net','fido.ca','gocbw.com','message.alltel.com','messaging.nextel.com','messaging.sprintpcs.com','mmsviaero.com','mobile.celloneusa.com','msg.telus.com','myairmail.com','mymetropcs.com','page.metrocall.com','page.southernlinc.com','pcs.rogers.com','sms.bluecell.com','sms.mycricket.com','tmomail.net','tms.suncom.com','txt.att.net','txt.bellmobility.ca','vtext.com') DEFAULT NULL,
  `date_recorded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`contact_id`),
  UNIQUE KEY `mp` (`mobile_phone`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cron`
--

DROP TABLE IF EXISTS `cron`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cron` (
  `cron_id` int(11) NOT NULL AUTO_INCREMENT,
  `cron_name` varchar(255) DEFAULT NULL,
  `cron_type` enum('OFF','HTTP','HTTPS','SSH','MySQL','WGET','FTP','SHELL') DEFAULT NULL,
  `domain` varchar(255) DEFAULT NULL,
  `ip_address` int(10) unsigned DEFAULT NULL,
  `domain_ip` enum('domain','ip') NOT NULL DEFAULT 'ip',
  `command` varchar(255) DEFAULT NULL,
  `validate` varchar(255) DEFAULT NULL,
  `threshold` int(10) unsigned DEFAULT '0',
  `threshold_ratio` enum('5 MINUTE','15 MINUTE','30 MINUTE','45 MINUTE','1 HOUR','2 HOUR','4 HOUR','1 DAY','1 MONTH','1 YEAR') DEFAULT NULL,
  `time_recorded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `runtime` varchar(10) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cron_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`keith`@`localhost`*/ /*!50003 TRIGGER crons AFTER INSERT ON cron
FOR EACH ROW BEGIN 
INSERT INTO cron_times SET  cron_id = NEW.cron_id; 
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cron_failed_response`
--

DROP TABLE IF EXISTS `cron_failed_response`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cron_failed_response` (
  `cron_failed_response_id` int(11) NOT NULL AUTO_INCREMENT,
  `cron_id` int(11) NOT NULL,
  `response` varchar(255) DEFAULT NULL,
  `date_recorded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `acknowledge` tinyint(2) DEFAULT '0',
  PRIMARY KEY (`cron_failed_response_id`),
  KEY `tr` (`date_recorded`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cron_history`
--

DROP TABLE IF EXISTS `cron_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cron_history` (
  `cron_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `cron_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `date_recorded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cron_history_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cron_notifications`
--

DROP TABLE IF EXISTS `cron_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cron_notifications` (
  `cron_notifications_id` int(11) NOT NULL AUTO_INCREMENT,
  `cron_id` int(11) NOT NULL,
  `cron_failed_response_id` int(11) NOT NULL,
  `contact_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `time_recorded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cron_notifications_id`),
  KEY `tr` (`time_recorded`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cron_times`
--

DROP TABLE IF EXISTS `cron_times`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cron_times` (
  `cron_times_id` int(11) NOT NULL AUTO_INCREMENT,
  `cron_id` int(11) NOT NULL,
  `day_of_week` varchar(2) DEFAULT NULL,
  `month` varchar(2) DEFAULT NULL,
  `day_of_month` varchar(2) DEFAULT NULL,
  `hour` varchar(2) DEFAULT NULL,
  `min` varchar(2) DEFAULT NULL,
  `time_recorded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cron_times_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dashboard`
--

DROP TABLE IF EXISTS `dashboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dashboard` (
  `dashboard_id` int(11) NOT NULL AUTO_INCREMENT,
  `cron_id` int(11) NOT NULL,
  `cron_status` tinyint(2) DEFAULT NULL,
  `date_recorded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`dashboard_id`),
  UNIQUE KEY `Cid` (`cron_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `documentation`
--

DROP TABLE IF EXISTS `documentation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentation` (
  `documentation_id` int(11) NOT NULL AUTO_INCREMENT,
  `page_number` decimal(3,2) NOT NULL DEFAULT '0.00',
  `chapter` int(11) NOT NULL DEFAULT '0',
  `documentation_title` varchar(255) DEFAULT NULL,
  `documentation_txt` text,
  `date_recorded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`documentation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `events` (
  `events_id` int(11) NOT NULL AUTO_INCREMENT,
  `events_name` varchar(255) DEFAULT NULL,
  `contact_id` int(11) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `primary_contact` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`events_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `innodb_buffer_pool_size`
--

DROP TABLE IF EXISTS `innodb_buffer_pool_size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `innodb_buffer_pool_size` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `size` varchar(2) DEFAULT NULL,
  `time_recorded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `innodb_log_file_size`
--

DROP TABLE IF EXISTS `innodb_log_file_size`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `innodb_log_file_size` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `KB_WL_HR` varchar(5) DEFAULT NULL,
  `MB_WL_HR` varchar(5) DEFAULT NULL,
  `GB_WL_HR` varchar(5) DEFAULT NULL,
  `time_recorded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monitor_history`
--

DROP TABLE IF EXISTS `monitor_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monitor_history` (
  `monitor_history_id` int(11) NOT NULL AUTO_INCREMENT,
  `variable_name` varchar(25) DEFAULT NULL,
  `variable_value` int(10) DEFAULT '0',
  `time_recorded` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`monitor_history_id`),
  KEY `tr` (`time_recorded`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status` (
  `status_id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(25) DEFAULT NULL,
  `color` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping events for database 'sqlhjalp_oncall'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `innodb_buffer_pool_size` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`keith`@`localhost`*/ /*!50106 EVENT `innodb_buffer_pool_size` ON SCHEDULE EVERY 1 HOUR STARTS '2013-03-25 18:45:50' ON COMPLETION NOT PRESERVE ENABLE COMMENT 'Records suggested innodb buffer pool size' DO CALL innodb_buffer_pool_size() */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `innodb_log_file_size` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`keith`@`localhost`*/ /*!50106 EVENT `innodb_log_file_size` ON SCHEDULE EVERY 1 HOUR STARTS '2013-03-25 18:11:50' ON COMPLETION NOT PRESERVE ENABLE COMMENT 'Records suggested innodb log file size' DO CALL innodb_log_file_size() */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `max_used_connections` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`keith`@`localhost`*/ /*!50106 EVENT `max_used_connections` ON SCHEDULE EVERY 1 MINUTE STARTS '2013-04-10 10:29:24' ON COMPLETION NOT PRESERVE DISABLE ON SLAVE COMMENT 'Records max_used_connections' DO CALL max_used_connections() */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
/*!50106 DROP EVENT IF EXISTS `monitor` */;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE*/ /*!50117 DEFINER=`keith`@`localhost`*/ /*!50106 EVENT `monitor` ON SCHEDULE EVERY 5 MINUTE STARTS '2013-04-10 12:06:38' ON COMPLETION NOT PRESERVE ENABLE COMMENT 'Records monitors' DO BEGIN
        CALL slow_queries(); 
CALL created_tmp_disk_tables(); 
CALL handler_read_first();  
CALL key_reads(); 
CALL open_tables(); 
CALL threads_connected();
CALL select_full_join();
CALL max_used_connections();
      END */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'sqlhjalp_oncall'
--
/*!50003 DROP PROCEDURE IF EXISTS `connection_history` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`keith`@`localhost` PROCEDURE `connection_history`()
BEGIN     
INSERT INTO connection_history  SELECT NULL, @@max_connections, VARIABLE_VALUE , NOW() FROM INFORMATION_SCHEMA.SESSION_STATUS WHERE VARIABLE_NAME LIKE 'max_used_connections';
     END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `created_tmp_disk_tables` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`keith`@`localhost` PROCEDURE `created_tmp_disk_tables`()
BEGIN     
INSERT INTO monitor_history  SELECT NULL, VARIABLE_NAME, VARIABLE_VALUE , NOW() FROM INFORMATION_SCHEMA.SESSION_STATUS WHERE VARIABLE_NAME LIKE 'created_tmp_disk_tables';
     END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `day_of_month` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`keith`@`localhost` PROCEDURE `day_of_month`()
BEGIN
       SET @RANGE_NUM=0 ;
SET @RANGE_NUM_B=0 ;
SELECT '*' , '*'
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1   , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1  
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1, @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION  
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1 
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1 
;
     END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `day_of_week` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`keith`@`localhost` PROCEDURE `day_of_week`()
BEGIN
       SET @RANGE_NUM=0 ;
SET @RANGE_NUM_B=0 ;
SELECT '*' , '*'
UNION 
SELECT @RANGE_NUM , @RANGE_NUM_B
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1   , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
;
     END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `handler_read_first` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`keith`@`localhost` PROCEDURE `handler_read_first`()
BEGIN     
INSERT INTO monitor_history  SELECT NULL, VARIABLE_NAME, VARIABLE_VALUE , NOW() FROM INFORMATION_SCHEMA.SESSION_STATUS WHERE VARIABLE_NAME LIKE 'handler_read_first';
     END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `hour` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`keith`@`localhost` PROCEDURE `hour`()
BEGIN
       SET @RANGE_NUM=0 ;
SET @RANGE_NUM_B=0 ;
SELECT '*' , '*'
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1   , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1  
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1, @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION  
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1 
;
     END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `innodb_buffer_pool_size` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`keith`@`localhost` PROCEDURE `innodb_buffer_pool_size`()
BEGIN
INSERT INTO innodb_buffer_pool_size (size)
SELECT CONCAT(ROUND(KBS/POWER(1024, 
IF(PowerOf1024<0,0,IF(PowerOf1024>3,0,PowerOf1024)))+0.49999), 
SUBSTR(' KMG',IF(PowerOf1024<0,0, 
IF(PowerOf1024>3,0,PowerOf1024))+1,1)) recommended_innodb_buffer_pool_size 
FROM (SELECT SUM(data_length+index_length) KBS FROM information_schema.tables 
WHERE engine='InnoDB') A,  (SELECT 2 PowerOf1024) B;
     END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `innodb_log_file_size` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`keith`@`localhost` PROCEDURE `innodb_log_file_size`()
BEGIN
       SET @TimeInterval = 3600;
SET @TimeInterval = 3600;
SELECT variable_value INTO @num1 FROM information_schema.global_status
WHERE variable_name = 'Innodb_os_log_written';
SELECT SLEEP(@TimeInterval);
SELECT variable_value INTO @num2 FROM information_schema.global_status
WHERE variable_name = 'Innodb_os_log_written';
SET @ByteWrittenToLog = @num2 - @num1;
SET @KB_WL_HR = @ByteWrittenToLog / POWER(1024,1) * 3600 / @TimeInterval;
SET @MB_WL_HR = @ByteWrittenToLog / POWER(1024,2) * 3600 / @TimeInterval;
SET @GB_WL_HR = @ByteWrittenToLog / POWER(1024,3) * 3600 / @TimeInterval;
INSERT INTO innodb_log_file_size SELECT NULL, @KB_WL_HR,@MB_WL_HR,@GB_WL_HR, NOW() ;

     END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `key_reads` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`keith`@`localhost` PROCEDURE `key_reads`()
BEGIN     
INSERT INTO monitor_history  SELECT NULL, VARIABLE_NAME, VARIABLE_VALUE , NOW() FROM INFORMATION_SCHEMA.SESSION_STATUS WHERE VARIABLE_NAME LIKE 'key_reads';
     END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `max_used_connections` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`keith`@`localhost` PROCEDURE `max_used_connections`()
BEGIN     
INSERT INTO monitor_history  SELECT NULL, VARIABLE_NAME, VARIABLE_VALUE , NOW() FROM INFORMATION_SCHEMA.SESSION_STATUS WHERE VARIABLE_NAME LIKE 'max_used_connections';
     END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `minutes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`keith`@`localhost` PROCEDURE `minutes`()
BEGIN
       SET @RANGE_NUM=0 ;
SET @RANGE_NUM_B=0 ;
SELECT '*' , '*'
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1   , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1  
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1, @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION  
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1 
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1 
UNION
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION
SELECT @RANGE_NUM :=  @RANGE_NUM +1   , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
;
     END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `month` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`keith`@`localhost` PROCEDURE `month`()
BEGIN
       SET @RANGE_NUM=0 ;
SET @RANGE_NUM_B=0 ;
SELECT '*' , '*'
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1   , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1 , @RANGE_NUM_B :=  @RANGE_NUM_B +1
UNION 
SELECT @RANGE_NUM :=  @RANGE_NUM +1  , @RANGE_NUM_B :=  @RANGE_NUM_B +1  
;
     END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `open_tables` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`keith`@`localhost` PROCEDURE `open_tables`()
BEGIN     
INSERT INTO monitor_history  SELECT NULL, VARIABLE_NAME, VARIABLE_VALUE , NOW() FROM INFORMATION_SCHEMA.SESSION_STATUS WHERE VARIABLE_NAME LIKE 'open_tables';
     END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `select_full_join` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`keith`@`localhost` PROCEDURE `select_full_join`()
BEGIN     
INSERT INTO monitor_history  SELECT NULL, VARIABLE_NAME, VARIABLE_VALUE , NOW() FROM INFORMATION_SCHEMA.SESSION_STATUS WHERE VARIABLE_NAME LIKE 'select_full_join';
     END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `slow_queries` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`keith`@`localhost` PROCEDURE `slow_queries`()
BEGIN     
INSERT INTO monitor_history  SELECT NULL, VARIABLE_NAME, VARIABLE_VALUE , NOW() FROM INFORMATION_SCHEMA.SESSION_STATUS WHERE VARIABLE_NAME LIKE 'slow_queries';
     END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `threads_connected` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`keith`@`localhost` PROCEDURE `threads_connected`()
BEGIN     
INSERT INTO monitor_history  SELECT NULL, VARIABLE_NAME, VARIABLE_VALUE , NOW() FROM INFORMATION_SCHEMA.SESSION_STATUS WHERE VARIABLE_NAME LIKE 'threads_connected';
     END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-04-13 19:42:45
