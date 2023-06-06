-- MySQL dump 10.13  Distrib 8.0.31, for macos12 (x86_64)
--
-- Host: localhost    Database: easycondo
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `condosync` DEFAULT CHARACTER SET utf8 ;
USE `condosync` ;

--
-- Table structure for table `tb_bill`
--

DROP TABLE IF EXISTS `tb_bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_bill` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idCondo` int NOT NULL,
  `idResident` int NOT NULL,
  `month` varchar(10) NOT NULL,
  `year` varchar(4) NOT NULL,
  `urlPdf` mediumtext,
  `dueValue` double DEFAULT NULL,
  `dueDate` datetime DEFAULT NULL,
  `dtSent` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `hasOpened` tinyint NOT NULL,
  `dtOpened` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_condo_idx` (`idCondo`),
  KEY `fk_resident_idx` (`idResident`),
  CONSTRAINT `fk_bill_condo` FOREIGN KEY (`idCondo`) REFERENCES `tb_condo` (`id`),
  CONSTRAINT `fk_bill_resident` FOREIGN KEY (`idResident`) REFERENCES `tb_resident` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_calendar`
--

DROP TABLE IF EXISTS `tb_calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_calendar` (
  `id` int NOT NULL AUTO_INCREMENT,
  `day` datetime NOT NULL,
  `event` varchar(60) NOT NULL,
  `idCondo` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idCondo_idx` (`idCondo`),
  CONSTRAINT `` FOREIGN KEY (`idCondo`) REFERENCES `tb_condo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_complaint`
--

