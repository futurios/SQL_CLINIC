-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: clinic_management
-- ------------------------------------------------------
-- Server version	8.0.43

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

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clinic_id` int DEFAULT NULL,
  `doctor_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `patient_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `service_category` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `appointment_date` date NOT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `status` enum('upcoming','completed','cancelled','pending','checked_in','booked') COLLATE utf8mb4_general_ci DEFAULT 'booked',
  `notes` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `appointment_date` (`appointment_date`),
  KEY `status` (`status`),
  KEY `doctor_name` (`doctor_name`),
  KEY `patient_name` (`patient_name`),
  KEY `fk_clinic_id` (`clinic_id`),
  CONSTRAINT `fk_clinic_id` FOREIGN KEY (`clinic_id`) REFERENCES `clinic_details` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (4,NULL,'Aubrey Callahan','Thane Koch','Specialized','1982-06-08',NULL,NULL,'upcoming',NULL,'2025-06-29 16:29:45','2025-06-29 16:29:58'),(5,NULL,'Aubrey Callahan','Thane1 Koch','Lipi','2015-10-26',NULL,NULL,'upcoming',NULL,'2025-06-29 16:32:27','2025-06-29 16:32:27'),(6,NULL,'Alana12 Cotton','Thane1 Koch','Lipi','1989-04-09',NULL,NULL,'pending',NULL,'2025-07-10 08:59:05','2025-07-10 08:59:05');
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinic_details`
--

DROP TABLE IF EXISTS `clinic_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinic_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `contact_no` varchar(20) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `specialties` text,
  `address` text,
  `city` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `clinic_details_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `clinic_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinic_details`
--

