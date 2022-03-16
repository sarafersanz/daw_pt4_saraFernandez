CREATE DATABASE  IF NOT EXISTS `tienda_libros` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish2_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `tienda_libros`;
-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: tienda_libros
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `autores`
--

DROP TABLE IF EXISTS `autores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `autores` (
  `id_autor` int NOT NULL AUTO_INCREMENT,
  `nombre_autor` varchar(45) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `apellidos_autor` varchar(45) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  PRIMARY KEY (`id_autor`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `autores`
--

LOCK TABLES `autores` WRITE;
/*!40000 ALTER TABLE `autores` DISABLE KEYS */;
INSERT INTO `autores` VALUES (1,'John Ronald Reuel','Tolkien'),(2,'Arturo ','Pérez-Reverte'),(3,'Julia',' Navarro'),(4,'Dan ','Brown'),(5,'Christian','Galvez'),(6,'Joanne Kathleen','Rowling ');
/*!40000 ALTER TABLE `autores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `editoriales`
--

DROP TABLE IF EXISTS `editoriales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `editoriales` (
  `id_editorial` int NOT NULL AUTO_INCREMENT,
  `nombre_editorial` varchar(45) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  PRIMARY KEY (`id_editorial`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `editoriales`
--

LOCK TABLES `editoriales` WRITE;
/*!40000 ALTER TABLE `editoriales` DISABLE KEYS */;
INSERT INTO `editoriales` VALUES (1,'George Allen & Unwin'),(2,'Santillana '),(3,'Plaza & Janes'),(4,'Salamandra'),(5,'Suma de letras');
/*!40000 ALTER TABLE `editoriales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `libros`
--

DROP TABLE IF EXISTS `libros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `libros` (
  `id_libro` int NOT NULL AUTO_INCREMENT,
  `titulo_libro` varchar(45) COLLATE utf8mb4_spanish2_ci DEFAULT NULL,
  `precio_libro` decimal(6,2) DEFAULT NULL,
  `id_autorFK` int NOT NULL,
  `id_editorialFK` int NOT NULL,
  PRIMARY KEY (`id_libro`),
  KEY `id_autorFK1_idx` (`id_autorFK`),
  KEY `id_editorialFK2_idx` (`id_editorialFK`),
  CONSTRAINT `id_autorFK2` FOREIGN KEY (`id_autorFK`) REFERENCES `autores` (`id_autor`),
  CONSTRAINT `id_editorialFK3` FOREIGN KEY (`id_editorialFK`) REFERENCES `editoriales` (`id_editorial`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `libros`
--

LOCK TABLES `libros` WRITE;
/*!40000 ALTER TABLE `libros` DISABLE KEYS */;
INSERT INTO `libros` VALUES (4,'El señor de los anillos',60.00,1,1),(5,'El capitán Alatriste',25.00,2,2),(6,'Dime quién soy',22.90,3,3),(7,'El principito',6.95,4,4),(8,'El retorno del Rey',60.00,1,3),(9,'Soy un canalla',22.95,3,3),(10,'Harry Potter (Colección)',75.50,6,4),(11,'Hanna',21.90,5,5),(12,'Sábana Santa',24.65,3,3);
/*!40000 ALTER TABLE `libros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id_pedido` int NOT NULL AUTO_INCREMENT,
  `total_pedido` decimal(6,2) DEFAULT NULL,
  `fecha_pedido` datetime DEFAULT NULL,
  `id_usuarioFK` int NOT NULL,
  `estado_pedido` tinyint DEFAULT '0',
  PRIMARY KEY (`id_pedido`),
  KEY `id_usuarioFK4_idx` (`id_usuarioFK`),
  CONSTRAINT `id_usuarioFK1` FOREIGN KEY (`id_usuarioFK`) REFERENCES `usuarios` (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (30,105.90,'2022-03-16 19:56:49',1,0),(31,112.30,'2022-03-16 19:57:06',1,1),(32,22.95,'2022-03-16 21:04:38',1,0),(33,6.95,'2022-03-16 21:05:19',1,0);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos_libros`
--

DROP TABLE IF EXISTS `pedidos_libros`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos_libros` (
  `id_pedido_libro` int NOT NULL AUTO_INCREMENT,
  `cantidad_pedido_libro` int DEFAULT NULL,
  `id_pedidoFK` int NOT NULL,
  `id_libroFK` int NOT NULL,
  PRIMARY KEY (`id_pedido_libro`),
  KEY `id_pedidosFK4_idx` (`id_pedidoFK`),
  KEY `id_libroFK5_idx` (`id_libroFK`),
  CONSTRAINT `id_libroFK5` FOREIGN KEY (`id_libroFK`) REFERENCES `libros` (`id_libro`),
  CONSTRAINT `id_pedidosFK4` FOREIGN KEY (`id_pedidoFK`) REFERENCES `pedidos` (`id_pedido`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos_libros`
--

LOCK TABLES `pedidos_libros` WRITE;
/*!40000 ALTER TABLE `pedidos_libros` DISABLE KEYS */;
INSERT INTO `pedidos_libros` VALUES (46,1,30,4),(47,2,30,9),(48,1,31,6),(49,1,31,10),(50,2,31,7),(51,1,32,9),(52,1,33,7);
/*!40000 ALTER TABLE `pedidos_libros` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id_usuario` int NOT NULL AUTO_INCREMENT,
  `nombre_usuario` varchar(45) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `clave_usuario` varchar(256) COLLATE utf8mb4_spanish2_ci NOT NULL,
  `tipo_usuario` tinyint DEFAULT NULL,
  PRIMARY KEY (`id_usuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish2_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'usuario1','122b738600a0f74f7c331c0ef59bc34c',0),(2,'usuario2','2fb6c8d2f3842a5ceaa9bf320e649ff0',1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-16 21:43:47