DROP TABLE IF EXISTS `tb_complaint`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_complaint` (
  `id` int NOT NULL AUTO_INCREMENT,
  `namePersonCreated` varchar(30) DEFAULT NULL,
  `lastNamePersonCreated` varchar(30) DEFAULT NULL,
  `phonePersonCreated` varchar(13) DEFAULT NULL,
  `topic` varchar(40) NOT NULL DEFAULT 'Outros' COMMENT '1 - ReclamaÃ§Ã£o\\n2 - Aviso\\n3 - SugestÃ£o\\n4 -  \\n0 - Outros',
  `description` varchar(200) NOT NULL,
  `attached` blob,
  `obs` varchar(140) DEFAULT NULL,
  `dtCreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtUpdated` datetime DEFAULT NULL,
  `status` varchar(1) NOT NULL DEFAULT 'N',
  `idCondo` int NOT NULL,
  `idResident` int NOT NULL,
  `response` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_complaint_tb_condo1_idx` (`idCondo`),
  KEY `fk_tb_complaint_tb_resident1_idx` (`idResident`),
  CONSTRAINT `fk_tb_complaint_tb_condo1` FOREIGN KEY (`idCondo`) REFERENCES `tb_condo` (`id`),
  CONSTRAINT `fk_tb_complaint_tb_resident1` FOREIGN KEY (`idResident`) REFERENCES `tb_resident` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_condo`
--

DROP TABLE IF EXISTS `tb_condo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_condo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `document` varchar(14) NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `zipCode` varchar(8) NOT NULL,
  `addressNumber` varchar(10) NOT NULL,
  `optAddress` varchar(20) DEFAULT NULL,
  `dtCreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtUpdated` datetime DEFAULT NULL,
  `status` varchar(1) NOT NULL DEFAULT 'A',
  `uidFirebase` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `document_UNIQUE` (`document`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_cooperators_settings`
--

DROP TABLE IF EXISTS `tb_cooperators_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_cooperators_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `document` varchar(18) NOT NULL,
  `job` varchar(45) NOT NULL,
  `status` varchar(1) NOT NULL DEFAULT 'A',
  `dtCreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtUpdated` datetime DEFAULT NULL,
  `idSettingCondo` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_cooperators_tb_setting_condo1_idx` (`idSettingCondo`),
  CONSTRAINT `fk_tb_cooperators_tb_setting_condo1` FOREIGN KEY (`idSettingCondo`) REFERENCES `tb_setting_condo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_notices`
--

DROP TABLE IF EXISTS `tb_notices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_notices` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `description` varchar(140) NOT NULL,
  `attached` mediumtext,
  `dtToDelete` datetime NOT NULL,
  `dtCreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtUpdated` datetime DEFAULT NULL,
  `status` varchar(1) NOT NULL DEFAULT 'A',
  `idCondo` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_notices_tb_condo1_idx` (`idCondo`),
  CONSTRAINT `fk_tb_notices_tb_condo1` FOREIGN KEY (`idCondo`) REFERENCES `tb_condo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_push`
--

DROP TABLE IF EXISTS `tb_push`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_push` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `description` varchar(140) NOT NULL,
  `dtSent` datetime NOT NULL COMMENT '\n',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_push_user`
--

DROP TABLE IF EXISTS `tb_push_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_push_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `idPush` int NOT NULL,
  `idUser` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_push_user_tb_push1_idx` (`idPush`),
  KEY `fk_tb_push_user_tb_user1_idx` (`idUser`),
  CONSTRAINT `fk_tb_push_user_tb_push1` FOREIGN KEY (`idPush`) REFERENCES `tb_push` (`id`),
  CONSTRAINT `fk_tb_push_user_tb_user1` FOREIGN KEY (`idUser`) REFERENCES `tb_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_recreation_settings`
--

DROP TABLE IF EXISTS `tb_recreation_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_recreation_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `price` double DEFAULT NULL,
  `availability` json NOT NULL,
  `dtCreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtUpdated` datetime DEFAULT NULL,
  `status` varchar(1) DEFAULT 'A',
  `idSettingCondo` int NOT NULL,
  `policyDocument` mediumtext,
  `description` varchar(140) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_recreation_settings_tb_setting_condo1_idx` (`idSettingCondo`),
  CONSTRAINT `fk_tb_recreation_settings_tb_setting_condo1` FOREIGN KEY (`idSettingCondo`) REFERENCES `tb_setting_condo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_reminder`
--

DROP TABLE IF EXISTS `tb_reminder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_reminder` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(80) NOT NULL,
  `description` varchar(120) DEFAULT NULL,
  `dtCreated` datetime DEFAULT CURRENT_TIMESTAMP,
  `idCondo` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idCondo_idx` (`idCondo`),
  CONSTRAINT `idCondo` FOREIGN KEY (`idCondo`) REFERENCES `tb_condo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_resident`
--

DROP TABLE IF EXISTS `tb_resident`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_resident` (
  `id` int NOT NULL AUTO_INCREMENT,
  `apartament` varchar(10) NOT NULL,
  `optApartament` varchar(45) DEFAULT NULL,
  `isRental` tinyint NOT NULL,
  `idUser` int DEFAULT NULL,
  `idCondo` int NOT NULL,
  `idUserRental` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_resident_tb_user_idx` (`idUser`),
  KEY `fk_tb_resident_tb_condo1_idx` (`idCondo`),
  KEY `fk_tb_resident_tb_user_rental_idx` (`idUserRental`),
  CONSTRAINT `fk_tb_resident_tb_condo1` FOREIGN KEY (`idCondo`) REFERENCES `tb_condo` (`id`),
  CONSTRAINT `fk_tb_resident_tb_user` FOREIGN KEY (`idUser`) REFERENCES `tb_user` (`id`),
  CONSTRAINT `fk_tb_resident_tb_user_rental` FOREIGN KEY (`idUserRental`) REFERENCES `tb_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_schedules`
--

DROP TABLE IF EXISTS `tb_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_schedules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `local` varchar(45) DEFAULT NULL,
  `dtScheduled` datetime NOT NULL,
  `wasPaid` tinyint NOT NULL DEFAULT '1',
  `dtCreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idUser` int NOT NULL,
  `idCondo` int NOT NULL,
  `idResident` int NOT NULL,
  `idRecreation` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idCondo_idx` (`idCondo`),
  KEY `idUser_idx` (`idUser`),
  KEY `idResident_idx` (`idResident`),
  KEY `fk_recreation` (`idRecreation`),
  CONSTRAINT `fk_condo` FOREIGN KEY (`idCondo`) REFERENCES `tb_condo` (`id`),
  CONSTRAINT `fk_recreation` FOREIGN KEY (`idRecreation`) REFERENCES `tb_recreation_settings` (`id`),
  CONSTRAINT `fk_resident` FOREIGN KEY (`idResident`) REFERENCES `tb_resident` (`id`),
  CONSTRAINT `fk_user` FOREIGN KEY (`idUser`) REFERENCES `tb_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_setting_condo`
--

DROP TABLE IF EXISTS `tb_setting_condo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_setting_condo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `isConfigurated` tinyint NOT NULL DEFAULT '0',
  `idCondo` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_setting_condo_tb_condo1_idx` (`idCondo`),
  CONSTRAINT `fk_tb_setting_condo_tb_condo1` FOREIGN KEY (`idCondo`) REFERENCES `tb_condo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_tower_settings`
--

DROP TABLE IF EXISTS `tb_tower_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_tower_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `dtCreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtUpdated` datetime DEFAULT NULL,
  `idSettingCondo` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tb_tower_settings_tb_setting_condo1_idx` (`idSettingCondo`),
  CONSTRAINT `fk_tb_tower_settings_tb_setting_condo1` FOREIGN KEY (`idSettingCondo`) REFERENCES `tb_setting_condo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tb_user`
--

DROP TABLE IF EXISTS `tb_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `lastName` varchar(30) NOT NULL,
  `document` varchar(11) NOT NULL,
  `email` varchar(140) NOT NULL,
  `phone` varchar(13) NOT NULL,
  `dtCreated` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dtUpdated` datetime DEFAULT NULL,
  `deviceToken` varchar(255) DEFAULT NULL,
  `status` varchar(1) NOT NULL DEFAULT 'A',
  `uidFirebase` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-06 14:53:00