LOCK TABLES `clinic_details` WRITE;
/*!40000 ALTER TABLE `clinic_details` DISABLE KEYS */;
INSERT INTO `clinic_details` VALUES (2,5,'7894561278',0,'Cardiology,Radiology,numorology','Jajpur','Jajpur','India','755007','68937516abc61_spider.jpg'),(3,6,'7894561234',1,'Dermatology,Urology','Jajpur','Jajpur','India','755007','');
/*!40000 ALTER TABLE `clinic_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinic_users`
--

DROP TABLE IF EXISTS `clinic_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinic_users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `user_email` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `full_name` varchar(150) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_email` (`user_email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinic_users`
--

LOCK TABLES `clinic_users` WRITE;
/*!40000 ALTER TABLE `clinic_users` DISABLE KEYS */;
INSERT INTO `clinic_users` VALUES (1,'super_admin','lipi1lopa@gmail.com','Super Admin','7676aaafb027c825bd9abab78b234070e702752f625b752e55e55b48e607e358','2025-07-21 19:36:10'),(5,'demo22','demo2@clinic.com','Demo clinic 2','$2y$10$nxT7VcsLsMZyE6CKxDAlouxGJUcdQj97uHF.saNx101B.iQekMALu','2025-07-26 20:22:25'),(6,'demo32','demo3@clinic.com','Demo clinic 3','$2y$10$UUPoWi5EsepjC.EwaHpeKeNvv4RUNdblbtTOQCqTelGKrFvx8gS/i','2025-07-26 21:07:21');
/*!40000 ALTER TABLE `clinic_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinics`
--

DROP TABLE IF EXISTS `clinics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinics` (
  `id` int NOT NULL AUTO_INCREMENT,
  `admin_id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `specialities` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_general_ci,
  `country` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `state` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `postal_code` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`),
  CONSTRAINT `clinics_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinics`
--

LOCK TABLES `clinics` WRITE;
/*!40000 ALTER TABLE `clinics` DISABLE KEYS */;
INSERT INTO `clinics` VALUES (1,1,'Sunayan Eye Care','Ophthalmology, Cataract Surgery, Refractive Surgery','Sunayan Marg, Satyabati Enclave, Behind State Bank of India','India','Odisha','Bargarh','768028');
/*!40000 ALTER TABLE `clinics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_sessions`
--

DROP TABLE IF EXISTS `doctor_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_sessions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `doctor_id` int NOT NULL,
  `clinic_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `days` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `time_slot` int DEFAULT NULL,
  `morning_start` time DEFAULT NULL,
  `morning_end` time DEFAULT NULL,
  `evening_start` time DEFAULT NULL,
  `evening_end` time DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_sessions`
--

LOCK TABLES `doctor_sessions` WRITE;
/*!40000 ALTER TABLE `doctor_sessions` DISABLE KEYS */;
INSERT INTO `doctor_sessions` VALUES (2,8,NULL,'Wed,Fri',5,'19:05:00','22:38:00','00:06:00','17:18:00','2025-06-28 07:50:22'),(3,10,NULL,'Mon,Tue,Sat',10,'21:47:00','21:26:00','01:33:00','11:28:00','2025-06-28 07:53:08'),(7,8,NULL,'Mon,Fri,Sun',15,'23:12:00','18:49:00','06:50:00','23:19:00','2025-06-28 13:54:54'),(8,13,NULL,'Mon,Tue,Wed,Fri,Sun',20,'23:46:00','10:17:00','04:37:00','20:11:00','2025-06-28 14:35:53'),(9,6,NULL,'Tue,Wed',5,'07:30:00','15:42:00','03:55:00','17:59:00','2025-06-28 14:37:03'),(10,11,NULL,'Mon,Wed,Sat',15,'04:13:00','07:55:00','22:33:00','20:35:00','2025-06-28 14:37:20');
/*!40000 ALTER TABLE `doctor_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_code` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contact_number` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `specialization` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `experience` int DEFAULT NULL,
  `status` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gender` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `degree` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `university` varchar(150) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `year_of_passing` int DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `state` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pin_code` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `profile_picture` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `clinic` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
INSERT INTO `doctors` VALUES (6,'Deacon','Flowers','gakulibip@mailinator.com','+91','+1 (499) 885-7705','2021-02-04','Sunt quis minima mol',45,'inactive','Female','Rerum nihil deserunt','Aut omnis nemo dolor',1986,'Doloremque nisi quae','Suscipit perspiciati','Quod ad aperiam amet','Ut libero quia praes','Qui maiores cumque a','Alias dolorem evenie','uploads/meditation-breathing-techniques-722x406.jpg','2025-06-22 10:40:41','Sunayan Eye Care'),(7,'Robin','Rivers','hiju@mailinator.com','+91','753 773-3968','1998-04-17','Corporis quo ipsam c',93,'active','Other','Aliquid quibusdam es','Et nesciunt officia',1971,'Et laborum fugit in','Dolor ut qui exceptu','Enim quisquam quod a','Ipsam molestias mole','Quia voluptatem quid','Velit incidunt aut','uploads/Footer_MainImage.jpg','2025-06-26 15:04:32','Sunayan Eye Care'),(8,'Idola','Little','hozonudy@mailinator.com','+91','2341561881','2004-12-03','Dolor quibusdam temp',54,'active','Other','Elit nisi ipsum ve','Id fugiat magnam rep',1977,'Velit non at veniam','Sed qui in aut possi','A est cupiditate qui','Non architecto volup','Facilis occaecat lab','Dolore quis consecte','uploads/108-sun-salutations-1024x683.jpg','2025-06-26 15:42:19','Sunayan Eye Care'),(9,'Aubrey','Callahan','perev@mailinator.com','+91','+1 (229) 935-1338','2004-04-10','Et eum nemo autem cu',43,'active','Female','Consequuntur quo fug','Sunt eum veniam dol',2015,'Qui aspernatur nobis','Aut et dolorum repre','Officia error except','Molestiae ut nulla i','Deserunt et rerum ea','Voluptate tempor ita','uploads/logo-1.webp','2025-06-26 15:43:11','Sunayan Eye Care'),(10,'Alana','Cotton','vehasejef@mailinator.com','+91','+91 9040030636','2008-03-11','Et quo sed nostrud q',32,'active','Male','Non aliquip pariatur','Quia nisi atque sunt',2004,'Velit voluptatem ob','Ut labore odio rerum','Ipsa elit nulla al','Molestiae minima in ','Nisi et velit aut e','Sint dolore veniam','','2025-06-28 06:47:10','Sunayan Eye Care'),(11,'Alanaaaa','Cotton','vehasejef@mailinator.com','+91','+91 9040030636','2008-03-11','Et quo sed nostrud q',32,'active','Male','Non aliquip pariatur','Quia nisi atque sunt',2001,'Velit voluptatem ob','Ut labore odio rerum','Ipsa elit nulla al','Molestiae minima in ','Nisi et velit aut e','Sint dolore veniam','','2025-06-28 06:47:36','Sunayan Eye Care'),(13,'Alana12','Cotton','vehasejef@mailinator.com','+91','+91 9040030636','2008-03-11','Et quo sed nostrud q',32,'active','Male','Non aliquip pariatur','Quia nisi atque sunt',2001,'Velit voluptatem ob','Ut labore odio rerum','Ipsa elit nulla al','Molestiae minima in ','Nisi et velit aut e','Sint dolore veniam','','2025-06-28 07:01:14','Sunayan Eye Care');
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter_services`
--

DROP TABLE IF EXISTS `encounter_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encounter_services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `encounter_id` int NOT NULL,
  `service_id` int NOT NULL,
  `quantity` int DEFAULT '1',
  `notes` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `encounter_id` (`encounter_id`),
  KEY `service_id` (`service_id`),
  CONSTRAINT `encounter_services_ibfk_1` FOREIGN KEY (`encounter_id`) REFERENCES `encounters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `encounter_services_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter_services`
--

LOCK TABLES `encounter_services` WRITE;
/*!40000 ALTER TABLE `encounter_services` DISABLE KEYS */;
/*!40000 ALTER TABLE `encounter_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounters`
--

DROP TABLE IF EXISTS `encounters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encounters` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `doctor_id` int NOT NULL,
  `patient_id` int NOT NULL,
  `clinic_id` int NOT NULL,
  `status` enum('scheduled','in-progress','completed','cancelled') COLLATE utf8mb4_general_ci DEFAULT 'scheduled',
  `description` text COLLATE utf8mb4_general_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `doctor_id` (`doctor_id`),
  KEY `patient_id` (`patient_id`),
  KEY `clinic_id` (`clinic_id`),
  CONSTRAINT `encounters_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`),
  CONSTRAINT `encounters_ibfk_2` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`id`),
  CONSTRAINT `encounters_ibfk_3` FOREIGN KEY (`clinic_id`) REFERENCES `clinics` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounters`
--

LOCK TABLES `encounters` WRITE;
/*!40000 ALTER TABLE `encounters` DISABLE KEYS */;
INSERT INTO `encounters` VALUES (2,'2015-06-23',13,5,1,'cancelled','Corporis ut veniam ','2025-07-04 14:33:52','2025-07-04 14:33:52'),(3,'2022-10-16',6,9,1,'cancelled','Ut tempora in est u','2025-07-04 14:33:58','2025-07-04 14:33:58'),(4,'2022-10-21',13,4,1,'completed','Saepe modi consequat','2025-07-04 14:34:04','2025-07-04 14:34:04'),(5,'2001-12-25',6,8,1,'scheduled','Consequat Adipisici','2025-07-04 14:34:09','2025-07-04 14:34:09'),(6,'1979-02-09',8,6,1,'scheduled','Enim eum sunt ration','2025-07-04 15:39:01','2025-07-04 15:39:01');
/*!40000 ALTER TABLE `encounters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `holidays`
--

DROP TABLE IF EXISTS `holidays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `holidays` (
  `id` int NOT NULL AUTO_INCREMENT,
  `holiday_of` enum('clinic','doctor') COLLATE utf8mb4_general_ci NOT NULL,
  `entity_id` int NOT NULL COMMENT 'ID of clinic or doctor',
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `holiday_of` (`holiday_of`,`entity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `holidays`
--

LOCK TABLES `holidays` WRITE;
/*!40000 ALTER TABLE `holidays` DISABLE KEYS */;
INSERT INTO `holidays` VALUES (2,'doctor',7,'1980-04-10','2012-06-27','2025-07-08 16:15:57','2025-07-08 16:15:57'),(3,'doctor',10,'2007-07-04','2021-09-13','2025-07-08 16:16:19','2025-07-08 16:16:19'),(5,'doctor',9,'2006-10-05','1970-04-17','2025-07-10 09:01:01','2025-07-10 09:01:01'),(6,'clinic',7,'1986-12-06','2012-12-23','2025-07-10 09:01:17','2025-07-10 09:01:17');
/*!40000 ALTER TABLE `holidays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patient` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `clinic` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `dob` date NOT NULL,
  `blood_group` varchar(5) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `gender` enum('Male','Female','Other') COLLATE utf8mb4_general_ci NOT NULL,
  `address` text COLLATE utf8mb4_general_ci,
  `city` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `country` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `postal_code` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'active',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (4,'Thane','Koch','gywiru@mailinator.com','Sunayan Eye Care','+1 (893) 962-7239','2003-02-12','B-','Male','Et veritatis laborum','Labore id qui ex vel','Ex veniam est ea ma','Quod dolor reprehend','2025-06-29 09:39:38','active'),(5,'Thane','Koch','gywiru@mailinator.com','Sunayan Eye Care','+1 (893) 962-7239','2003-02-12','B-','Male','Et veritatis laborum','Labore id qui ex vel','Ex veniam est ea ma','Quod dolor reprehend','2025-06-29 10:07:48','active'),(6,'Thane1','Koch','gywiru@mailinator.com','Sunayan Eye Care','+1 (893) 962-7239','2003-02-12','B-','Male','Et veritatis laborum','Labore id qui ex vel','Ex veniam est ea ma','Quod dolor reprehend','2025-06-29 10:07:56','active'),(8,'Imani','Dennis','vijitu@mailinator.com','Sunayan Eye Care','+1 (619) 953-4514','2003-07-21','B-','Female','Fuga Placeat non o','Velit eaque tenetur','Cumque tempora esse ','Quam dolor exercitat','2025-06-29 10:22:44','active'),(9,'Jadaaa','Albert','syqofi@mailinator.com','Sunayan Eye Care','+1 (617) 141-9337','1991-12-11','A+','Male','Dolor maxime ad eum ','Eum tempora deserunt','Ut saepe illo minim ','In inventore consequ','2025-06-29 10:25:58','active'),(10,'Quon','Rivera','cugo@mailinator.com','Sunayan Eye Care','+1 (916) 641-3152','1983-06-24','O+','Female','Qui aut id natus in ','Quisquam ad labore r','Quia non adipisicing','Vero eos illum enim','2025-06-29 10:26:32','active');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receptionists`
--

DROP TABLE IF EXISTS `receptionists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receptionists` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `country_code` varchar(5) COLLATE utf8mb4_general_ci NOT NULL DEFAULT '+91',
  `contact_number` varchar(20) COLLATE utf8mb4_general_ci NOT NULL,
  `dob` date DEFAULT NULL,
  `gender` enum('Male','Female','Other') COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'active',
  `profile_image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_general_ci,
  `country` varchar(50) COLLATE utf8mb4_general_ci DEFAULT 'India',
  `city` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `postal_code` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `contact_number` (`country_code`,`contact_number`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receptionists`
--

LOCK TABLES `receptionists` WRITE;
/*!40000 ALTER TABLE `receptionists` DISABLE KEYS */;
INSERT INTO `receptionists` VALUES (2,'Mariam','Jacobs','qigawic@mailinator.com','+1','12486766471','2019-12-03','Female','active','profile_1751298003.png','Consectetur aliquam','Nisi ut cillum offic','Non culpa consectet','Quia nisi rerum et a','2025-06-30 15:40:03','2025-07-02 16:40:25'),(4,'Conan','Hays','vilun@mailinator.com','+91','7942798','1976-02-01','Male','inactive','profile_1751470272.png','Nobis magnam consect','Aut officiis perfere','Id aut earum unde as','Reprehenderit iusto','2025-07-02 15:23:45','2025-07-18 14:55:00');
/*!40000 ALTER TABLE `receptionists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id` int NOT NULL AUTO_INCREMENT,
  `service_id` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `clinic_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `doctor` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `charges` decimal(10,2) DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `category` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci DEFAULT 'active',
  `multi_select` varchar(10) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'No',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (3,'','W1','Sunayan Eye Care','Alana Cotton',92.00,0,'Specialized','active','No'),(4,'','Adria Hartman','Sunayan Eye Care','Deacon Flowers',77.00,0,'Specialized','active','No'),(5,'','Ocean Fowler','Sunayan Eye Care','Robin Rivers',55.00,20,'Specialized','inactive','No'),(7,'','Wynter Boyd','Sunayan Eye Care','Alana Cotton',92.00,0,'Specialized','inactive','No'),(8,'','123W','Sunayan Eye Care','Alana Cotton',92.00,1,'Specialized','active','No'),(9,'','Angelica Pickett','Sunayan Eye Care','Idola Little',59.00,0,'Lipi','active','No');
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxes`
--

DROP TABLE IF EXISTS `taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taxes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `rate` decimal(5,2) NOT NULL,
  `doctor_id` int DEFAULT NULL,
  `service_category` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `taxes_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxes`
--

LOCK TABLES `taxes` WRITE;
/*!40000 ALTER TABLE `taxes` DISABLE KEYS */;
INSERT INTO `taxes` VALUES (3,'Azalia Buckner',98.00,11,'Specialized','active','2025-07-03 14:47:06'),(4,'Wayne Giles',84.00,7,'Lipi','active','2025-07-03 15:01:31');
/*!40000 ALTER TABLE `taxes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `designation` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `bio` text COLLATE utf8mb4_general_ci,
  `profile_image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','admin@clinic.com','Admin@1234','Admin User','+91 98765 43210','System Administrator','Primary system administrator with full access rights','images/admin-profile.jpg','2025-06-21 06:18:02'),(2,'doctor','doctor@clinic.com','doctor123','Dr. Sushil Patnaik','+91 90400 30636','Chief Ophthalmologist','Specialized in cataract surgery and refractive procedures','images/doctor-profile.jpg','2025-06-21 06:18:02'),(3,'reception','reception@clinic.com','reception123','Reception Staff','+91 87654 32109','Front Desk Receptionist','Handles patient appointments and front office operations','images/reception-profile.jpg','2025-06-21 06:18:02');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-06 11:58:54
