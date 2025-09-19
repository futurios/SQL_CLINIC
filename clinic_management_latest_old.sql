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
  `clinic_user_id` int NOT NULL,
  `doctor_id` int NOT NULL,
  `service_id` int NOT NULL,
  `patient_id` int NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_time` time NOT NULL,
  `status` enum('upcoming','completed','pending','checked_in','cancelled','booked') DEFAULT 'upcoming',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `clinic_user_id` (`clinic_user_id`),
  KEY `doctor_id` (`doctor_id`),
  KEY `service_id` (`service_id`),
  KEY `patient_id` (`patient_id`),
  CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`clinic_user_id`) REFERENCES `clinic_users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `clinic_doctors` (`doctor_id`) ON DELETE CASCADE,
  CONSTRAINT `appointments_ibfk_3` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`) ON DELETE CASCADE,
  CONSTRAINT `appointments_ibfk_4` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
INSERT INTO `appointments` VALUES (4,5,18,1,9,'2025-08-26','12:33:00','upcoming','2025-08-25 16:21:12','2025-09-07 08:45:09'),(5,5,19,1,9,'2025-08-26','01:15:00','pending','2025-08-25 16:45:36','2025-08-25 16:45:36'),(6,8,7,6,1,'2025-08-31','04:44:00','completed','2025-08-25 17:14:47','2025-08-25 17:45:50'),(8,8,7,6,1,'2025-08-27','01:13:00','booked','2025-08-25 17:44:00','2025-09-14 15:52:17'),(9,8,23,6,1,'2025-09-07','21:46:00','completed','2025-09-06 15:16:50','2025-09-07 08:04:12'),(10,9,26,17,16,'2025-09-15','00:18:00','upcoming','2025-09-14 17:48:04','2025-09-14 17:48:04');
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `billings`
--

DROP TABLE IF EXISTS `billings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `billings` (
  `bill_id` int NOT NULL AUTO_INCREMENT,
  `clinic_user_id` int NOT NULL,
  `encounter_id` int DEFAULT NULL,
  `doctor_id` int DEFAULT NULL,
  `patient_id` int DEFAULT NULL,
  `services_ids` json DEFAULT NULL,
  `total` decimal(10,2) NOT NULL DEFAULT '0.00',
  `discount` decimal(10,2) NOT NULL DEFAULT '0.00',
  `base_amount` decimal(10,2) DEFAULT '0.00',
  `tax_amount` decimal(10,2) DEFAULT '0.00',
  `amount_due` decimal(10,2) NOT NULL DEFAULT '0.00',
  `status` enum('paid','pending','cancelled') DEFAULT 'pending',
  `notes` text,
  `date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`bill_id`),
  KEY `fk_billing_clinic` (`clinic_user_id`),
  KEY `fk_billing_doctor` (`doctor_id`),
  KEY `fk_billing_patient` (`patient_id`),
  KEY `fk_billing_encounter` (`encounter_id`),
  CONSTRAINT `fk_billing_clinic` FOREIGN KEY (`clinic_user_id`) REFERENCES `clinic_users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_billing_doctor` FOREIGN KEY (`doctor_id`) REFERENCES `clinic_doctors` (`doctor_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_billing_encounter` FOREIGN KEY (`encounter_id`) REFERENCES `encounters` (`encounter_id`) ON DELETE SET NULL,
  CONSTRAINT `fk_billing_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billings`
--

LOCK TABLES `billings` WRITE;
/*!40000 ALTER TABLE `billings` DISABLE KEYS */;
INSERT INTO `billings` VALUES (7,5,12,18,9,'[\"1\"]',120600.00,800.00,120000.00,600.00,119800.00,'cancelled','Added','2025-09-07','2025-09-07 07:56:48','2025-09-07 07:57:31'),(8,8,9,7,1,'[\"5\"]',12200.00,2000.00,12000.00,200.00,10200.00,'paid','Added','2025-09-07','2025-09-07 08:56:49','2025-09-07 08:57:54');
/*!40000 ALTER TABLE `billings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinic_details`
--

DROP TABLE IF EXISTS `clinic_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinic_details` (
  `clinic_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `clinic_name` varchar(200) NOT NULL,
  `email` varchar(150) NOT NULL,
  `contact_no` varchar(50) NOT NULL,
  `currency_prefix` varchar(10) DEFAULT NULL,
  `specialities` text,
  `address` text,
  `profile_picture` varchar(255) DEFAULT 'assets/img/user.jpg',
  `dob` date DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`clinic_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `clinic_details_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `clinic_users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinic_details`
--

LOCK TABLES `clinic_details` WRITE;
/*!40000 ALTER TABLE `clinic_details` DISABLE KEYS */;
INSERT INTO `clinic_details` VALUES (1,5,'Demo Clinic1','demo1@gmail.com','9988776655','INR','Cardiology,Radiology','BBSR','uploads/1757178907_landing-hero.jpg','2001-02-18','male','2025-08-17 17:57:21','2025-09-07 05:44:28'),(2,8,'Demo Clinic','demo@gmail.com','9988776655','INR','Cardiology,Psychiatry','BBSR','uploads/1757178890_lord-hanuman-black-1920x1200-14679.png','2001-02-18','female','2025-08-17 18:11:35','2025-09-06 17:20:19'),(3,9,'Futurious Healthcare','futurious@clinic.com','8877997788','INR','Orthopedics,Dermatology,Cardiology,Psychiatry','Chandrasekharpur, BBSR, Odisha','uploads/profiles/1757238625_health-still-life-with-copy-space.jpg','1995-12-22','male','2025-09-07 09:50:25','2025-09-07 09:50:25');
/*!40000 ALTER TABLE `clinic_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinic_doctors`
--

DROP TABLE IF EXISTS `clinic_doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinic_doctors` (
  `doctor_id` int NOT NULL AUTO_INCREMENT,
  `clinic_user_id` int NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `licence` varchar(100) DEFAULT NULL,
  `contact_code` varchar(10) NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `whatsapp_number` varchar(20) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `specialization` varchar(150) NOT NULL,
  `experience` int DEFAULT '0',
  `gender` varchar(20) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `degree` varchar(150) NOT NULL,
  `university` varchar(150) NOT NULL,
  `year_of_passing` year NOT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `pin_code` varchar(20) DEFAULT NULL,
  `country` varchar(100) DEFAULT 'India',
  `description` text,
  `profile_image` varchar(255) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`doctor_id`),
  UNIQUE KEY `email` (`email`),
  KEY `fk_doctor_clinic` (`clinic_user_id`),
  CONSTRAINT `fk_doctor_clinic` FOREIGN KEY (`clinic_user_id`) REFERENCES `clinic_users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinic_doctors`
--

LOCK TABLES `clinic_doctors` WRITE;
/*!40000 ALTER TABLE `clinic_doctors` DISABLE KEYS */;
INSERT INTO `clinic_doctors` VALUES (7,8,'Sujit','Sahoo Doc','sahoosujit7452@gmail.com',NULL,'+91','09776822483',NULL,'2001-02-18','Gynecologist',3,'Male','active','MBBS','International College of Medical Science (UG)',2022,'Rasulgarh','BBSR','Odisha','773322','India','wqdlwjoid2odqww2','uploads/doctors/1755596080_doctor-thumb-09.jpg',NULL,'2025-08-19 06:04:40','2025-08-23 06:11:02'),(9,8,'Sujit','Sahoo','sahoosujit7455@gmail.com',NULL,'+91','09776822483',NULL,'2001-02-18','Gynecologist',2,'Male','active','MBBS','International College of Medical Science (UG)',2020,'Rasulgarh','BBSR','Odisha','773322','India','wediweyweiwe','uploads/doctors/1755596385_doctor-thumb-01.jpg',NULL,'2025-08-19 06:09:45','2025-08-21 14:39:38'),(15,8,'Monica','Sharma','monia@gmail.com',NULL,'+91','9988776655',NULL,'1999-03-25','Phsycatrist',2,'Female','active','MBBS','International College of Medical Science (UG)',2020,'Rasulgarh','BBSR','Odisha','773322','India','Description Added','uploads/doctors/1756020777_doctor-thumb-02.jpg',NULL,'2025-08-24 04:02:57','2025-08-24 04:02:57'),(16,8,'Sonia','Singh','sonia@gmail.com',NULL,'+91','9977665544',NULL,'2001-02-16','Cancer',2,'Female','inactive','MBBS','International College of Medical Science (UG)',2019,'Rasulgarh','BBSR','Odisha','773322','India','Added on','uploads/doctors/1756022407_doctor-thumb-10.jpg',NULL,'2025-08-24 04:21:17','2025-08-24 17:03:40'),(17,8,'Ilian','Curve','iliana@gmail.com',NULL,'+91','7766554433',NULL,'2000-12-22','None',9,'Other','inactive','MBBS','International College of Medical Science (UG)',2023,'Rasulgarh','BBSR','Odisha','773322','India','Addedeed','uploads/doctors/1756030984_doctor-thumb-08.jpg',NULL,'2025-08-24 06:53:04','2025-08-25 15:24:04'),(18,5,'Cristina','Groves','cristinagroves@example.com',NULL,'+91','08877665544',NULL,'2001-09-12','Cancer',4,'Female','active','MBBS','International College of Medical Science (UG)',2022,'Rasulgarh','BBSR','Odisha','773322','India','Added','uploads/doctors/1756046811_doctor-03.jpg',NULL,'2025-08-24 11:16:51','2025-08-25 14:33:54'),(19,5,'Suman','Saha','suman@gmail.com',NULL,'+91','7766443322',NULL,'2000-01-22','Cancer',2,'Male','active','MBBS','International College of Medical Science (UG)',2021,'Rasulgarh','BBSR','Odisha','773322','India','Added','uploads/doctors/1756134074_doctor-thumb-09.jpg',NULL,'2025-08-25 11:31:14','2025-08-25 11:31:14'),(20,8,'Demo','Doctor','demo@doctor.com',NULL,'+91','08877665544',NULL,'2012-12-12','Cancer',2,'Male','inactive','MBBS','International College of Medical Science (UG)',2022,'Rasulgarh','BBSR','Odisha','773322','India','eweuf2e','uploads/doctors/1756918013_file_3A4Z8_AR0I0717.jpg',NULL,'2025-09-03 13:16:53','2025-09-05 15:40:57'),(22,8,'Demo','Doctor','demo@doctors.com',NULL,'+91','09776822483',NULL,'2012-12-12','Cancer',2,'Male','active','MBBS','International College of Medical Science (UG)',2022,'Rasulgarh','BBSR','Odisha','773322','India','dwkfhqeufyu','uploads/doctors/1756918176_file_AEdku_AR0I0620.jpg',NULL,'2025-09-03 13:19:36','2025-09-03 13:19:36'),(23,8,'Demoo','Sahoo','demo@gmail.com','O-1006-2026','+91','09776822483','','2012-12-12','Phsycatrist',2,'Male','active','MBBS','International College of Medical Science',2022,'Rasulgarh','BBSR','Odisha','773322','India','jytfdteraerdfyu','uploads/doctors/1756918396_file_3A4Z8_AR0I0717.jpg','uploads/doctors/signatures/1757787916_images.png','2025-09-03 13:23:16','2025-09-13 18:25:16'),(24,8,'Mahesh','Kumar','mahesh@gmail.com','O-1006-2025','+91','07766554433','9988776655','2000-12-12','None',0,'Male','inactive','MBBS','International College of Medical Science',2023,'Jajpur','Jajpur','Odisha','755007','India','asdfghjk','uploads/doctors/1757517842_DR-PRAVEEN-DNB-GEN.-SURGERY-MNAMS-FMAS-General-Surgeon.jpg','uploads/signatures/1757517842_images.png','2025-09-10 11:54:02','2025-09-10 15:53:11'),(25,8,'Mukesh','Khan','mukesh@gmail.com','O-1006-2024','+91','09988776655','9988776655','2000-12-12','Phsycatrist',2,'Female','active','MBBS','International College of Medical Science',2020,'Rasulgarh','BBSR','Odisha','773322','India','weghjk','uploads/doctors/1757519691_newplot.png','uploads/signatures/1757519691_images.png','2025-09-10 12:24:51','2025-09-10 15:55:44'),(26,9,'Futurious','Dosctor','doctor@gmail.com','O-1006-1234','+91','09988776655','9988776655','2001-12-12','Gynecol',2,'Male','active','MBBS','International College of Medical Science',2022,'Rasulgarh','BBSR','Odisha','773322','India','qwertyukil;','uploads/doctors/1757870810_DR-PRAVEEN-DNB-GEN.-SURGERY-MNAMS-FMAS-General-Surgeon.jpg','uploads/signatures/1757870810_images.png','2025-09-14 13:56:50','2025-09-14 13:56:50');
/*!40000 ALTER TABLE `clinic_doctors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinic_employees`
--

DROP TABLE IF EXISTS `clinic_employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinic_employees` (
  `employee_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `doctor_id` int DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`employee_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`),
  KEY `clinic_user_id` (`user_id`),
  KEY `doctor_id` (`doctor_id`),
  CONSTRAINT `clinic_employees_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `clinic_users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `clinic_employees_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `clinic_doctors` (`doctor_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinic_employees`
--

LOCK TABLES `clinic_employees` WRITE;
/*!40000 ALTER TABLE `clinic_employees` DISABLE KEYS */;
INSERT INTO `clinic_employees` VALUES (1,8,15,NULL,NULL,NULL,NULL,'monicaDOc','$2y$10$F2WCRWmnfhJb9pj8awxT4.wmNpyOnkvBlXIgIbzqtsXnBLGztJ4km','doctor','active','2025-08-24 09:32:57','2025-08-24 09:32:57'),(2,8,16,NULL,NULL,NULL,NULL,'soniaMUS','$2y$10$zxAEKDT7MDrYRM3c71LdM.sEo1CQ99hJVwO7JbPUQ/8nswWkPlRXi','doctor','active','2025-08-24 09:51:17','2025-08-24 09:51:17'),(3,8,NULL,'Demo','Receptionist','receptionist@gmail.com','9988776655','redemo12','$2y$10$vBM14HgARCoQLiufaM8OKe4.RWXVDbVMDvdQkSKtmTzWxlKGxI.Ai','Receptionist','active','2025-08-24 15:05:45','2025-09-07 14:31:46'),(4,8,NULL,'New','Admin','admin@gmail2.com','9977886611','admin123','$2y$10$fPnedV9Bg9J5YIuWFVg2XOaQt4Qiuzr.fxOjeXItjKeN32L94Cl0q','Administrator','active','2025-08-24 15:20:50','2025-08-24 15:46:33'),(5,8,NULL,'Demo','Nurses','nurse@gmail.com','7766554435','nurse1234','$2y$10$00QI2L0q/q7T52OxozwsA.AwUdCPoVAvAHy7rTNCg0c/AJZ7BjrVi','Nurse','active','2025-08-24 15:23:49','2025-08-24 20:12:52'),(6,8,17,NULL,NULL,NULL,NULL,'iliana123','$2y$10$gjRNZJtBWS0M886Mw8CjSOVzBMQFsjpfqEImU2Kkl5I7k5YLtn98m','doctor','active','2025-08-24 12:23:04','2025-08-24 17:05:58'),(7,5,NULL,'New','Rec','rec@gmail.com','09988776655','rec123','$2y$10$punWKgefRI8SfnqobifN4.eYQ5B2pu3z5wBq04jfm72TTqxhjzueO','Receptionist','active','2025-08-24 20:14:13','2025-08-24 20:14:13'),(8,5,18,NULL,NULL,NULL,NULL,'Cristina12','$2y$10$7Ai.VE0IfSi32IZtQVnJMOs27hxdDLfZMTklcBqUKFUhGjqxoupa6','doctor','active','2025-08-24 16:46:51','2025-08-24 16:46:51'),(9,5,19,NULL,NULL,NULL,NULL,'Suman1234','$2y$10$mKOoqT8oM/kizso2PH5VYOaMJLM43C.rAPlx1p5UITVOjobG4Qlzy','doctor','active','2025-08-25 17:01:14','2025-08-25 17:01:14'),(11,5,NULL,'Testing','Testing','testing@gmail.com','08877665544','test12','$2y$10$HEpImhYHytty4iHb2DrmYOLcCpSic8Ekk8ZDByd/a7vWdaxRWwD2m','Administrator','active','2025-09-02 21:40:31','2025-09-07 14:03:01'),(12,8,NULL,'Test','Employee','test@gmail.com','09776822483','test2132','$2y$10$YWRQJ3Lv3Nx2vytpQwzFdel64.g1fmOc.DnGpceqmK1CML6tN6g6G','Nurse','active','2025-09-03 19:57:23','2025-09-03 19:57:23'),(13,8,NULL,'User','Testing','user@gmail.com','08877665544','user1212','$2y$10$tq5mrX0qItLB0IT0EEPAQeohCYr81.adHnClkkPcNELDnBou61lnG','Manager','active','2025-09-03 20:01:46','2025-09-03 20:01:46'),(14,8,22,NULL,NULL,NULL,NULL,'demo2121','$2y$10$RHdgFcF8Tip3.ne4WZje4ux6J.8fbNBdT..oNHBsmVtWESmojwlci','doctor','active','2025-09-03 18:49:36','2025-09-03 18:49:36'),(15,8,23,NULL,NULL,'demo@gmail.com',NULL,'user4321','$2y$10$l.hiNh.DNbdFSJVjc4xRY.cMr86Ux/rFSkz2AcuUAY9ttaZvOrnd.','doctor','active','2025-09-03 18:53:16','2025-09-07 14:01:28'),(16,8,24,NULL,NULL,'mahesh@gmail.com',NULL,'Mahesh123','$2y$10$t3MrbEF3SoUw/MDXfqg1leQZj.xxdyOPgJrZzWjyP3YgU3ArIcFMO','doctor','inactive','2025-09-10 17:24:02','2025-09-10 21:22:39'),(17,8,25,NULL,NULL,'mukesh@gmail.com',NULL,'Mukesh12','$2y$10$Ycc0QnM68gAwip1Pqft6w.VRN9ZKYsds0swLnE45V4Jxv5TBIOYeu','doctor','active','2025-09-10 17:54:51','2025-09-10 17:54:51'),(18,9,26,NULL,NULL,'doctor@gmail.com',NULL,'FuturiousD','$2y$10$NOLOr7BxGrEyPw/cwKZww./DKm8h/xX9uOmfJyGnDk9gfUF8GGE9u','doctor','active','2025-09-14 19:26:50','2025-09-14 19:26:50');
/*!40000 ALTER TABLE `clinic_employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clinic_users`
--

DROP TABLE IF EXISTS `clinic_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clinic_users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `full_name` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_type` enum('super_admin','admin','doctor','staff','patient','receptionist') NOT NULL DEFAULT 'patient',
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clinic_users`
--

LOCK TABLES `clinic_users` WRITE;
/*!40000 ALTER TABLE `clinic_users` DISABLE KEYS */;
INSERT INTO `clinic_users` VALUES (1,'Super Admin','admin@clinic.com','superadmin','Password@123','super_admin','active','2025-08-17 14:17:37','2025-09-04 17:23:32'),(5,'Demo Clinic1','admin.demo@cinic','democlinic12','$2y$10$ZjNr0Lp2nfZjyQgj/7e4JeKQr5rGnQfS8NhRAuLhfkMDFub69rr5e','admin','active','2025-08-17 17:57:21','2025-09-07 05:45:16'),(8,'Demo Clinic','admin.demo1@cinic','democlinic11','$2y$10$oGqT0rbJXOIVjmrKS1wKye6TWRj1EATafdc0jFcp.cHrvX/cg009u','admin','active','2025-08-17 18:11:35','2025-09-07 06:14:28'),(9,'Futurious Healthcare','admin@futurioushealthcare.com','futurious','$2y$10$mIwEvyJeooFzfEZwqW0tAe4AGhG7e8HIA2WRCvbFRyvs/HhmIpl2C','admin','active','2025-09-07 09:50:25','2025-09-07 09:51:16');
/*!40000 ALTER TABLE `clinic_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clinic_user_id` int NOT NULL,
  `department_name` varchar(100) NOT NULL,
  `description` text,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `clinic_user_id` (`clinic_user_id`),
  CONSTRAINT `departments_ibfk_1` FOREIGN KEY (`clinic_user_id`) REFERENCES `clinic_users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (1,8,'Dentists','Dentis Added','active','2025-08-21 18:08:43'),(3,5,'Neurology','gdtyuyg','active','2025-08-21 18:21:09'),(11,8,'Ortho','Added','active','2025-09-07 08:49:56');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor_schedules`
--

DROP TABLE IF EXISTS `doctor_schedules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctor_schedules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clinic_user_id` int NOT NULL,
  `doctor_id` int NOT NULL,
  `department_id` int DEFAULT NULL,
  `days` varchar(100) NOT NULL,
  `morning_start` time DEFAULT NULL,
  `morning_end` time DEFAULT NULL,
  `evening_start` time DEFAULT NULL,
  `evening_end` time DEFAULT NULL,
  `time_slot` int NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_schedule_doctor` (`doctor_id`),
  KEY `fk_schedule_clinic` (`clinic_user_id`),
  CONSTRAINT `fk_schedule_clinic` FOREIGN KEY (`clinic_user_id`) REFERENCES `clinic_users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_schedule_doctor` FOREIGN KEY (`doctor_id`) REFERENCES `clinic_doctors` (`doctor_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor_schedules`
--

LOCK TABLES `doctor_schedules` WRITE;
/*!40000 ALTER TABLE `doctor_schedules` DISABLE KEYS */;
INSERT INTO `doctor_schedules` VALUES (15,8,7,1,'Thu,Fri,Sat','01:38:00','02:38:00','08:38:00','09:38:00',10,'inactive','2025-09-02 15:08:22','2025-09-07 09:34:08'),(16,8,15,1,'Mon,Sun','23:42:00','00:42:00','07:42:00','08:42:00',15,'active','2025-09-02 15:13:05','2025-09-07 08:47:39'),(17,5,19,3,'Mon','01:44:00','04:44:00','13:44:00',NULL,5,'active','2025-09-02 15:14:15','2025-09-07 07:28:26'),(18,8,9,7,'Mon,Tue','22:44:00','23:44:00','01:44:00','02:44:00',5,'active','2025-09-02 15:14:54','2025-09-02 15:14:54'),(20,8,23,1,'Mon,Tue,Wed','14:34:00','15:34:00','18:34:00','19:34:00',5,'active','2025-09-07 08:04:49','2025-09-07 09:37:29'),(21,8,22,8,'Mon,Tue','14:17:00','15:17:00','21:18:00','23:18:00',15,'active','2025-09-07 08:48:21','2025-09-07 08:48:21');
/*!40000 ALTER TABLE `doctor_schedules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter_templates`
--

DROP TABLE IF EXISTS `encounter_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encounter_templates` (
  `template_id` int NOT NULL AUTO_INCREMENT,
  `clinic_user_id` int NOT NULL,
  `template_name` varchar(255) NOT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`template_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter_templates`
--

LOCK TABLES `encounter_templates` WRITE;
/*!40000 ALTER TABLE `encounter_templates` DISABLE KEYS */;
INSERT INTO `encounter_templates` VALUES (1,8,'Demo Template','Description Addedeedd','2025-08-23 07:31:15'),(7,5,'Demo Template Copy','Added','2025-09-07 07:48:31'),(8,8,'Template Latest','Added','2025-09-07 08:53:03');
/*!40000 ALTER TABLE `encounter_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounters`
--

DROP TABLE IF EXISTS `encounters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `encounters` (
  `encounter_id` int NOT NULL AUTO_INCREMENT,
  `clinic_user_id` int NOT NULL,
  `patient_id` int NOT NULL,
  `doctor_id` int NOT NULL,
  `appointment_id` int DEFAULT NULL,
  `encounter_date` date NOT NULL,
  `encounter_time` time DEFAULT NULL,
  `reason_for_visit` text,
  `diagnosis` text,
  `notes` text,
  `status` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`encounter_id`),
  KEY `fk_encounter_clinic` (`clinic_user_id`),
  KEY `fk_encounter_patient` (`patient_id`),
  KEY `fk_encounter_doctor` (`doctor_id`),
  KEY `fk_encounter_appointment` (`appointment_id`),
  CONSTRAINT `fk_encounter_appointment` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_encounter_clinic` FOREIGN KEY (`clinic_user_id`) REFERENCES `clinic_users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_encounter_doctor` FOREIGN KEY (`doctor_id`) REFERENCES `clinic_doctors` (`doctor_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_encounter_patient` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounters`
--

LOCK TABLES `encounters` WRITE;
/*!40000 ALTER TABLE `encounters` DISABLE KEYS */;
INSERT INTO `encounters` VALUES (9,8,1,7,NULL,'2025-08-26','16:14:00','uyuftyd','ut78t78t','trtytyfuy','completed','2025-08-23 06:42:49','2025-09-07 08:56:16'),(12,5,9,18,NULL,'2025-09-04','21:13:00','tyerershytrdiuytredfg','utytrdty','iu7ryerwt','completed','2025-09-03 14:44:22','2025-09-07 07:45:50');
/*!40000 ALTER TABLE `encounters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leave_types`
--

DROP TABLE IF EXISTS `leave_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leave_types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clinic_user_id` int NOT NULL,
  `leave_name` varchar(100) NOT NULL,
  `total_days` int NOT NULL DEFAULT '0',
  `description` text,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leave_types`
--

LOCK TABLES `leave_types` WRITE;
/*!40000 ALTER TABLE `leave_types` DISABLE KEYS */;
INSERT INTO `leave_types` VALUES (2,5,'Casual Leave',12,'Casual Leave for 12 days','active','2025-08-24 14:18:02','2025-08-24 14:18:02'),(3,5,'Sick Leave',6,'Sick Leave Added','active','2025-08-24 14:18:21','2025-08-24 14:18:21'),(5,8,'Casual Leaves',16,'Added','active','2025-08-25 17:52:56','2025-09-07 09:16:36'),(6,5,'Medical Leave',30,'gdrreartfu','active','2025-09-02 17:21:29','2025-09-02 17:21:29');
/*!40000 ALTER TABLE `leave_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `leaves`
--

DROP TABLE IF EXISTS `leaves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `leaves` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clinic_user_id` int NOT NULL,
  `employee_id` int NOT NULL,
  `leave_type_id` int NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  `no_of_days` int NOT NULL,
  `reason` text,
  `status` enum('New','Pending','Approved','Declined') DEFAULT 'New',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `leaves`
--

LOCK TABLES `leaves` WRITE;
/*!40000 ALTER TABLE `leaves` DISABLE KEYS */;
INSERT INTO `leaves` VALUES (1,5,7,2,'2025-08-24','2025-08-26',3,'Birthday Celebration','Approved','2025-09-07 09:08:50'),(2,5,8,4,'2025-08-24','2025-08-28',5,'Need Medical Leave','Approved','2025-08-24 16:36:23'),(6,5,8,3,'2025-08-25','2025-08-26',2,'Hde','Pending','2025-08-24 16:43:02'),(7,8,1,5,'2025-08-25','2025-08-27',3,'Marriage','Pending','2025-08-25 17:54:04'),(8,8,1,5,'2025-09-17','2025-09-19',3,'kduyfweuiufweo','Approved','2025-09-07 06:27:00');
/*!40000 ALTER TABLE `leaves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `modules` (
  `id` int NOT NULL AUTO_INCREMENT,
  `module_name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `description` text,
  `is_mandatory` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modules`
--

LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` VALUES (1,'Employees','employees','Manage clinic employees',1,'2025-08-22 16:32:40'),(2,'Appointments','appointments','Doctor and patient appointment scheduling',1,'2025-08-22 16:32:40'),(3,'Billing','billing','Clinic billing and invoices',1,'2025-08-22 16:32:40'),(4,'Departments','departments','Manage clinic departments and services',1,'2025-08-22 16:32:40'),(5,'Doctor Schedules','doctor_schedules','Setup doctor availability',1,'2025-08-22 16:32:40');
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patients`
--

DROP TABLE IF EXISTS `patients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `patients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clinic_user_id` int NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `dob` date NOT NULL,
  `blood_group` enum('A+','B+','AB+','O+','A-','B-','AB-','O-') DEFAULT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `sugar` enum('Yes','No') DEFAULT NULL,
  `bp` enum('Yes','No') DEFAULT NULL,
  `address` text,
  `city` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `whatsapp` varchar(20) DEFAULT NULL,
  `concern` varchar(255) DEFAULT NULL,
  `diseases` varchar(255) DEFAULT NULL,
  `medications` varchar(255) DEFAULT NULL,
  `referred` varchar(255) DEFAULT NULL,
  `insurance` enum('Yes','No') DEFAULT 'No',
  `ins_name` varchar(255) DEFAULT NULL,
  `ins_no` varchar(255) DEFAULT NULL,
  `ins_type` varchar(50) DEFAULT NULL,
  `height` varchar(10) DEFAULT NULL,
  `weight` varchar(10) DEFAULT NULL,
  `bmi` varchar(10) DEFAULT NULL,
  `communication_preference` enum('email','contact','whatsapp') DEFAULT NULL,
  `marketing` enum('Yes','No') DEFAULT 'No',
  `portal_access` enum('Yes','No') DEFAULT 'No',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_unique` (`email`),
  UNIQUE KEY `username` (`username`),
  KEY `fk_patients_clinic_users` (`clinic_user_id`),
  CONSTRAINT `fk_patients_clinic_users` FOREIGN KEY (`clinic_user_id`) REFERENCES `clinic_users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patients`
--

LOCK TABLES `patients` WRITE;
/*!40000 ALTER TABLE `patients` DISABLE KEYS */;
INSERT INTO `patients` VALUES (1,8,'Sujit','Sahoo','sahoosujit745@gmail.com','patient1','Password@123','09776822483','2001-02-18','O+','Male',NULL,NULL,'Rasulgarh','BBSR','India','773322','2025-08-19 10:55:36','2025-09-10 18:26:52','09776822483','Fever','','','','Yes','Demo Insurance','1234567890','Private','123','43','28.42','email','No','No'),(9,5,'DC','Patient','dc@gmail.com','dc1234','$2y$10$b5cwuI/g0BlpzXNSRhAXee8znfHjQfoXAGWaOqZp13Ys67b0llL6m','7788665533','2001-12-22','AB+','Male',NULL,NULL,'Rasulgarh','BBSR','India','773322','2025-08-25 15:42:29','2025-08-25 15:42:29',NULL,NULL,NULL,NULL,NULL,'No',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'No','No'),(10,8,'John','Doe','john@gmail.cpm','Johndoe12','$2y$10$0qWlZ1Aw7ckfIzrHett.UOHvNFLWpAac8hql.SLJwqVJvEndvuaLy','09776822483','2001-12-12','B+','Male','No','Yes','Rasulgarh','BBSR','India','755007','2025-09-09 17:48:42','2025-09-14 16:36:35','09776822483','Fever','No','No','None','Yes','Demo Insurance','1234567890','Government','123','67','44.29','whatsapp','Yes','Yes'),(11,9,'Patient','Name','patient@gmail.com','NewPatient','$2y$10$ZiqF6U9PGxNycZIoO/MI6OIm6B7TXxwvd6n6WkWlShvTs7FsuZjEm','08877665544','2000-12-12','O+','Female','Yes','No','Rasulgarh','BBSR','India','773322','2025-09-14 16:47:31','2025-09-14 16:47:31','9988776655','Fever','No','No','None','Yes','Demo Insurance','1234567890','Private','120','56','38.89','whatsapp','No','No'),(12,9,'Patient 2','Name','patient2@gmail.com','Patrient2','$2y$10$usRTpxs0khBB4HMtcWDOmOy2rdZ/gqgkEeTPXfnOS2KpTfnWh4hcy','09776822483','2001-12-18','A-','Male','Yes','Yes','Jajpur','Jajpur','India','755007','2025-09-14 16:52:53','2025-09-14 16:52:53','9988776655','Fever','No','No','None','No','','','','136','78','42.17','contact','No','Yes'),(13,9,'Patient3','Name','patient3@gmail.com','patient3','$2y$10$6Td84kiEWTPbed0eESuef.1q7bHtUC8A0Xt/uuJMDuwzWd5m2KHrO','09776822483','2001-12-12','O+','Male','No','No','Jajpur','Jajpur','India','755007','2025-09-14 17:31:12','2025-09-14 17:31:12','9988776655','Fever','No','No','None','No','','','','129','59','35.45','contact','No','No'),(15,9,'Patient4','Name','patient4@gmail.com','Patient4','$2y$10$DkqQs/TV84p1Ql5mKef8MOsOADS4C946ThDvXTsvJyy39xoREi.EW','09776822483','2001-12-12','B+','Male','No','No','Jajpur','Jajpur','India','755007','2025-09-14 17:38:47','2025-09-14 17:38:47','9988776655','Fever','No','No','None','No','','','','123','45','29.74','whatsapp','No','No'),(16,9,'Patient5','Name','patient5@gmail.com','Patient5','$2y$10$08lHhblUTBa8N4B4G8Vif.U/b55RH7gYb39cHP2estnZfJuTcWtS6','07766554433','2001-12-12','O+','Male','No','No','Jajpur','Jajpur','India','755007','2025-09-14 17:47:33','2025-09-14 17:47:33','9988776655','Fever','No','No','None','No','','','','120','56','38.89','email','No','No'),(17,9,'Patient6','Name','patient6@gmail.com','Patient6','$2y$10$oMlPcLw3iiNm9dU1XGJ1UercobuZWQsdGzY3neMxILHScgBgrxK1G','09776822483','2000-10-12','B-','Female','No','Yes','Rasulgarh','BBSR','India','755007','2025-09-14 17:49:55','2025-09-14 17:49:55','09776822483','Fever','No','No','None','No','','','','135','80','43.9','whatsapp','No','No');
/*!40000 ALTER TABLE `patients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescription_medicines`
--

DROP TABLE IF EXISTS `prescription_medicines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescription_medicines` (
  `id` int NOT NULL AUTO_INCREMENT,
  `prescription_id` int NOT NULL,
  `medicine_name` varchar(255) NOT NULL,
  `dosage` varchar(100) DEFAULT NULL,
  `duration` varchar(100) DEFAULT NULL,
  `instructions` text,
  PRIMARY KEY (`id`),
  KEY `prescription_id` (`prescription_id`),
  CONSTRAINT `prescription_medicines_ibfk_1` FOREIGN KEY (`prescription_id`) REFERENCES `prescriptions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescription_medicines`
--

LOCK TABLES `prescription_medicines` WRITE;
/*!40000 ALTER TABLE `prescription_medicines` DISABLE KEYS */;
INSERT INTO `prescription_medicines` VALUES (12,4,'Paracetamol','2','2','after food'),(13,4,'Dolo 650','2','2','after food'),(43,6,'Paracetamol','3','4','Take 2 times'),(44,6,'dolo','3','4','after food'),(45,6,'ins','1','2','after food'),(49,5,'Paracetamol','2','5','after food');
/*!40000 ALTER TABLE `prescription_medicines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescription_templates`
--

DROP TABLE IF EXISTS `prescription_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescription_templates` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clinic_user_id` int NOT NULL,
  `template_name` varchar(255) NOT NULL,
  `template_file` varchar(255) DEFAULT NULL,
  `header_color` varchar(20) DEFAULT NULL,
  `footer_color` varchar(20) DEFAULT NULL,
  `text_color` varchar(20) DEFAULT NULL,
  `heading_color` varchar(20) DEFAULT NULL,
  `title_color` varchar(20) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `background_image` varchar(255) DEFAULT NULL,
  `background_opacity` decimal(3,2) DEFAULT '1.00',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescription_templates`
--

LOCK TABLES `prescription_templates` WRITE;
/*!40000 ALTER TABLE `prescription_templates` DISABLE KEYS */;
INSERT INTO `prescription_templates` VALUES (3,8,'Demo','template_3.php','#00ffe5','#7a7a7a','#0080ff','#000000','#ff0000','1757700592_logo1.png','1757792394_images (1).png',0.10,'2025-09-12 18:08:36'),(4,9,'Futurious Template',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1.00,'2025-09-14 16:38:16');
/*!40000 ALTER TABLE `prescription_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescription_tests`
--

DROP TABLE IF EXISTS `prescription_tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescription_tests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `prescription_id` int NOT NULL,
  `test_name` varchar(255) NOT NULL,
  `test_notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prescription_id` (`prescription_id`),
  CONSTRAINT `prescription_tests_ibfk_1` FOREIGN KEY (`prescription_id`) REFERENCES `prescriptions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescription_tests`
--

LOCK TABLES `prescription_tests` WRITE;
/*!40000 ALTER TABLE `prescription_tests` DISABLE KEYS */;
INSERT INTO `prescription_tests` VALUES (11,4,'Blood Test','Immidiate test blood'),(32,6,'Blood Test','Make the text'),(33,6,'Urine Test','Make the text'),(37,5,'Blood Test','Immidiate test blood');
/*!40000 ALTER TABLE `prescription_tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prescriptions`
--

DROP TABLE IF EXISTS `prescriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prescriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clinic_user_id` int NOT NULL,
  `patient_id` int NOT NULL,
  `doctor_id` int NOT NULL,
  `template` varchar(50) DEFAULT NULL,
  `medicines` text,
  `tests` text,
  `advice` text,
  `next_visit` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `patient_id` (`patient_id`),
  KEY `doctor_id` (`doctor_id`),
  KEY `clinic_user_id` (`clinic_user_id`),
  CONSTRAINT `prescriptions_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`),
  CONSTRAINT `prescriptions_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `clinic_doctors` (`doctor_id`),
  CONSTRAINT `prescriptions_ibfk_3` FOREIGN KEY (`clinic_user_id`) REFERENCES `clinic_users` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prescriptions`
--

LOCK TABLES `prescriptions` WRITE;
/*!40000 ALTER TABLE `prescriptions` DISABLE KEYS */;
INSERT INTO `prescriptions` VALUES (4,8,10,9,'3',NULL,NULL,'Take the medicines properly and connect me after test complete','2025-09-15','2025-09-13 16:58:57',NULL),(5,8,1,25,'template-2',NULL,NULL,'SDRFG','2025-09-18','2025-09-13 17:54:41','2025-09-13 20:02:50'),(6,8,10,23,'3',NULL,NULL,'Addeeddwytfuiwopeiuydfghjkoploiuytrewrtyuirzxfcgshdjkvkldgbyevhijowp2eofbvh cddlwdugvyufhjewnlrfgyvhkel;obvoribv ','2025-09-20','2025-09-13 18:06:31','2025-09-13 19:28:13');
/*!40000 ALTER TABLE `prescriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_permissions`
--

DROP TABLE IF EXISTS `role_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role_id` int NOT NULL,
  `module_id` int NOT NULL,
  `can_read` tinyint(1) DEFAULT '0',
  `can_write` tinyint(1) DEFAULT '0',
  `can_create` tinyint(1) DEFAULT '0',
  `can_delete` tinyint(1) DEFAULT '0',
  `can_import` tinyint(1) DEFAULT '0',
  `can_export` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  KEY `module_id` (`module_id`),
  CONSTRAINT `role_permissions_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_permissions_ibfk_2` FOREIGN KEY (`module_id`) REFERENCES `modules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_permissions`
--

LOCK TABLES `role_permissions` WRITE;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `clinic_user_id` int NOT NULL,
  `role_name` varchar(100) NOT NULL,
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,5,'Administrator','active','2025-08-22 14:48:30'),(2,5,'Doctor','active','2025-08-22 14:55:11'),(3,5,'Patient','active','2025-08-22 14:55:21'),(5,5,'Receptionist','active','2025-08-22 15:04:12'),(6,8,'Administrator','active','2025-08-23 06:48:32'),(7,8,'Receptionist','active','2025-08-23 06:48:42'),(8,8,'Doctor','active','2025-08-23 06:48:50'),(10,8,'Nurse','active','2025-08-24 09:51:37'),(11,5,'Manager','active','2025-09-02 15:36:43'),(12,8,'Manager','active','2025-09-02 15:37:42');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_categories`
--

DROP TABLE IF EXISTS `service_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `clinic_user_id` int NOT NULL,
  `category_name` varchar(150) NOT NULL,
  `description` text,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`),
  KEY `clinic_user_id` (`clinic_user_id`),
  CONSTRAINT `service_categories_ibfk_1` FOREIGN KEY (`clinic_user_id`) REFERENCES `clinic_users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_categories`
--

LOCK TABLES `service_categories` WRITE;
/*!40000 ALTER TABLE `service_categories` DISABLE KEYS */;
INSERT INTO `service_categories` VALUES (1,5,'OPD','Specialised OPD service','active','2025-08-19 12:16:54','2025-08-19 12:16:54'),(2,5,'ICU','Ventilator and ICU Service','active','2025-08-19 12:17:32','2025-08-19 12:17:32'),(3,8,'OPD','OPD Services','inactive','2025-08-19 12:28:51','2025-09-07 07:20:28'),(4,8,'ICU','Bed with OPD','active','2025-08-21 15:07:26','2025-09-07 07:17:26'),(7,9,'General','Added','active','2025-09-14 17:27:24','2025-09-14 17:27:24');
/*!40000 ALTER TABLE `service_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `service_id` int NOT NULL AUTO_INCREMENT,
  `clinic_user_id` int NOT NULL,
  `category_id` int NOT NULL,
  `service_name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `duration` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT 'active',
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`service_id`),
  KEY `clinic_user_id` (`clinic_user_id`),
  KEY `fk_category` (`category_id`),
  CONSTRAINT `fk_category` FOREIGN KEY (`category_id`) REFERENCES `service_categories` (`category_id`) ON DELETE CASCADE,
  CONSTRAINT `services_ibfk_1` FOREIGN KEY (`clinic_user_id`) REFERENCES `clinic_users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `services_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `service_categories` (`category_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,5,2,'Ventilation',0.00,NULL,'active','Ventilator and ICU Service','2025-08-19 12:27:19'),(5,8,3,'Demo',10.00,'30','active','Demo addd','2025-08-19 12:52:12'),(6,8,3,'Demo1',30.00,'30','active','dkhefy','2025-08-19 12:54:48'),(17,9,7,'Bed',1000.00,'10000','active','Added','2025-09-14 17:27:50');
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxes`
--

DROP TABLE IF EXISTS `taxes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taxes` (
  `tax_id` int NOT NULL AUTO_INCREMENT,
  `clinic_user_id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `rate` decimal(5,2) NOT NULL,
  `doctor_id` int DEFAULT NULL,
  `service_id` int DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tax_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxes`
--

LOCK TABLES `taxes` WRITE;
/*!40000 ALTER TABLE `taxes` DISABLE KEYS */;
INSERT INTO `taxes` VALUES (1,5,'VAT',9.00,NULL,NULL,'active','2025-08-23 14:26:06'),(3,5,'CGST',9.00,NULL,NULL,'active','2025-08-23 14:41:08'),(4,8,'VAT',9.00,NULL,NULL,'active','2025-08-23 15:08:37'),(5,8,'CGST',9.00,NULL,NULL,'active','2025-08-23 16:29:41'),(7,8,'ewertyuiokjhg',21.00,NULL,NULL,'active','2025-09-06 10:25:55');
/*!40000 ALTER TABLE `taxes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-09-15 20:04:25
