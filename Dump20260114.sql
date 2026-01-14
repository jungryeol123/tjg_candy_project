-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: candy
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `advertise`
--

DROP TABLE IF EXISTS `advertise`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `advertise` (
  `adv_id` bigint NOT NULL AUTO_INCREMENT,
  `adv_detail_image` varchar(255) DEFAULT NULL,
  `adv_image_banner` varchar(255) DEFAULT NULL,
  `adv_image_inline` varchar(255) DEFAULT NULL,
  `adv_link` varchar(255) DEFAULT NULL,
  `adv_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`adv_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `advertise`
--

LOCK TABLES `advertise` WRITE;
/*!40000 ALTER TABLE `advertise` DISABLE KEYS */;
INSERT INTO `advertise` VALUES (1,NULL,NULL,'/images/advertiseimages/Adv4.png','https://www.oliveyoung.co.kr/store/main/main.do?oy=0','올리브영'),(2,NULL,NULL,'/images/advertiseimages/Adv5.png','https://www.musinsa.com/main/musinsa/recommend?gf=A','무신사'),(3,NULL,NULL,'/images/advertiseimages/Adv6.png','http://localhost:3000/coupon','쿠폰받기'),(4,NULL,'/images/advertiseimages/BannerAdv1.png',NULL,'https://www.oliveyoung.co.kr/store/main/main.do?oy=0','올리브영'),(5,NULL,'/images/advertiseimages/BannerAdv2.png',NULL,'https://www.oliveyoung.co.kr/store/main/main.do?oy=0','올리브영'),(6,NULL,'/images/advertiseimages/BannerAdv3.png',NULL,'https://www.coupang.com/np/search?component=&q=%EC%98%81%EC%96%91%EC%A0%9C&traceId=miiakjcm&channel=user','쿠팡');
/*!40000 ALTER TABLE `advertise` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `cid` bigint NOT NULL AUTO_INCREMENT,
  `added_at` datetime(6) NOT NULL,
  `qty` int NOT NULL,
  `ppk` bigint NOT NULL,
  `upk` bigint NOT NULL,
  PRIMARY KEY (`cid`),
  KEY `FKi5rep9miokyv1vywdoq4lepid` (`ppk`),
  KEY `FK1vacpri40ue82b7n3yxojpgnn` (`upk`),
  CONSTRAINT `FK1vacpri40ue82b7n3yxojpgnn` FOREIGN KEY (`upk`) REFERENCES `users` (`id`),
  CONSTRAINT `FKi5rep9miokyv1vywdoq4lepid` FOREIGN KEY (`ppk`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (37,'2025-11-26 10:09:48.501222',1,2,25);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_main`
--

DROP TABLE IF EXISTS `category_main`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_main` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `display_order` int DEFAULT NULL,
  `is_used` bit(1) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_main`
--

LOCK TABLES `category_main` WRITE;
/*!40000 ALTER TABLE `category_main` DISABLE KEYS */;
INSERT INTO `category_main` VALUES (1,1,_binary '','신선식품'),(2,2,_binary '','가공식품'),(3,3,_binary '','간편식/즉석식품'),(4,4,_binary '','음료/유제품'),(5,5,_binary '','과자/베이커리'),(6,6,_binary '','건강식품'),(7,7,_binary '','주류/전통주');
/*!40000 ALTER TABLE `category_main` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_sub`
--

DROP TABLE IF EXISTS `category_sub`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_sub` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `display_order` int DEFAULT NULL,
  `is_used` bit(1) NOT NULL,
  `name` varchar(50) NOT NULL,
  `main_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6tem59mqj94i5475b4gaxpdvs` (`main_id`),
  CONSTRAINT `FK6tem59mqj94i5475b4gaxpdvs` FOREIGN KEY (`main_id`) REFERENCES `category_main` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_sub`
--

LOCK TABLES `category_sub` WRITE;
/*!40000 ALTER TABLE `category_sub` DISABLE KEYS */;
INSERT INTO `category_sub` VALUES (1,1,_binary '','정육',1),(2,2,_binary '','수산물',1),(3,3,_binary '','과일',1),(4,4,_binary '','채소',1),(5,5,_binary '','계란',1),(6,1,_binary '','라면/면류',2),(7,2,_binary '','통조림/즉석조리',2),(8,3,_binary '','조미료/양념',2),(9,4,_binary '','소스/드레싱',2),(10,1,_binary '','냉동식품',3),(11,2,_binary '','도시락/볶음밥',3),(12,3,_binary '','국/탕/찌개',3),(13,4,_binary '','죽/스프',3),(14,1,_binary '','생수/탄산수',4),(15,2,_binary '','커피/차',4),(16,3,_binary '','주스/에이드',4),(17,4,_binary '','우유/요거트',4),(18,5,_binary '','치즈/버터',4),(19,1,_binary '','스낵/쿠키',5),(20,2,_binary '','초콜릿/젤리',5),(21,3,_binary '','빵/케이크',5),(22,4,_binary '','베이킹재료',5),(23,1,_binary '','견과류',6),(24,2,_binary '','건과일',6),(25,3,_binary '','홍삼/인삼',6),(26,4,_binary '','비타민/영양제',6),(27,1,_binary '','맥주',7),(28,2,_binary '','와인',7),(29,3,_binary '','소주/증류주',7),(30,4,_binary '','전통주',7);
/*!40000 ALTER TABLE `category_sub` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `coupon`
--

DROP TABLE IF EXISTS `coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `coupon` (
  `coupon_id` bigint NOT NULL,
  `coupon_dc_rate` int DEFAULT NULL,
  `coupon_qty` int DEFAULT NULL,
  PRIMARY KEY (`coupon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `coupon`
--

LOCK TABLES `coupon` WRITE;
/*!40000 ALTER TABLE `coupon` DISABLE KEYS */;
INSERT INTO `coupon` VALUES (1,30,1),(2,50,1),(3,60,1);
/*!40000 ALTER TABLE `coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery`
--

DROP TABLE IF EXISTS `delivery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery` (
  `del_type` int NOT NULL,
  `del_name` varchar(50) NOT NULL,
  `del_description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`del_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery`
--

LOCK TABLES `delivery` WRITE;
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;
INSERT INTO `delivery` VALUES (1,'샛별배송','23시 전 주문 시 수도권/충청 내일 아침 7시 전 도착\n그 외 지역 아침 8시 전 도착'),(2,'일반배송','주문일로부터 2~3일 내 도착');
/*!40000 ALTER TABLE `delivery` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notice`
--

DROP TABLE IF EXISTS `notice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notice` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `is_pinned` tinyint(1) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `writer` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notice`
--

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;
/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_detail`
--

DROP TABLE IF EXISTS `order_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `price` int NOT NULL,
  `product_id` bigint DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `qty` int NOT NULL,
  `order_id` bigint DEFAULT NULL,
  `ppk` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKrws2q0si6oyd6il8gqe2aennc` (`order_id`),
  KEY `FK7suagr7t2yj2olsgpkv7ml0ub` (`ppk`),
  CONSTRAINT `FK7suagr7t2yj2olsgpkv7ml0ub` FOREIGN KEY (`ppk`) REFERENCES `product` (`id`),
  CONSTRAINT `FKrws2q0si6oyd6il8gqe2aennc` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_detail`
--

LOCK TABLES `order_detail` WRITE;
/*!40000 ALTER TABLE `order_detail` DISABLE KEYS */;
INSERT INTO `order_detail` VALUES (9,2900,NULL,'감자칩 오리지널 110g',1,21,4),(10,5900,NULL,'베지밀 A 190ml x 10팩',1,22,12),(11,12800,NULL,'국산 삼겹살 500g',1,22,11),(12,2700,NULL,'서울우유 1L',1,23,9),(13,6900,NULL,'주꾸미 볶음 2종',1,23,1),(14,8900,NULL,'청송 사과 5입',1,24,8),(15,12800,NULL,'국산 삼겹살 500g',3,25,11),(16,15900,NULL,'한우 불고기 400g',1,26,2),(17,15900,NULL,'한우 불고기 400g',9,27,2),(18,12800,NULL,'국산 삼겹살 500g',3,28,11),(51,6900,NULL,'주꾸미 볶음 2종',1,50,1),(52,5200,NULL,'그릭요거트 플레인 400g',6,51,7),(53,6900,NULL,'고춧가루',2,52,35),(54,1950,NULL,'두부',3,53,34);
/*!40000 ALTER TABLE `order_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_date` varchar(30) DEFAULT NULL,
  `upk` bigint NOT NULL,
  `address1` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `discount_amount` int DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `odate` datetime(6) DEFAULT NULL,
  `order_code` varchar(50) NOT NULL,
  `receiver_name` varchar(255) DEFAULT NULL,
  `receiver_phone` varchar(255) DEFAULT NULL,
  `shipping_fee` int DEFAULT NULL,
  `tid` varchar(50) DEFAULT NULL,
  `total_amount` int NOT NULL,
  `zipcode` varchar(255) DEFAULT NULL,
  `delivered_at` datetime(6) DEFAULT NULL,
  `delivery_status` enum('DELIVERED','READY','SHIPPING') DEFAULT NULL,
  `eta` datetime(6) DEFAULT NULL,
  `shipping_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,'2025-07-15 12:10:00',3,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL),(2,'2025-07-15 12:20:00',1,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL),(3,'2025-07-15 13:00:00',4,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL),(4,'2025-07-15 13:20:00',2,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL),(5,'2025-07-15 13:30:00',5,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL),(6,'2025-07-16 11:00:00',1,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL),(7,'2025-07-16 11:10:00',4,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL),(8,'2025-07-16 11:30:00',2,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL),(9,'2025-07-17 09:00:00',3,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL),(10,'2025-07-17 09:10:00',5,NULL,NULL,NULL,NULL,NULL,'',NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL),(21,NULL,25,'전북특별자치도 김제시 공덕면 강변로 398 (저산리) 4층 202호','',290,'문앞에 놔주세요','2025-11-20 15:29:18.435908','23df4347-be79-4b3a-93a4-d436106c47b2','김테스트','010-5555-5555',0,'T91eb519315e2b03f914',2610,'08825',NULL,NULL,NULL,NULL),(22,NULL,25,'전북특별자치도 김제시 공덕면 강변로 398 (저산리) 4층 202호','',1319,'문앞에 놔주세요','2025-11-21 17:15:00.644802','5c4a2ac3-f38c-4d30-9c26-f5899faa0d82','김테스트','010-5555-5555',0,'T9201f6a315e2b03ffd9',17381,'08825',NULL,NULL,NULL,NULL),(23,NULL,25,'전북특별자치도 김제시 공덕면 강변로 398 (저산리) 4층 202호','',960,'문앞에 놔주세요','2025-11-21 17:21:25.279414','668775c9-c2ec-42b6-9cb3-5069dce84a3c','김테스트','010-5555-5555',0,'T92020f0315e2b03ffde',8640,'08825',NULL,NULL,NULL,NULL),(24,NULL,25,'경북 상주시 경상대로 2891 (낙양동)','601호',1780,'문자남겨주세요','2025-11-24 12:27:31.757139','bdddfb3a-a7e5-4fc4-b3aa-09f769943b15','최수정','010-5555-5555',0,'T923d08d315e2b03052c',7120,'37202',NULL,NULL,NULL,NULL),(25,NULL,25,'경북 상주시 경상대로 2891 (낙양동)','8층 202호',3072,'경비실에 맡겨주세요','2025-11-24 14:33:17.499709','daaf1f81-80ae-4df0-bfee-a651c1e21d2a','최예시','010-4564-1231',0,'T923ee0377920788d709',35328,'37202',NULL,NULL,NULL,NULL),(26,NULL,25,'전북특별자치도 김제시 공덕면 강변로 398 (저산리) 4층 202호','',2385,'문앞에 놔주세요','2025-11-24 17:49:13.739661','9e80d1ea-57c9-4b4f-a084-712cf4a089fc','김테스트','010-5555-5555',0,'T9241bee315e2b03075a',13515,'08825',NULL,NULL,NULL,NULL),(27,NULL,25,'전북특별자치도 김제시 공덕면 강변로 398 (저산리) 4층 202호','',21465,'문앞에 놔주세요','2025-11-26 10:08:01.055149','d9f1700e-3ee1-4bea-b52e-0bca06a23bb4','김테스트','010-5555-5555',0,'T92652c804f905c238ac',121635,'08825',NULL,'READY',NULL,NULL),(28,NULL,25,'전북특별자치도 김제시 공덕면 강변로 398 (저산리) 4층 202호','',3072,'문앞에 놔주세요','2025-11-26 10:59:50.728032','e9f5e90b-637d-4e92-af72-f687487330e9','김테스트','010-5555-5555',0,'T9265ef9299c193d7acc',35328,'08825',NULL,'READY',NULL,NULL),(50,NULL,25,'경기 남양주시 진접읍 경복대로17번안길 53 (연평리)','5층 206호',690,'문앞에 놔주세요','2025-12-12 15:25:50.763104','4f6b4a72-af6c-44d6-ace7-f58973c0785d','박삭제','010-4564-5645',3000,'T93bb559455906477680',9210,'12067',NULL,'READY',NULL,NULL),(51,NULL,25,'전북특별자치도 김제시 공덕면 강변로 398 (저산리) 4층 202호','',780,'문앞에 놔주세요','2025-12-17 12:42:07.903463','beb2da28-fb6b-4d5f-91fd-73c87af31e56','최테스트','010-4564-5645',3000,'T942266f7ecc536563aa',17820,'08825',NULL,'READY',NULL,NULL),(52,NULL,25,'전북특별자치도 김제시 공덕면 강변로 398 (저산리) 4층 202호','',0,'문앞에 놔주세요','2025-12-24 10:32:22.257826','54df3727-db0b-43ed-8ec5-c6d08e7f46f0','최테스트','010-4564-5645',3000,'T94b4289429e53ffc807',16800,'08825',NULL,'READY',NULL,NULL),(53,NULL,25,'전북특별자치도 김제시 공덕면 강변로 398 (저산리) 4층 202호','',876,'문앞에 놔주세요','2025-12-24 11:16:39.800347','91d8b0ff-789c-4310-bfef-c3ced2b666fc','최테스트','010-4564-5645',3000,'N1d2eb03e80954c45a8',7974,'08825',NULL,'READY',NULL,NULL);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `brand_name` varchar(100) DEFAULT NULL,
  `dc` int NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `image_url_name` varchar(100) DEFAULT NULL,
  `is_hot_deal` bit(1) NOT NULL,
  `is_member_special` bit(1) NOT NULL,
  `origin` varchar(100) DEFAULT NULL,
  `pid` varchar(20) NOT NULL,
  `price` int NOT NULL,
  `product_date` datetime(6) DEFAULT NULL,
  `product_description_image` varchar(255) DEFAULT NULL,
  `product_information_image` varchar(255) DEFAULT NULL,
  `product_name` varchar(200) DEFAULT NULL,
  `count` int NOT NULL,
  `del_type` int NOT NULL,
  `allergy_info` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `seller` varchar(255) DEFAULT NULL,
  `unit` varchar(255) DEFAULT NULL,
  `weight` varchar(255) DEFAULT NULL,
  `upk` bigint NOT NULL,
  `category_sub_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK2gbc34tdkhthcb08clqyebd9s` (`pid`),
  KEY `fk_product_del_type` (`del_type`),
  KEY `FK4a88lyft7u61iher2m18r8hqx` (`upk`),
  KEY `FK3tqdw6fsg0k99ouxxeftuwmr1` (`category_sub_id`),
  CONSTRAINT `FK3tqdw6fsg0k99ouxxeftuwmr1` FOREIGN KEY (`category_sub_id`) REFERENCES `category_sub` (`id`),
  CONSTRAINT `FK4a88lyft7u61iher2m18r8hqx` FOREIGN KEY (`upk`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_product_del_type` FOREIGN KEY (`del_type`) REFERENCES `delivery` (`del_type`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'압구정주꾸미',10,'마늘의 감칠맛이 듬뿍 담긴 주꾸미 볶음','productImage1.png','치아바타',_binary '',_binary '','국산','P0001',6900,'2025-06-25 00:00:00.000000','productDescriptionImageP0001.png','productInformationImageP0001.png','주꾸미 볶음 2종',2,1,NULL,NULL,NULL,NULL,NULL,25,10),(2,'한남정육점',15,'신선한 한우를 바로 포장한 불고기','productImage2.png','불고기',_binary '\0',_binary '','국산','P0002',15900,'2025-07-01 00:00:00.000000','productDescriptionImageP0002.png','productInformationImageP0002.png','한우 불고기 400g',0,1,NULL,NULL,NULL,NULL,NULL,25,1),(3,'FarmFresh',5,'100% 국산 딸기로 만든 수제 잼','productImage3.png','딸기잼',_binary '',_binary '\0','국산','P0003',4900,'2025-07-10 00:00:00.000000','productDescriptionImageP0003.png','productInformationImageP0003.png','수제 딸기잼 200g',10,1,NULL,NULL,NULL,NULL,NULL,25,9),(4,'Snacky',10,'바삭하고 짭짤한 오리지널 감자칩','productImage4.png','감자칩',_binary '\0',_binary '\0','국산','P0004',2900,'2025-06-15 00:00:00.000000','productDescriptionImageP0004.png','productInformationImageP0004.png','감자칩 오리지널 110g',4,1,NULL,NULL,NULL,NULL,NULL,25,19),(5,'오뚜기',10,'언제나 간편하게 즐기는 카레','productImage5.png','카레',_binary '\0',_binary '','국산','P0005',1800,'2025-06-05 00:00:00.000000','productDescriptionImageP0005.png','productInformationImageP0005.png','3분 카레 중간맛',10,1,NULL,NULL,NULL,NULL,NULL,25,13),(6,'다이어트랩',10,'저염, 고단백 훈제 닭가슴살','productImage6.png','닭가슴살',_binary '',_binary '\0','국산','P0006',3900,'2025-07-03 00:00:00.000000','productDescriptionImageP0006.png','productInformationImageP0006.png','훈제 닭가슴살 200g',10,1,NULL,NULL,NULL,NULL,NULL,25,10),(7,'그릭하우스',5,'진한 풍미의 수제 그릭요거트','productImage7.png','요거트',_binary '\0',_binary '','국산','P0007',5200,'2025-07-02 00:00:00.000000','productDescriptionImageP0007.png','productInformationImageP0007.png','그릭요거트 플레인 400g',0,1,NULL,NULL,NULL,NULL,NULL,25,17),(8,'청송농원',20,'청송에서 직배송되는 달콤한 사과','productImage8.png','사과',_binary '',_binary '\0','국산','P0008',8900,'2025-07-08 00:00:00.000000','productDescriptionImageP0008.png','productInformationImageP0008.png','청송 사과 5입',6,1,NULL,NULL,NULL,NULL,NULL,25,3),(9,'서울우유',10,'매일 신선하게 유통되는 우유','productImage9.png','우유',_binary '\0',_binary '','국산','P0009',2700,'2025-06-20 00:00:00.000000','productDescriptionImageP0009.png','productInformationImageP0009.png','서울우유 1L',2,1,NULL,NULL,NULL,NULL,NULL,25,17),(10,'신라면',0,'얼큰하고 깊은 국물 맛','productImage10.png','라면',_binary '',_binary '\0','국산','P0010',4500,'2025-07-11 00:00:00.000000','productDescriptionImageP0010.png','productInformationImageP0010.png','신라면 5입',10,1,NULL,NULL,NULL,NULL,NULL,25,6),(11,'미트스토리',8,'신선한 생삼겹살을 당일 포장','productImage11.png','삼겹살',_binary '',_binary '','국산','P0011',12800,'2025-07-13 00:00:00.000000','productDescriptionImageP0011.png','productInformationImageP0011.png','국산 삼겹살 500g',10,1,NULL,NULL,NULL,NULL,NULL,25,1),(12,'베지밀',5,'영양 가득한 진한 콩맛 두유','productImage12.png','두유',_binary '\0',_binary '\0','국산','P0012',5900,'2025-06-29 00:00:00.000000','productDescriptionImageP0012.png','productInformationImageP0012.png','베지밀 A 190ml x 10팩',8,1,NULL,NULL,NULL,NULL,NULL,25,17),(13,'백설',0,'깔끔한 요리에 적합한 카놀라유','productImage13.png','요리유',_binary '\0',_binary '\0','수입','P0013',4900,'2025-07-05 00:00:00.000000','productDescriptionImageP0013.png','productInformationImageP0013.png','백설 카놀라유 900ml',10,1,NULL,NULL,NULL,NULL,NULL,25,8),(14,'파리바게뜨',5,'담백하고 부드러운 통밀 식빵','productImage14.png','식빵',_binary '\0',_binary '','국산','P0014',3500,'2025-07-09 00:00:00.000000','productDescriptionImageP0014.png','productInformationImageP0014.png','통밀 식빵 1개입',10,1,NULL,NULL,NULL,NULL,NULL,25,21),(15,'종가집',12,'국산 배추로 담근 전통 김치','productImage15.png','김치',_binary '',_binary '','국산','P0015',9800,'2025-07-14 00:00:00.000000','productDescriptionImageP0015.png','productInformationImageP0015.png','포기김치 1kg',5,1,NULL,NULL,NULL,NULL,NULL,25,4),(16,'청란농장',5,'신선한 무항생제 계란 15구','productImage16.png','계란',_binary '',_binary '\0','국산','P0016',6800,'2025-07-16 00:00:00.000000','productDescriptionImageP0016.png','productInformationImageP0016.png','무항생제 계란 15입',10,1,NULL,NULL,NULL,NULL,NULL,25,5),(17,'맥심',10,'부드럽고 달콤한 모카골드 커피믹스','productImage17.png','커피',_binary '\0',_binary '','수입','P0017',7900,'2025-07-15 00:00:00.000000','productDescriptionImageP0017.png','productInformationImageP0017.png','맥심 모카골드 20입',10,1,NULL,NULL,NULL,NULL,NULL,25,15),(18,'그린밸리',0,'세척 완료된 신선 샐러드','productImage18.png','샐러드',_binary '\0',_binary '\0','국산','P0018',3900,'2025-07-17 00:00:00.000000','productDescriptionImageP0018.png','productInformationImageP0018.png','프레시 샐러드 250g',10,1,NULL,NULL,NULL,NULL,NULL,25,4),(19,'삼다수',0,'제주 지하암반수로 만든 깨끗한 생수','productImage19.png','생수',_binary '\0',_binary '','국산','P0019',5100,'2025-07-18 00:00:00.000000','productDescriptionImageP0019.png','productInformationImageP0019.png','제주 삼다수 2L x 6입',10,1,NULL,NULL,NULL,NULL,NULL,25,14),(20,'빙그레',10,'부드럽고 진한 바닐라 아이스크림','productImage20.png','아이스크림',_binary '',_binary '\0','국산','P0020',6900,'2025-07-19 00:00:00.000000','productDescriptionImageP0020.png','productInformationImageP0020.png','투게더 바닐라 900ml',10,1,NULL,NULL,NULL,NULL,NULL,25,4),(33,'IAMGROUND',50,'깐대파 500g','bigfa.png','bigfa.png',_binary '',_binary '\0','국내산','P0021',4490,'2025-12-19 00:00:00.000000','bigfa.png','bigfa.png','대파',100,1,'파의 매운맛 조심','식품 특성상 중량 3% 내외의 차이가 발생할 수 있습니다.\n시세에 따라 가격이 변동 될 수 있습니다.\n대파는 시기적 특성으로 인해 뿌리 부분이 누렇게 될 수 있습니다.','최재영','500g','500g',25,4),(34,'맑은물에',15,'두루 활용하는 대용량 두부','dubu.png','dubu.png',_binary '',_binary '\0','외국산(미국,캐나다,중국)','P0022',1950,'2025-12-19 00:00:00.000000','dubu.png','dubu.png','두부',17,2,'대두 함유','뭉개짐 주의','맑은물에','1모 550g','550g',25,7),(35,'햇님마을',0,'요리마다 꼭 맞는 작은 고춧가루','gochugaru.png','gochugaru.png',_binary '\0',_binary '\0','국산','P0023',6900,'2025-12-19 00:00:00.000000','gochugaru.png','gochugaru.png','고춧가루',18,2,'작은 고추의 매운맛을 보여주마','개봉후 자연적으로 수분을 흡수하여 습기에 취약합니다. 반드시 밀봉하여 냉장보관 하시거나 가급적 빠르게 섭취 부탁드립니다.(여름철 주의)','햇님마을','1통','120g',25,8);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_qna`
--

DROP TABLE IF EXISTS `product_qna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_qna` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` datetime(6) DEFAULT NULL,
  `is_private` bit(1) NOT NULL,
  `ppk` bigint NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `upk` bigint NOT NULL,
  `content` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_qna`
--

LOCK TABLES `product_qna` WRITE;
/*!40000 ALTER TABLE `product_qna` DISABLE KEYS */;
INSERT INTO `product_qna` VALUES (1,'2025-09-26 00:00:00.000000',_binary '',1,'답변완료','비밀글입니다.',3,NULL),(2,'2025-09-10 00:00:00.000000',_binary '',2,'답변완료','비밀글입니다.',1,NULL),(3,'2025-08-13 00:00:00.000000',_binary '\0',3,'답변완료','돼지고기 함량 몇프로인가요?',5,NULL),(4,'2025-08-04 00:00:00.000000',_binary '\0',4,'답변완료','에어프라이어 없으면?',2,NULL),(5,'2025-08-04 00:00:00.000000',_binary '\0',5,'답변완료','에어프라이어 없으면?',4,NULL),(6,'2025-08-04 00:00:00.000000',_binary '\0',6,'답변완료','에어프라이어 없으면?',1,NULL),(7,'2025-08-04 00:00:00.000000',_binary '\0',7,'답변완료','에어프라이어 없으면?',5,NULL),(8,'2025-08-04 00:00:00.000000',_binary '\0',8,'답변완료','에어프라이어 없으면?',2,NULL),(9,'2025-08-04 00:00:00.000000',_binary '\0',9,'안녕','에어프라이어 없으면?',4,NULL);
/*!40000 ALTER TABLE `product_qna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe`
--

DROP TABLE IF EXISTS `recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` text,
  `cook_time` int DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `difficulty` varchar(50) DEFAULT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `ingredients` longtext,
  `rating` double DEFAULT '0',
  `review_count` int DEFAULT '0',
  `steps` longtext,
  `summary` varchar(500) DEFAULT NULL,
  `tips` varchar(500) DEFAULT NULL,
  `title` varchar(150) NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `youtube_url` varchar(500) DEFAULT NULL,
  `sub_category_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKon2xvw5of2nmyqaf8v5w1k72d` (`sub_category_id`),
  CONSTRAINT `FKon2xvw5of2nmyqaf8v5w1k72d` FOREIGN KEY (`sub_category_id`) REFERENCES `category_sub` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe`
--

LOCK TABLES `recipe` WRITE;
/*!40000 ALTER TABLE `recipe` DISABLE KEYS */;
INSERT INTO `recipe` VALUES (1,NULL,40,'2025-11-21 10:15:51.000000','보통','kimchi_stew.jpg','[\"돼지고기 앞다리살 200g\", \"김치 1컵\", \"대파 1대\", \"두부 1/2모\", \"고춧가루 1.5스푼\", \"고추장 1스푼\", \"마늘 1스푼\"]',4.8,65,'[\"냄비에 돼지고기와 마늘을 넣고 중불에서 볶아 고기의 풍미를 낸다.\", \"고기가 반쯤 익으면 신김치를 넣고 2~3분 더 볶는다.\", \"물 또는 육수를 붓고 끓기 시작하면 중불로 줄여 15분 정도 끓인다.\", \"두부와 대파를 넣고 5분 더 끓인 후 간을 맞추어 완성한다.\"]','돼지고기와 신김치로 깊고 매운맛을 낸 김치찌개입니다.','청양고추를 추가하면 더 칼칼한 맛을 낼 수 있습니다.','매콤한 돼지고기 김치찌개',NULL,'https://www.youtube.com/watch?v=NnHpI1VUjhM',1),(2,NULL,35,'2025-11-21 10:15:51.000000','쉬움','beef_miyeok.jpg','[\"불린 미역 1컵\", \"소고기 국거리 150g\", \"참기름 1스푼\", \"국간장 1.5스푼\", \"마늘 1스푼\"]',4.6,87,'[\"참기름에 소고기를 볶아 고기의 육향을 충분히 낸다.\", \"불린 미역을 넣고 함께 2분 정도 볶아 풍미를 올린다.\", \"물을 붓고 중불에서 20분간 끓인다.\", \"국간장으로 간을 하고 5분 더 끓여 완성한다.\"]','담백하고 깊은 맛의 소고기 미역국입니다.','미역은 너무 오래 볶으면 질겨질 수 있으니 주의하세요.','부드러운 소고기 미역국',NULL,'https://www.youtube.com/watch?v=uF6PwkSMDa0',1),(3,NULL,10,'2025-11-21 10:15:51.000000','쉬움','tomato_egg.jpg','[\"토마토 2개\", \"계란 3개\", \"대파 1대\", \"간장 1스푼\", \"설탕 1티스푼\"]',4.9,30,'[\"계란을 소금 약간 넣고 풀어 스크램블 형태로 부드럽게 익힌 후 따로 빼둔다.\", \"토마토와 대파를 볶아 자연스럽게 나온 수분으로 소스를 만든다.\", \"간장과 설탕으로 간을 맞춘다.\", \"스크램블한 계란을 다시 넣고 가볍게 섞어 완성한다.\"]','촉촉하고 부드러운 중국식 토마토 계란볶음입니다.','토마토 껍질을 제거하면 더 부드러운 식감을 즐길 수 있습니다.','토마토 계란볶음',NULL,'https://www.youtube.com/watch?v=erV4lLerKiU&pp=0gcJCQwKAYcqIYzv',4),(4,NULL,20,'2025-11-21 10:15:51.000000','쉬움','tteokbokki.jpg','[\"떡볶이 떡 200g\", \"어묵 2장\", \"대파 1대\", \"고추장 2스푼\", \"고춧가루 1스푞\", \"간장 1스푤\", \"설탕 1스푤\"]',4.7,122,'[\"팬에 물을 넣고 고추장, 고춧가루, 설탕, 간장으로 양념장을 만든다.\", \"떡과 어묵을 넣고 중불에서 10분간 졸인다.\", \"대파를 넣고 3분 더 끓인 후 걸쭉해지면 완성한다.\"]','분식집 스타일의 매콤달콤 떡볶이입니다.','치즈를 올리면 더욱 고소한 풍미를 즐길 수 있습니다.','매콤 떡볶이',NULL,'https://www.youtube.com/watch?v=Y8OFkrLW-ak',7),(5,NULL,25,'2025-11-21 10:15:51.000000','보통','seafood_pajeon.jpg','[\"부침가루 1컵\", \"물 1컵\", \"오징어 50g\", \"새우 50g\", \"대파 2대\", \"식용유 넉넉히\"]',4.8,54,'[\"반죽을 만들어 팬 전체에 얇게 펼친다.\", \"오징어와 새우, 대파를 위에 풍성하게 올린다.\", \"기름을 넉넉히 두르고 약불~중불에서 천천히 익힌다.\", \"가장자리가 노릇해지면 뒤집어 바삭하게 완성한다.\"]','겉은 바삭하고 속은 촉촉한 해물파전입니다.','약불에서 천천히 구울수록 더 바삭해집니다.','해물 파전',NULL,'https://www.youtube.com/watch?v=wM4k0J03s1Y',22);
/*!40000 ALTER TABLE `recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipe_review`
--

DROP TABLE IF EXISTS `recipe_review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe_review` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` text,
  `created_at` datetime(6) DEFAULT NULL,
  `rating` double NOT NULL,
  `recipe_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKky1nx8d7m557dpa96gi3ftv5n` (`recipe_id`),
  KEY `FKgvv15ffc22axtjognae8076hq` (`user_id`),
  CONSTRAINT `FKgvv15ffc22axtjognae8076hq` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKky1nx8d7m557dpa96gi3ftv5n` FOREIGN KEY (`recipe_id`) REFERENCES `recipe` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipe_review`
--

LOCK TABLES `recipe_review` WRITE;
/*!40000 ALTER TABLE `recipe_review` DISABLE KEYS */;
INSERT INTO `recipe_review` VALUES (4,'고기가 진짜 부드럽고 양념이 딱 맞아요. 밥 두 공기 뚝딱했습니다!','2025-01-05 14:20:11.000000',5,1,25),(5,'맛있는데 저는 고춧가루를 좀 더 넣었어요. 칼칼하니 끝내줍니다.','2025-01-12 09:55:42.000000',4.5,1,25),(6,'레시피대로 하니까 실패할 수가 없네요! 신김치만 맛있으면 끝!','2025-02-01 18:10:33.000000',4.8,1,25),(7,'담백하고 깊은 맛이 나요. 속 편한 한 끼로 최고입니다.','2025-01-20 12:41:02.000000',4.6,2,25),(8,'엄마가 해준 것 같은 맛… 미역국은 이 레시피가 국룰입니다.','2025-02-16 10:22:14.000000',4.9,2,25),(9,'빠르게 만들기 좋아요. 토마토랑 계란 조합은 진짜 미쳤습니다.','2025-01-28 21:10:44.000000',5,3,25),(10,'저는 설탕 조금 덜 넣었는데 더 담백해서 좋더라구요!','2025-02-10 13:55:17.000000',4.7,3,25),(11,'진짜 분식집 맛! 떡도 쫄깃하고 양념도 딱 맞아서 너무 좋았어요.','2025-01-18 17:25:30.000000',4.9,4,25),(12,'치즈 추가하니까 고소함이 배가됩니다. 강력추천!','2025-02-05 08:15:22.000000',4.5,4,25),(13,'파전이 겉바속촉으로 완성됩니다. 바삭함 미쳤어요.','2025-01-25 15:12:08.000000',4.8,5,25),(19,'영상보니 배고프네요','2025-11-21 10:21:49.823611',4,1,25),(20,'너무 맛있어보이는 레시피입니다.','2025-12-17 11:16:05.859874',4,1,25);
/*!40000 ALTER TABLE `recipe_review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refresh_tokens`
--

DROP TABLE IF EXISTS `refresh_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refresh_tokens` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `expiry_date` datetime(6) NOT NULL,
  `token` varchar(64) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKghpmfn23vmxfu3spu3lfg4r2d` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=1172 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refresh_tokens`
--

LOCK TABLES `refresh_tokens` WRITE;
/*!40000 ALTER TABLE `refresh_tokens` DISABLE KEYS */;
INSERT INTO `refresh_tokens` VALUES (41,'2025-11-18 08:47:02.178931','461b752f8568843940535992333cabd3ec09b474ac19dc9862caf1df69f67b80',19),(209,'2025-12-08 04:06:02.361979','2589b7015ab6073b42af27db75c4bf4934a47c839e6de131f04a103289e6962e',37),(210,'2025-12-08 04:06:07.971961','360e94d4338f47463a18db221a69359ac1bae5100022ea762d7786fb2ba66412',36),(211,'2025-12-08 04:06:20.972700','bb757b9d3191a4b4b7a9224c9670588256141f1e18916d11f1a87804f66b00dc',37),(1036,'2025-12-25 09:18:10.036557','4a6e1a0cecefa9fd8717da75cc5bd49e45a103ec3ddfb912ce820b5b2a88162e',25),(1060,'2025-12-26 09:19:41.471275','542eb7001627ac711ed0c9f5ed8dac7e2a91d892c4739fd95b66e85914340c60',25),(1082,'2025-12-31 01:44:29.605080','c1504b8827c06f9e1765221982306f2b0dfce4b2194eb1fc82c64ac747c7800d',25),(1169,'2025-12-31 06:34:06.398867','e44bf899ed03f885a4de9bd121443477e860a1f6402d23fe33dd4465f2a08624',25),(1171,'2026-01-19 02:03:24.147130','da4cd0ab757ca149a341062be7f3802ff196fae0a960703c1b02d7951e7faabe',25);
/*!40000 ALTER TABLE `refresh_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` text,
  `date` varchar(20) DEFAULT NULL,
  `images` json DEFAULT NULL,
  `is_best` bit(1) NOT NULL,
  `likes` int NOT NULL,
  `ppk` bigint NOT NULL,
  `product_name` varchar(200) DEFAULT NULL,
  `tags` json DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `upk` bigint NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES (1,'맵지도 않고 딱 적당히 감칠맛이 돌아요. 밥 비벼 먹기 딱입니다.','2025.07.18','[\"/images/reviewImages/review1.png\", \"/images/reviewImages/review2.png\"]',_binary '',17,1,'주꾸미 볶음 2종','[\"매콤달콤\", \"밥도둑\", \"추천\"]','양념이 정말 맛있어요!',3),(2,'불고기 양념이 너무 세지 않아서 아이들이랑 같이 먹기 좋았습니다.','2025.07.01','[\"/images/reviewImages/review3.png\"]',_binary '\0',9,2,'한우 불고기 400g','[\"불고기\", \"아이반찬\", \"부드러움\"]','한우라 그런지 고소하고 부드러워요',1),(3,'토스트에 발라 먹으니 향이 진하고 맛있어요. 재구매 의사 있습니다!','2025.07.10','[\"/images/reviewImages/review4.png\"]',_binary '',14,3,'수제 딸기잼 200g','[\"잼추천\", \"수제맛\", \"달지않음\"]','딸기향이 진하고 너무 달지 않아요',4),(4,'한 봉지 금방 다 먹어요. 간도 딱 맞고 식감이 좋아요!','2025.07.02','[\"/images/reviewImages/review5.png\"]',_binary '\0',8,4,'감자칩 오리지널 110g','[\"바삭바삭\", \"간식\", \"짭조름\"]','바삭하고 짭조름해서 멈출 수 없어요',2),(5,'전자레인지에 돌리면 금방 완성! 맛도 괜찮고 출근 전 아침으로 좋아요.','2025.07.03','[\"/images/reviewImages/review6.png\"]',_binary '',21,5,'3분 카레 중간맛','[\"간편조리\", \"즉석식품\", \"아침추천\"]','간편하게 먹을 수 있어서 좋아요',5),(6,'짠맛도 덜하고 단백질 보충용으로 좋아요. 부드럽고 잡내 없어요.','2025.07.05','[\"/images/reviewImages/review7.png\"]',_binary '\0',13,6,'훈제 닭가슴살 200g','[\"헬스식단\", \"단백질\", \"담백함\"]','운동식단용으로 딱입니다',1),(7,'시중 요거트보다 훨씬 진하고 맛있어요. 꿀이랑 먹으면 최고!','2025.07.06','[\"/images/reviewImages/review8.png\"]',_binary '',15,7,'그릭요거트 플레인 400g','[\"요거트\", \"건강식\", \"꾸덕꾸덕\"]','진하고 꾸덕한 요거트예요',4),(8,'사과 상태가 너무 좋아요. 아삭하고 신선해서 만족!','2025.07.08','[\"/images/reviewImages/review9.png\"]',_binary '',12,8,'청송 사과 5입','[\"과일\", \"신선함\", \"아삭아삭\"]','달콤하고 아삭해요',3),(9,'유통기한도 넉넉하고 신선해요. 커피에 타먹어도 좋습니다.','2025.07.09','[\"/images/reviewImages/review10.png\"]',_binary '\0',10,9,'서울우유 1L','[\"우유\", \"신선함\", \"모닝루틴\"]','매일 아침에 마시기 좋아요',2),(10,'매콤한 맛이 딱 좋아요. 역시 라면은 신라면이죠!','2025.07.11','[\"/images/reviewImages/review11.png\"]',_binary '',25,10,'신라면 5입','[\"라면\", \"매운맛\", \"국민간식\"]','언제 먹어도 맛있는 국민라면',5),(11,'기름도 적당하고 냄새도 없어요. 고기질이 정말 좋네요.','2025.07.13','[\"/images/reviewImages/review12.png\"]',_binary '',22,11,'국산 삼겹살 500g','[\"삼겹살\", \"신선도좋음\", \"재구매\"]','육즙 가득 신선해요',3),(12,'아이 간식용으로 사는데 고소하고 영양도 좋아요.','2025.07.14','[\"/images/reviewImages/review13.png\"]',_binary '\0',7,12,'베지밀 A 190ml x 10팩','[\"두유\", \"영양간식\", \"고소함\"]','진한 콩맛이 좋아요',2),(13,'냄새도 안나고 기름도 맑아요. 여러 번 사용해도 괜찮네요.','2025.07.15','[\"/images/reviewImages/review14.png\"]',_binary '\0',6,13,'백설 카놀라유 900ml','[\"식용유\", \"튀김용\", \"깔끔한맛\"]','튀김용으로 깔끔해요',4),(14,'잼이랑 같이 먹으니 아침 식사로 좋아요. 식감도 부드러워요.','2025.07.09','[\"/images/reviewImages/review15.png\"]',_binary '\0',8,14,'통밀 식빵 1개입','[\"식빵\", \"아침식사\", \"담백함\"]','담백하고 부드럽습니다',1),(15,'짜지 않고 깔끔해요. 냉장고에 두면 점점 더 맛있어집니다.','2025.07.14','[\"/images/reviewImages/review16.png\"]',_binary '',19,15,'포기김치 1kg','[\"김치\", \"전통맛\", \"밥반찬\"]','적당히 익어서 맛있어요',5),(16,'계란 상태가 모두 좋아요. 반숙으로 먹으니 정말 맛있습니다.','2025.07.16','[\"/images/reviewImages/review17.png\"]',_binary '\0',11,16,'무항생제 계란 15입','[\"계란\", \"신선함\", \"반숙추천\"]','껍질도 깨끗하고 신선해요',2),(17,'하루 한 잔씩 마시는데 향이 은은하고 달지 않아요.','2025.07.15','[\"/images/reviewImages/review18.png\"]',_binary '\0',10,17,'맥심 모카골드 20입','[\"커피\", \"부드러운맛\", \"아침루틴\"]','부드럽고 향이 좋아요',3),(18,'세척이 잘 되어 있고 바로 먹을 수 있어서 편리합니다.','2025.07.17','[\"/images/reviewImages/review19.png\"]',_binary '\0',9,18,'프레시 샐러드 250g','[\"샐러드\", \"건강식\", \"신선\"]','신선하고 깨끗해요',4),(19,'삼다수는 역시 믿고 마셔요. 시원하게 냉장고에 두고 매일 마십니다.','2025.07.18','[\"/images/reviewImages/review20.png\"]',_binary '\0',7,19,'제주 삼다수 2L x 6입','[\"생수\", \"깔끔한맛\", \"추천\"]','물맛이 부드럽고 깔끔해요',2),(20,'가족 모두 좋아해요. 바닐라향이 진하고 크리미합니다.','2025.07.19','[\"/images/reviewImages/review21.png\"]',_binary '',23,20,'투게더 바닐라 900ml','[\"아이스크림\", \"바닐라\", \"디저트\"]','부드럽고 진한 바닐라 맛!',5);
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_coupon`
--

DROP TABLE IF EXISTS `user_coupon`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_coupon` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `qty` int DEFAULT NULL,
  `coupon_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `is_used` bit(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKb7ji6tcp2d4mh0ylxvdyrv5f3` (`user_id`,`coupon_id`),
  KEY `FK23vpkw483hhbe77dgvimcipf4` (`coupon_id`),
  CONSTRAINT `FK23vpkw483hhbe77dgvimcipf4` FOREIGN KEY (`coupon_id`) REFERENCES `coupon` (`coupon_id`),
  CONSTRAINT `FKgqnogpxxp29atogg1d2fv9q0o` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_coupon`
--

LOCK TABLES `user_coupon` WRITE;
/*!40000 ALTER TABLE `user_coupon` DISABLE KEYS */;
INSERT INTO `user_coupon` VALUES (9,1,2,25,_binary ''),(10,1,3,25,_binary ''),(15,1,1,25,_binary '\0');
/*!40000 ALTER TABLE `user_coupon` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_view_log`
--

DROP TABLE IF EXISTS `user_view_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_view_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `ppk` bigint DEFAULT NULL,
  `qty` int DEFAULT NULL,
  `sub_category_id` bigint DEFAULT NULL,
  `upk` bigint DEFAULT NULL,
  `viewed_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_view_log`
--

LOCK TABLES `user_view_log` WRITE;
/*!40000 ALTER TABLE `user_view_log` DISABLE KEYS */;
INSERT INTO `user_view_log` VALUES (1,12,15,17,25,'2025-12-19 11:10:00.433933'),(2,4,25,19,25,'2025-12-18 15:13:40.094048'),(3,8,13,3,25,'2025-12-18 11:47:17.565908'),(4,1,37,10,25,'2025-12-19 11:45:00.478744'),(5,5,9,13,25,'2025-12-18 11:47:27.024400'),(6,9,3,17,33,'2025-12-18 14:03:31.841517'),(7,2,14,1,25,'2025-12-18 12:07:07.675334'),(8,11,23,1,25,'2025-12-18 12:08:19.661134'),(9,16,4,5,25,'2025-11-27 15:29:55.128599'),(10,9,30,17,25,'2025-12-18 16:41:30.798090'),(11,15,9,4,25,'2025-12-19 17:58:09.311647'),(12,18,9,4,25,'2025-12-12 15:37:37.872194'),(13,7,17,17,25,'2025-12-18 16:41:44.609085'),(14,7,1,17,33,'2025-11-28 11:31:33.384324'),(15,32,1,29,25,'2025-12-01 14:11:30.962991'),(16,1,2,10,38,'2025-12-01 15:41:01.059446'),(17,6,2,10,38,'2025-12-01 15:41:31.682070'),(18,15,2,4,38,'2025-12-01 15:47:26.425568'),(19,7,1,17,40,'2025-12-05 11:20:25.298490'),(20,20,3,4,25,'2025-12-18 11:47:34.199618'),(21,6,2,10,25,'2025-12-18 17:54:51.900972'),(22,17,1,15,25,'2025-12-18 13:58:19.818770'),(23,13,1,8,25,'2025-12-18 13:58:36.525104'),(24,1,1,10,44,'2025-12-18 14:58:11.854149'),(25,3,2,9,25,'2025-12-18 15:12:33.293315'),(26,33,1,4,25,'2025-12-19 13:57:29.497676'),(27,33,1,4,25,'2025-12-19 13:57:29.497676'),(28,34,1,7,25,'2025-12-19 14:12:22.002752'),(29,34,1,7,25,'2025-12-19 14:12:22.002752'),(30,35,1,8,25,'2025-12-22 10:33:41.931922'),(31,35,1,8,25,'2025-12-22 10:33:41.931922');
/*!40000 ALTER TABLE `user_view_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `birthday` varchar(20) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `provider` varchar(20) DEFAULT NULL,
  `recommendation` varchar(100) DEFAULT NULL,
  `user_id` varchar(50) NOT NULL,
  `zonecode` varchar(5) DEFAULT NULL,
  `role` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`),
  UNIQUE KEY `UK6efs5vmce86ymf5q7lmvn2uuf` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'서울특별시 강남구 테헤란로 10','1990-05-12','hong.gildong@example.com','M','홍길동','$2b$12$OQB7iJVt438Wck89wdEqNuDmDovV2V22CK.hVBFRPcsglPtKG50za','010-1234-5678','local',NULL,'hongg','08825','USER'),(2,'부산광역시 해운대구 우동 100','1985-10-02','lee.soon@example.com','F','이순자','$2b$12$exR6Sntm3shfqyZcj61VXOs.dmZeRWn5lc/.12WDfzP9Svlc.e6Nm','010-2345-6789','kakao','friend_abc','lees','08825','USER'),(3,'대구광역시 달서구 성당동 5','1995-01-22','kim.min@example.com','M','김민수','$2b$12$TwiSyKu614X2DrA52svUne1k7y6lwaNz0QuP4x5QZveBhRnPOear6','010-3456-7890','naver',NULL,'kmin','08825','USER'),(4,'인천광역시 연수구 송도동 20','2000-07-15','park.ji@example.com','F','박지연','$2b$12$yMefJyxXIipVKvqw.K7Bj.0j66NaE/B32O2TKtLumhRns2sAyIOj2','010-4567-8901','local','campaign_x','parkj','08825','USER'),(5,'광주광역시 북구 용봉동 9','1992-03-03','choi.ha@example.com','F','최하늘','$2b$12$wIj87IW3RSIg8Ljz62KvIeT0qAxShJpaZfBiREIAP6HH3BemkTizS','010-5678-9012','local',NULL,'choih','08825','USER'),(25,'전북특별자치도 김제시 공덕면 강변로 398 (저산리) 4층 202호','1999-11-11','test@hotmail.com','M','최테스트','$2a$10$jx0QdHiPMr.jMip1WIbE9uvFVb.gtxQrieuJeEFBpVk..DmBLjYqO','010-4564-5645','local','','test','08825','ADMIN'),(33,'제주특별자치도 서귀포시 가가로 15 (상예동) 8층 207호','1991-11-11','gogo@gogo.com','M','고고','$2a$10$XMbFRqO67MFiD3uPgfZVSuwfYSAhV6w.nhY0lVlBN47g5xHGKjJLm','010-5555-7777','local','','gogo','63534','USER'),(34,'서울 영등포구 가마산로 312 (대림동, 신동아아파트) 609호','1999-11-11','choitest@hanmail.net','M','최테스트','$2a$10$nxwSlQlXmzhJooY0obKPk.rYIgefZFhBHIk5ZRqdypWgrS9r1af/6','010-7894-5789','local','','test2','07411','USER'),(35,'제주특별자치도 서귀포시 가가로 15 (상예동) 403호','1999-11-11','choite@daum.net','M','최테스트','$2a$10$TryMNG6ebybQFKPHnFVcB.L4O27/7KF2FiZtaJgm1nVFWIOBB4LT.','010-1111-3333','local','','test5','63534','USER'),(36,'경북 상주시 경상대로 2891 (낙양동) 403호','1999-11-11','testgo@kakao.com','M','이테스트고','$2a$10$g.Gt7gVnuZjH/Nn4qEYiNumfCW00pcPGLK6JZN3p0ExrA0Yp0GcHy','010-1111-3333','local','','testgo','37202','USER'),(37,'제주특별자치도 서귀포시 가가로 25 (상예동) 91','1991-91-91','test91@kakao.com','M','테스트91','$2a$10$hyYpVec7N7uou9Yyt2i.Ruw7ZjSCkfykACUVy/cWI46p8E2.cTBRW','010-9191-9191','local','','test91','63534','USER'),(38,'강원특별자치도 삼척시 가곡면 가곡천로 149-6 (동활리) 92','1992-11-11','test92@hanmail.net','M','테스트92','$2a$10$9dc02PiiiacpdKPUi.xXBuqtDaErWoqG4AYA20rCwDVwXoxKQXVnS','010-9299-8756','local','','test92','25953','USER'),(39,'충북 충주시 여수월1길 1-1 (교현동) 21','1991-21-21','test21@hanmail.net','M','테스트21','$2a$10$MBE98gL9fyCGJC1Uq5lyBuweOZDPozL5cTmD2F0kq6QE3l8bBstMe','010-9191-9121','local','','test21','27373','USER'),(40,'서울 관악구 신림동 501-25 9층 109호','1999-05-30','test55@hanmail.net','M','테스트55','$2a$10$146kev/Se3D69PmBXB0zoOEgN1xL5exIbZQS3BwnHG983eno3Dlr6','010-5555-9999','local','','test55','08705','USER'),(41,'경기 의정부시 무림길 173-20 (낙양동) 1234','1111-11-11','test06@gmail.com','M','테스트06','$2a$10$lekB/w7hBSTPw2XvftT2vOV7BLoEWCDUTuZhVRPEoxiO5HcdByrLK','010-9687-5648','local','','test06','11816','USER'),(42,'경기 의정부시 무림길 173-20 (낙양동) 11234','1999-11-11','test998@gmail.com','M','테스트998','$2a$10$rDViVdpIcDTFEJp1WYleluHwQbVNBqHX2KfrW5El09Hal13kIl0gC','010-8765-4567','local','','test998','11816','USER'),(43,'강원특별자치도 인제군 기린면 곰배령길 20 (진동리) 123124','1991-11-11','ttest999@gmail.com','M','1234','$2a$10$qrn/mjh/VdjYzJ1eQDTIeOHkXPe4sMbIELx8t0a3NHselIepwysXe','010-9999-9999','local','','test999','24653','USER'),(44,'충남 당진시 고대면 고대로 596 (당진포리) 고고','1991-11-11','gogogo@kakao.com','M','고고고','$2a$10$hYst/EOyL5Q9bOKdkVRauOwuODBm61B453XX6MvF5delByrkeUpNW','010-9998-8855','local','','gogogo','31790','USER');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `view_product_detail`
--

DROP TABLE IF EXISTS `view_product_detail`;
/*!50001 DROP VIEW IF EXISTS `view_product_detail`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `view_product_detail` AS SELECT 
 1 AS `id`,
 1 AS `brand_name`,
 1 AS `dc`,
 1 AS `description`,
 1 AS `image_url`,
 1 AS `image_url_name`,
 1 AS `is_hot_deal`,
 1 AS `is_member_special`,
 1 AS `origin`,
 1 AS `pid`,
 1 AS `price`,
 1 AS `product_date`,
 1 AS `product_description_image`,
 1 AS `product_information_image`,
 1 AS `product_name`,
 1 AS `count`,
 1 AS `del_type`,
 1 AS `allergy_info`,
 1 AS `notes`,
 1 AS `seller`,
 1 AS `unit`,
 1 AS `weight`,
 1 AS `upk`,
 1 AS `category_sub_id`,
 1 AS `del_name`,
 1 AS `del_description`,
 1 AS `category_main_id`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `view_product_detail`
--

/*!50001 DROP VIEW IF EXISTS `view_product_detail`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_product_detail` AS select `p`.`id` AS `id`,`p`.`brand_name` AS `brand_name`,`p`.`dc` AS `dc`,`p`.`description` AS `description`,`p`.`image_url` AS `image_url`,`p`.`image_url_name` AS `image_url_name`,`p`.`is_hot_deal` AS `is_hot_deal`,`p`.`is_member_special` AS `is_member_special`,`p`.`origin` AS `origin`,`p`.`pid` AS `pid`,`p`.`price` AS `price`,`p`.`product_date` AS `product_date`,`p`.`product_description_image` AS `product_description_image`,`p`.`product_information_image` AS `product_information_image`,`p`.`product_name` AS `product_name`,`p`.`count` AS `count`,`p`.`del_type` AS `del_type`,`p`.`allergy_info` AS `allergy_info`,`p`.`notes` AS `notes`,`p`.`seller` AS `seller`,`p`.`unit` AS `unit`,`p`.`weight` AS `weight`,`p`.`upk` AS `upk`,`p`.`category_sub_id` AS `category_sub_id`,`d`.`del_name` AS `del_name`,`d`.`del_description` AS `del_description`,`cm`.`id` AS `category_main_id` from (((`product` `p` join `delivery` `d`) join `category_main` `cm`) join `category_sub` `cs`) where ((`p`.`del_type` = `d`.`del_type`) and (`cm`.`id` = `cs`.`main_id`) and (`cs`.`id` = `p`.`category_sub_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-14 12:29:22
