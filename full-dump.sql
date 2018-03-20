-- MySQL dump 10.16  Distrib 10.1.31-MariaDB, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: CS434
-- ------------------------------------------------------
-- Server version	10.2.11-MariaDB-10.2.11+maria~jessie

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
-- Table structure for table `CPU`
--

DROP TABLE IF EXISTS `CPU`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CPU` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `#Cores` int(10) unsigned DEFAULT NULL,
  `#vCores` int(10) unsigned DEFAULT NULL,
  `TurboClock` double DEFAULT NULL,
  `Clock` double DEFAULT NULL,
  `MaxPowerDraw` int(10) unsigned DEFAULT NULL,
  `SocketID` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `CPU_Socket_ID_fk` (`SocketID`),
  KEY `CPU_ID_uindex` (`ID`),
  CONSTRAINT `CPU_Part_ID_fk` FOREIGN KEY (`ID`) REFERENCES `Part` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `CPU_Socket_ID_fk` FOREIGN KEY (`SocketID`) REFERENCES `Socket` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CPU`
--

LOCK TABLES `CPU` WRITE;
/*!40000 ALTER TABLE `CPU` DISABLE KEYS */;
INSERT INTO `CPU` (`ID`, `#Cores`, `#vCores`, `TurboClock`, `Clock`, `MaxPowerDraw`, `SocketID`) VALUES (1,6,12,4.7,3.7,95,1),(2,6,6,4.3,3.6,95,1),(3,4,4,4,4,91,1),(4,8,16,4,3.6,95,2),(5,6,12,4,3.6,95,2),(6,4,4,3.7,3.5,65,2);
/*!40000 ALTER TABLE `CPU` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GraphicsCard`
--

DROP TABLE IF EXISTS `GraphicsCard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GraphicsCard` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `#Shaders` smallint(5) unsigned DEFAULT NULL,
  `#Vram` smallint(5) unsigned DEFAULT NULL,
  `MinClock` double DEFAULT NULL,
  `Clock` double DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `GraphicsCard_ID_uindex` (`ID`),
  KEY `Monitor_ID_uindex` (`ID`),
  CONSTRAINT `GraphicsCard_Part_ID_fk` FOREIGN KEY (`ID`) REFERENCES `Part` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GraphicsCard`
--

LOCK TABLES `GraphicsCard` WRITE;
/*!40000 ALTER TABLE `GraphicsCard` DISABLE KEYS */;
INSERT INTO `GraphicsCard` (`ID`, `#Shaders`, `#Vram`, `MinClock`, `Clock`) VALUES (7,3584,11,1594,1708),(8,2432,8,1683,1721),(9,1280,6,1531,1746),(10,4096,8,1590,1590),(11,3584,8,1297,1573),(12,2304,8,1360,1380);
/*!40000 ALTER TABLE `GraphicsCard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `GraphicsConnector`
--

DROP TABLE IF EXISTS `GraphicsConnector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GraphicsConnector` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) DEFAULT NULL,
  `Version` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `GraphicsConnector_ID_uindex` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `GraphicsConnector`
--

LOCK TABLES `GraphicsConnector` WRITE;
/*!40000 ALTER TABLE `GraphicsConnector` DISABLE KEYS */;
INSERT INTO `GraphicsConnector` (`ID`, `Name`, `Version`) VALUES (1,'HDMI','2.0'),(2,'HDMI','2.1'),(3,'VGA',NULL),(4,'DVI','I'),(5,'DVI','D'),(6,'Display Port','1.2a');
/*!40000 ALTER TABLE `GraphicsConnector` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Manufacturer`
--

DROP TABLE IF EXISTS `Manufacturer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Manufacturer` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Manufacturer_ID_uindex` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Manufacturer`
--

LOCK TABLES `Manufacturer` WRITE;
/*!40000 ALTER TABLE `Manufacturer` DISABLE KEYS */;
INSERT INTO `Manufacturer` (`ID`, `Name`) VALUES (1,'Intel'),(2,'AMD'),(3,'Dell'),(4,'ASUS'),(5,'Crucial'),(6,'EVGA'),(7,'NVIDIA');
/*!40000 ALTER TABLE `Manufacturer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Monitor`
--

DROP TABLE IF EXISTS `Monitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Monitor` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Size` double DEFAULT NULL,
  `Width` smallint(5) unsigned DEFAULT NULL,
  `Height` smallint(5) unsigned DEFAULT NULL,
  `Refresh_Rate` double DEFAULT NULL,
  PRIMARY KEY (`ID`),
  CONSTRAINT `Monitor_Part_ID_fk` FOREIGN KEY (`ID`) REFERENCES `Part` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Monitor`
--

LOCK TABLES `Monitor` WRITE;
/*!40000 ALTER TABLE `Monitor` DISABLE KEYS */;
INSERT INTO `Monitor` (`ID`, `Size`, `Width`, `Height`, `Refresh_Rate`) VALUES (13,27,1920,1080,75),(14,23,1920,1080,60),(16,27,1920,1080,60),(17,27,1920,1080,75),(18,19.5,1600,900,55);
/*!40000 ALTER TABLE `Monitor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Motherboard`
--

DROP TABLE IF EXISTS `Motherboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Motherboard` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `#RamSlots` tinyint(3) unsigned DEFAULT NULL,
  `MaxRam` smallint(5) unsigned DEFAULT NULL,
  `#PCIESlots` tinyint(3) unsigned DEFAULT NULL,
  `#SataPorts` tinyint(3) unsigned DEFAULT NULL,
  `SocketID` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Motherboard_Socket_ID_fk` (`SocketID`),
  KEY `Motherboard_ID_uindex` (`ID`),
  CONSTRAINT `Motherboard_Part_ID_fk` FOREIGN KEY (`ID`) REFERENCES `Part` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `Motherboard_Socket_ID_fk` FOREIGN KEY (`SocketID`) REFERENCES `Socket` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Motherboard`
--

LOCK TABLES `Motherboard` WRITE;
/*!40000 ALTER TABLE `Motherboard` DISABLE KEYS */;
INSERT INTO `Motherboard` (`ID`, `#RamSlots`, `MaxRam`, `#PCIESlots`, `#SataPorts`, `SocketID`) VALUES (19,4,64,5,6,1),(20,4,64,5,6,1),(21,4,64,3,8,2),(22,4,64,6,6,1),(23,4,64,2,6,1),(24,4,64,3,8,2);
/*!40000 ALTER TABLE `Motherboard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Part`
--

DROP TABLE IF EXISTS `Part`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Part` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `SKU` varchar(128) DEFAULT NULL,
  `Name` varchar(32) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `Release_Date` datetime DEFAULT NULL,
  `ManufacturerID` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Part_SKU_uindex` (`SKU`),
  KEY `Part_Manufacturer_ID_fk` (`ManufacturerID`),
  KEY `Part_ID_SKU_Name_index` (`ID`,`SKU`,`Name`),
  CONSTRAINT `Part_Manufacturer_ID_fk` FOREIGN KEY (`ManufacturerID`) REFERENCES `Manufacturer` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Part`
--

LOCK TABLES `Part` WRITE;
/*!40000 ALTER TABLE `Part` DISABLE KEYS */;
INSERT INTO `Part` (`ID`, `SKU`, `Name`, `Description`, `Release_Date`, `ManufacturerID`) VALUES (1,'BX80684I78700K','i7-8700k','Coffee Lake 6-Core i7','2017-09-01 23:20:04',1),(2,'BX80684I58600K','i5-8600K','Coffee Lake 6-Core','2017-10-01 23:22:14',1),(3,'BX80684I38350K','i3-8350K','Coffee Lake 4-Core','2017-10-01 23:23:55',1),(4,'YD180XBCAEWOF','RYZEN 7 1800X','Ryzen 7 8-Coire','2017-03-02 23:26:47',2),(5,'YD160XBCAEWOF','RYZEN 5 1600X','Ryzen 5 6-Core','2017-04-11 23:28:33',2),(6,'YD130XBBAEBOX','RYZEN 3 1300X','Ryzen 3 4-Core','2017-04-11 23:30:03',2),(7,'STRIX-GTX1080TI-O11G-GAMING','GTX 1080ti','Nvidia GTX 1080ti','2017-03-10 23:32:57',7),(8,'STRIX-GTX1070TI-8G-GAMING','GTX 1070ti','Nvidia GTX 1070ti','2017-11-02 23:35:09',7),(9,'STRIX-GTX1060-6G-GAMING','GTX 1060','Nvidia GTX 1060','2017-10-03 23:37:42',7),(10,'STRIX-RXVEGA64-O8G-GAMING','Radeon RX Vega 64','AMD Radeon RX Vega 64','2017-08-14 23:39:52',2),(11,'ROG-STRIX-RXVEGA56-O8G-GAMING ','Radeon RX Vega 56','AMD Radeon RX Vega 56','2017-08-28 23:41:30',2),(12,'ROG-STRIX-RX580-O8G-GAMING','Radeon RX 580','AMD Radeon RX 580','2017-04-17 23:43:28',2),(13,'SE2717HR','Dell 27\" IPS ','27\" IPS FHD FreeSync Monitor','2016-03-03 23:47:07',3),(14,'S2318HN','Dell 27\" IPS','23\" IPS LED FHD Monitor','2017-03-03 23:49:22',3),(15,'E1916H','Dell 19\" Monitor','19\" LED Monitor','2016-03-03 23:50:25',3),(16,'ED273','27\" LED Monitor','27\" 1920x1080 Monitor','2015-03-03 23:52:02',4),(17,'VZ279H','27\" Frameless Monitor','27\" Frameless 5ms IPS Monitor','2017-03-03 23:53:19',4),(18,'VS207D-P','19.5\" LED Monitor','19.5\" LED LCD Monitor','2016-03-03 23:54:42',4),(19,'Z370-A','Prime Z370-A','Prime Z370-A LGA 1151 Motherboard','2017-10-03 01:23:38',4),(20,'N82E16813119032','ROG Maximus X Hero','ASUS ROG Maximus X Hero (Wi-Fi AC) LGA 1151','2017-10-03 01:25:33',4),(21,'3515845295238736436_916918627343016907_6136318','ASUS ROG Crosshair VI Hero','ASUS ROG CROSSHAIR VI HERO with AMD X370','2017-04-02 01:28:01',4),(22,'134-KS-E377-KR','EVGA Z370 FTW','EVGA Z370 Motherboard','2017-05-02 01:29:53',6),(23,'121-KS-E375-KR','EVGA Z370 Stinger','EVGA Z370 Stinger MicroATX Motherboard','2017-04-02 01:31:45',6),(24,'X370-Pro ','ASUS Prime X370 PRO','ASUS Prime X370 Pro AM4','2017-06-02 01:34:10',4),(25,'BLS2KIT4G3D1609DS1S00 ','Ballistix Sport','Crucial Ballistix Sport 8GB Kit','2012-09-02 01:36:22',5),(26,'BLS8G4D26BFSC ','Sport LT','Crucial Sport LT 8GB','2016-06-02 01:38:31',5),(27,'BLS8G4D240FSB ','Ballistix Sport LT','Crucial Ballistix Sport LT 8GB','2015-08-02 01:39:25',5),(28,'BLT8G4D30AETA ','Ballistix Tactical','Crucial Ballistix Tactical 8GB Kit','2015-09-03 01:40:15',5),(29,'BLE2C8G4D32BEEAK','Ballistix Elite','Crucial Ballistix Elite 16GB Kit','2017-10-02 01:41:16',5),(30,'CT11004038 ','Crucial Memory','Crucial 4x16GB Ram','2016-06-09 01:42:22',5);
/*!40000 ALTER TABLE `Part` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ram`
--

DROP TABLE IF EXISTS `Ram`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Ram` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Type` varchar(16) DEFAULT NULL,
  `Speed` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `RAM_ID_uindex` (`ID`),
  CONSTRAINT `Ram_Part_ID_fk` FOREIGN KEY (`ID`) REFERENCES `Part` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ram`
--

LOCK TABLES `Ram` WRITE;
/*!40000 ALTER TABLE `Ram` DISABLE KEYS */;
INSERT INTO `Ram` (`ID`, `Type`, `Speed`) VALUES (25,'DDR3','1600'),(26,'DDR4','2666'),(27,'DDR4','2400'),(28,'DDR4','3000'),(29,'DDR4','3200'),(30,'DDR4','2666');
/*!40000 ALTER TABLE `Ram` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Sells`
--

DROP TABLE IF EXISTS `Sells`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Sells` (
  `StoreID` int(10) unsigned DEFAULT NULL,
  `PartID` int(10) unsigned DEFAULT NULL,
  `Cost` double unsigned DEFAULT NULL,
  KEY `Sells_Part_ID_fk` (`PartID`),
  KEY `Sells_StoreID_PartID_index` (`StoreID`,`PartID`),
  CONSTRAINT `Sells_Part_ID_fk` FOREIGN KEY (`PartID`) REFERENCES `Part` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `Sells_Store_ID_fk` FOREIGN KEY (`StoreID`) REFERENCES `Store` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Sells`
--

LOCK TABLES `Sells` WRITE;
/*!40000 ALTER TABLE `Sells` DISABLE KEYS */;
INSERT INTO `Sells` (`StoreID`, `PartID`, `Cost`) VALUES (1,1,349.99),(1,2,409.69),(1,3,179.99),(1,4,359.99),(1,5,207.9),(1,6,114.99),(1,7,1499),(1,8,899),(1,9,399.99),(1,10,1199.99),(2,11,899.99),(2,12,599.99),(2,13,152.95),(2,14,127.99),(2,15,86.95),(2,16,199.99),(2,17,178.57),(2,18,79.59),(2,19,149.99),(2,20,254.99),(3,21,139.99),(1,22,313.98),(1,23,219.99),(1,24,150.58),(1,25,78.74),(1,26,82.85),(1,27,91.99),(1,28,116.99),(1,30,500.99);
/*!40000 ALTER TABLE `Sells` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Socket`
--

DROP TABLE IF EXISTS `Socket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Socket` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ManufacturerID` int(10) unsigned DEFAULT NULL,
  `Name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Socket_Name_ManufactuererID_ID_uindex` (`ID`,`ManufacturerID`,`Name`),
  KEY `Socket_Manufactuerer_ID_fk` (`ManufacturerID`),
  CONSTRAINT `Socket_Manufactuerer_ID_fk` FOREIGN KEY (`ManufacturerID`) REFERENCES `Manufacturer` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Socket`
--

LOCK TABLES `Socket` WRITE;
/*!40000 ALTER TABLE `Socket` DISABLE KEYS */;
INSERT INTO `Socket` (`ID`, `ManufacturerID`, `Name`) VALUES (1,1,'LGA1151'),(2,2,'AM4');
/*!40000 ALTER TABLE `Socket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Store`
--

DROP TABLE IF EXISTS `Store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Store` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(32) DEFAULT NULL,
  `URL` varchar(32) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Store_Name_ID_uindex` (`Name`,`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Store`
--

LOCK TABLES `Store` WRITE;
/*!40000 ALTER TABLE `Store` DISABLE KEYS */;
INSERT INTO `Store` (`ID`, `Name`, `URL`) VALUES (1,'Newegg','newegg.com'),(2,'Amazon','amazon.com'),(3,'Best Buy','bestbuy.com');
/*!40000 ALTER TABLE `Store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SupportsConnector`
--

DROP TABLE IF EXISTS `SupportsConnector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SupportsConnector` (
  `MotherBoardID` int(10) unsigned DEFAULT NULL,
  `GraphicsCardID` int(10) unsigned DEFAULT NULL,
  `MonitorID` int(10) unsigned DEFAULT NULL,
  `GraphicsConnectorID` int(10) unsigned DEFAULT NULL,
  `Count` smallint(5) unsigned DEFAULT NULL,
  KEY `SupportsConnector_GraphicsCard_ID_fk` (`GraphicsCardID`),
  KEY `SupportsConnector_Monitor_ID_fk` (`MonitorID`),
  KEY `SupportsConnector_MotherBoardID_GraphicsCardID_MonitorID_index` (`MotherBoardID`,`GraphicsCardID`,`MonitorID`),
  CONSTRAINT `SupportsConnector_GraphicsCard_ID_fk` FOREIGN KEY (`GraphicsCardID`) REFERENCES `GraphicsCard` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `SupportsConnector_Monitor_ID_fk` FOREIGN KEY (`MonitorID`) REFERENCES `Monitor` (`ID`) ON DELETE CASCADE,
  CONSTRAINT `SupportsConnector_Motherboard_ID_fk` FOREIGN KEY (`MotherBoardID`) REFERENCES `Motherboard` (`ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SupportsConnector`
--

LOCK TABLES `SupportsConnector` WRITE;
/*!40000 ALTER TABLE `SupportsConnector` DISABLE KEYS */;
INSERT INTO `SupportsConnector` (`MotherBoardID`, `GraphicsCardID`, `MonitorID`, `GraphicsConnectorID`, `Count`) VALUES (19,7,13,1,1),(20,7,14,1,2),(22,10,17,5,9);
/*!40000 ALTER TABLE `SupportsConnector` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-03-03 20:22:59
