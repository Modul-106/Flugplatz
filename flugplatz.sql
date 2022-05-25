-- MariaDB dump 10.19  Distrib 10.7.3-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: flugschule
-- ------------------------------------------------------
-- Server version       10.7.3-MariaDB-1:10.7.3+maria~focal

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table ` hat_flugberechtigung`
--

DROP TABLE IF EXISTS ` hat_flugberechtigung`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE ` hat_flugberechtigung` (
  `fk_lizenz_id` int(10) unsigned NOT NULL,
  `lizenz_type` enum('S','L') NOT NULL,
  `fk_flugzeugtype_id` int(11) NOT NULL,
  PRIMARY KEY (`fk_lizenz_id`,`fk_flugzeugtype_id`),
  KEY `fk_lizenz_has_flugzeug_lizenz1_idx` (`fk_lizenz_id`),
  KEY `fk_ hat_flugberechtigung_flugzeugtyp1_idx` (`fk_flugzeugtype_id`),
  CONSTRAINT `fk_ hat_flugberechtigung_flugzeugtyp1` FOREIGN KEY (`fk_flugzeugtype_id`) REFERENCES `flugzeugtyp` (`flugzeugtype_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_lizenz_has_flugzeug_lizenz1` FOREIGN KEY (`fk_lizenz_id`) REFERENCES `lizenz` (`lizenz_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table ` hat_flugberechtigung`
--

LOCK TABLES ` hat_flugberechtigung` WRITE;
/*!40000 ALTER TABLE ` hat_flugberechtigung` DISABLE KEYS */;
INSERT INTO ` hat_flugberechtigung` VALUES
(1,'S',2),
(1,'L',3),
(2,'L',1),
(2,'S',2),
(2,'L',3);
/*!40000 ALTER TABLE ` hat_flugberechtigung` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `addresse`
--

DROP TABLE IF EXISTS `addresse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `addresse` (
  `address_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PLZ` varchar(10) NOT NULL,
  `ort` varchar(45) NOT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresse`
--

LOCK TABLES `addresse` WRITE;
/*!40000 ALTER TABLE `addresse` DISABLE KEYS */;
INSERT INTO `addresse` VALUES
(1,'5200','Brugg'),
(2,'4017','Muttenz');
/*!40000 ALTER TABLE `addresse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flug`
--

DROP TABLE IF EXISTS `flug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flug` (
  `flug_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_flugzeug_id` int(10) unsigned NOT NULL,
  `fk_start` int(10) unsigned NOT NULL,
  `fk_landung` int(10) unsigned NOT NULL,
  `fk_pilot` int(10) unsigned NOT NULL,
  `fk_fluglehrer` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`flug_id`),
  KEY `fk_flug_flugzeug1_idx` (`fk_flugzeug_id`),
  KEY `fk_flug_flug_event1_idx` (`fk_start`),
  KEY `fk_flug_flug_event2_idx` (`fk_landung`),
  KEY `fk_flug_person1_idx` (`fk_pilot`),
  KEY `fk_flug_person2_idx` (`fk_fluglehrer`),
  CONSTRAINT `fk_flug_flug_event1` FOREIGN KEY (`fk_start`) REFERENCES `flug_event` (`flug_event_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_flug_flug_event2` FOREIGN KEY (`fk_landung`) REFERENCES `flug_event` (`flug_event_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_flug_flugzeug1` FOREIGN KEY (`fk_flugzeug_id`) REFERENCES `flugzeug` (`flugzeug_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_flug_person1` FOREIGN KEY (`fk_pilot`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_flug_person2` FOREIGN KEY (`fk_fluglehrer`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flug`
--

LOCK TABLES `flug` WRITE;
/*!40000 ALTER TABLE `flug` DISABLE KEYS */;
INSERT INTO `flug` VALUES
(1,1,10,11,2,1);
/*!40000 ALTER TABLE `flug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flug_event`
--

DROP TABLE IF EXISTS `flug_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flug_event` (
  `flug_event_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `event_date` date NOT NULL,
  `event_time` time NOT NULL,
  `fk_flugplatz_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`flug_event_id`),
  KEY `fk_flug_event_flugplatz1_idx` (`fk_flugplatz_id`),
  CONSTRAINT `fk_flug_event_flugplatz1` FOREIGN KEY (`fk_flugplatz_id`) REFERENCES `flugplatz` (`homebase_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flug_event`
--

LOCK TABLES `flug_event` WRITE;
/*!40000 ALTER TABLE `flug_event` DISABLE KEYS */;
INSERT INTO `flug_event` VALUES
(9,'2022-05-03','11:13:57',2),
(10,'2022-05-12','00:13:12',1),
(11,'2022-05-05','11:02:57',1),
(12,'2022-05-27','00:02:57',3);
/*!40000 ALTER TABLE `flug_event` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flugplatz`
--

DROP TABLE IF EXISTS `flugplatz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flugplatz` (
  `homebase_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `kürzel` varchar(10) NOT NULL,
  PRIMARY KEY (`homebase_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flugplatz`
--

LOCK TABLES `flugplatz` WRITE;
/*!40000 ALTER TABLE `flugplatz` DISABLE KEYS */;
INSERT INTO `flugplatz` VALUES
(1,'Bern','LSZB'),
(2,'Basel','LFSB'),
(3,'Zürich','LSZH');
/*!40000 ALTER TABLE `flugplatz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flugzeug`
--

DROP TABLE IF EXISTS `flugzeug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flugzeug` (
  `flugzeug_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fk_flugzeugtyp_id` int(11) NOT NULL,
  `fk_flugplatz_id` int(10) unsigned NOT NULL,
  `kennummer` varchar(45) NOT NULL,
  PRIMARY KEY (`flugzeug_id`),
  KEY `fk_flugzeug_flugzeugtyp1_idx` (`fk_flugzeugtyp_id`),
  KEY `fk_flugzeug_homebase1_idx` (`fk_flugplatz_id`),
  CONSTRAINT `fk_flugzeug_flugzeugtyp1` FOREIGN KEY (`fk_flugzeugtyp_id`) REFERENCES `flugzeugtyp` (`flugzeugtype_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_flugzeug_homebase1` FOREIGN KEY (`fk_flugplatz_id`) REFERENCES `flugplatz` (`homebase_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flugzeug`
--

LOCK TABLES `flugzeug` WRITE;
/*!40000 ALTER TABLE `flugzeug` DISABLE KEYS */;
INSERT INTO `flugzeug` VALUES
(1,1,1,'HB-CDE '),
(2,1,1,'HB-CFE'),
(3,2,2,'HB-OKX '),
(4,3,3,'HB-OKD');
/*!40000 ALTER TABLE `flugzeug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flugzeugtyp`
--

DROP TABLE IF EXISTS `flugzeugtyp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flugzeugtyp` (
  `flugzeugtype_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `fk_hersteller_id` int(10) unsigned NOT NULL,
  `sitzplätze` int(10) unsigned NOT NULL,
  `type` enum('Helikopter','Einmotor','Zweimotor','Segelflugzeug') NOT NULL,
  `kuerzel` varchar(45) NOT NULL,
  PRIMARY KEY (`flugzeugtype_id`),
  KEY `fk_flugzeugtypen_hersteller1_idx` (`fk_hersteller_id`),
  CONSTRAINT `fk_flugzeugtypen_hersteller1` FOREIGN KEY (`fk_hersteller_id`) REFERENCES `hersteller` (`hersteller_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flugzeugtyp`
--

LOCK TABLES `flugzeugtyp` WRITE;
/*!40000 ALTER TABLE `flugzeugtyp` DISABLE KEYS */;
INSERT INTO `flugzeugtyp` VALUES
(1,'Cessna',1,2,'Einmotor','C172'),
(2,'Piper',2,4,'Einmotor','PA28'),
(3,'Piper',3,6,'Zweimotor','PA34');
/*!40000 ALTER TABLE `flugzeugtyp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hersteller`
--

DROP TABLE IF EXISTS `hersteller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hersteller` (
  `hersteller_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`hersteller_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hersteller`
--

LOCK TABLES `hersteller` WRITE;
/*!40000 ALTER TABLE `hersteller` DISABLE KEYS */;
INSERT INTO `hersteller` VALUES
(1,'Skyhawk'),
(2,'Archer'),
(3,'Seneca');
/*!40000 ALTER TABLE `hersteller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lizenz`
--

DROP TABLE IF EXISTS `lizenz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lizenz` (
  `lizenz_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lizenz_nr` varchar(45) NOT NULL,
  `fk_person_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`lizenz_id`),
  KEY `fk_lizenz_person1_idx` (`fk_person_id`),
  CONSTRAINT `fk_lizenz_person1` FOREIGN KEY (`fk_person_id`) REFERENCES `person` (`person_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lizenz`
--

LOCK TABLES `lizenz` WRITE;
/*!40000 ALTER TABLE `lizenz` DISABLE KEYS */;
INSERT INTO `lizenz` VALUES
(1,'CH-8785112 ',1),
(2,'CH-5579',2);
/*!40000 ALTER TABLE `lizenz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `person` (
  `person_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `telefonnummer` varchar(45) NOT NULL,
  `fk_addresse_id` int(10) unsigned NOT NULL,
  `vorname` varchar(45) NOT NULL,
  `nachname` varchar(45) NOT NULL,
  `strasse` varchar(45) NOT NULL,
  PRIMARY KEY (`person_id`),
  KEY `fk_person_address_idx` (`fk_addresse_id`),
  CONSTRAINT `fk_person_address` FOREIGN KEY (`fk_addresse_id`) REFERENCES `addresse` (`address_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES
(1,'+447418 355494',1,'Hans','Meier','Musterstrasse 9 '),
(2,'+ 123 456 79 80',2,'Rudolf','Müller','Musterstrasse 102');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-24 12:59:11