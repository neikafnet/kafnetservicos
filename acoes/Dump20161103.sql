-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: kafnetservicos
-- ------------------------------------------------------
-- Server version	5.7.12-log

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
-- Table structure for table `contas`
--

DROP TABLE IF EXISTS `contas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contas` (
  `conta_id` int(11) NOT NULL AUTO_INCREMENT,
  `conta_nome` varchar(255) NOT NULL,
  `conta_razaosocial` varchar(255) NOT NULL,
  `conta_nomefantasia` varchar(255) NOT NULL,
  `conta_cnpj` varchar(255) NOT NULL,
  `conta_endereco` varchar(255) NOT NULL,
  `conta_bairro` varchar(255) NOT NULL,
  `conta_cidade` varchar(255) NOT NULL,
  `conta_estado` varchar(255) NOT NULL,
  `conta_cep` varchar(255) NOT NULL,
  `conta_emailprincipal` varchar(255) NOT NULL,
  `conta_emailsecundario` varchar(255) DEFAULT NULL,
  `conta_telefoneprincipal` varchar(255) NOT NULL,
  `conta_telefonesecundario` varchar(255) DEFAULT NULL,
  `conta_datacriado` datetime NOT NULL,
  `conta_datamodificado` datetime DEFAULT NULL,
  `conta_criadopor` int(11) NOT NULL,
  `conta_modificadopor` int(11) DEFAULT NULL,
  `conta_ativo` tinyint(1) NOT NULL,
  PRIMARY KEY (`conta_id`),
  KEY `fk_conta_criado` (`conta_criadopor`),
  KEY `fk_conta_modificado` (`conta_modificadopor`),
  CONSTRAINT `fk_conta_criado` FOREIGN KEY (`conta_criadopor`) REFERENCES `usuarios` (`usua_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_conta_modificado` FOREIGN KEY (`conta_modificadopor`) REFERENCES `usuarios` (`usua_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contas`
--

LOCK TABLES `contas` WRITE;
/*!40000 ALTER TABLE `contas` DISABLE KEYS */;
/*!40000 ALTER TABLE `contas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contatos`
--

DROP TABLE IF EXISTS `contatos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contatos` (
  `contato_id` int(11) NOT NULL AUTO_INCREMENT,
  `contato_nome` varchar(255) NOT NULL,
  `contato_cpf` varchar(45) NOT NULL,
  `contato_datanascimento` date NOT NULL,
  `contato_endereco` varchar(255) NOT NULL,
  `contato_bairro` varchar(255) NOT NULL,
  `contato_cidade` varchar(255) NOT NULL,
  `contato_estado` varchar(255) NOT NULL,
  `contato_cep` varchar(255) NOT NULL,
  `contato_emailpessoal` varchar(255) DEFAULT NULL,
  `contato_emailcorporativo` varchar(255) NOT NULL,
  `contato_telefoneresidencial` varchar(255) DEFAULT NULL,
  `contato_telefonecelular` varchar(255) NOT NULL,
  `contato_telefonecomercial` varchar(255) NOT NULL,
  `contato_datacriado` datetime NOT NULL,
  `contato_datamodificado` datetime DEFAULT NULL,
  `contato_criadopor` int(11) NOT NULL,
  `contato_modificadopor` int(11) DEFAULT NULL,
  `contato_conta` int(11) NOT NULL,
  `contato_ativo` tinyint(1) NOT NULL,
  PRIMARY KEY (`contato_id`),
  KEY `fk_contato_conta` (`contato_conta`),
  KEY `fk_contato_criado` (`contato_criadopor`),
  KEY `fk_contato_modificado` (`contato_modificadopor`),
  CONSTRAINT `fk_contato_conta` FOREIGN KEY (`contato_conta`) REFERENCES `contas` (`conta_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_contato_criado` FOREIGN KEY (`contato_criadopor`) REFERENCES `usuarios` (`usua_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_contato_modificado` FOREIGN KEY (`contato_modificadopor`) REFERENCES `usuarios` (`usua_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contatos`
--

LOCK TABLES `contatos` WRITE;
/*!40000 ALTER TABLE `contatos` DISABLE KEYS */;
/*!40000 ALTER TABLE `contatos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `licensas`
--

DROP TABLE IF EXISTS `licensas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `licensas` (
  `licen_id` int(11) NOT NULL AUTO_INCREMENT,
  `licen_chave` varchar(255) NOT NULL,
  `licen_servico` int(11) NOT NULL,
  `licen_ativa` tinyint(1) NOT NULL,
  `licen_datacriada` datetime NOT NULL,
  `licen_datamodificada` datetime DEFAULT NULL,
  `licen_dataativa` datetime DEFAULT NULL,
  `licen_criadapor` int(11) NOT NULL,
  `licen_modificadapor` int(11) DEFAULT NULL,
  `licen_validade` datetime DEFAULT NULL,
  `licen_conta` int(11) NOT NULL,
  `licen_contato` int(11) NOT NULL,
  `licen_especial` tinyint(1) NOT NULL,
  PRIMARY KEY (`licen_id`),
  KEY `fk_licenca_servico` (`licen_servico`),
  KEY `fk_licenca_criado` (`licen_criadapor`),
  KEY `fk_licenca_modificado` (`licen_modificadapor`),
  KEY `fk_licenca_conta` (`licen_conta`),
  KEY `fk_licenca_contato` (`licen_contato`),
  CONSTRAINT `fk_licenca_conta` FOREIGN KEY (`licen_conta`) REFERENCES `contas` (`conta_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_licenca_contato` FOREIGN KEY (`licen_contato`) REFERENCES `contatos` (`contato_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_licenca_criado` FOREIGN KEY (`licen_criadapor`) REFERENCES `usuarios` (`usua_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_licenca_modificado` FOREIGN KEY (`licen_modificadapor`) REFERENCES `usuarios` (`usua_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_licenca_servico` FOREIGN KEY (`licen_servico`) REFERENCES `servicos` (`serv_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `licensas`
--

LOCK TABLES `licensas` WRITE;
/*!40000 ALTER TABLE `licensas` DISABLE KEYS */;
/*!40000 ALTER TABLE `licensas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissoes`
--

DROP TABLE IF EXISTS `permissoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissoes` (
  `perm_id` int(11) NOT NULL AUTO_INCREMENT,
  `perm_nome` varchar(255) NOT NULL,
  `perm_descricao` varchar(255) NOT NULL,
  PRIMARY KEY (`perm_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissoes`
--

LOCK TABLES `permissoes` WRITE;
/*!40000 ALTER TABLE `permissoes` DISABLE KEYS */;
/*!40000 ALTER TABLE `permissoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `servicos`
--

DROP TABLE IF EXISTS `servicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `servicos` (
  `serv_id` int(11) NOT NULL AUTO_INCREMENT,
  `serv_nome` varchar(255) NOT NULL,
  `serv_descricao` varchar(3000) NOT NULL,
  `serv_ativo` tinyint(1) NOT NULL,
  `serv_datacriado` datetime NOT NULL,
  `serv_datamodificado` datetime DEFAULT NULL,
  `serv_criadopor` int(11) NOT NULL,
  `serv_modificadopor` int(11) DEFAULT NULL,
  PRIMARY KEY (`serv_id`),
  KEY `fk_servico_criado` (`serv_criadopor`),
  KEY `fk_servico_modificado` (`serv_modificadopor`),
  CONSTRAINT `fk_servico_criado` FOREIGN KEY (`serv_criadopor`) REFERENCES `usuarios` (`usua_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_servico_modificado` FOREIGN KEY (`serv_modificadopor`) REFERENCES `usuarios` (`usua_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `servicos`
--

LOCK TABLES `servicos` WRITE;
/*!40000 ALTER TABLE `servicos` DISABLE KEYS */;
/*!40000 ALTER TABLE `servicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `usua_id` int(11) NOT NULL AUTO_INCREMENT,
  `usua_nome` varchar(255) NOT NULL,
  `usua_login` varchar(255) NOT NULL,
  `usua_senha` varchar(255) DEFAULT NULL,
  `usua_permissao` int(11) NOT NULL,
  `usua_datacriado` datetime NOT NULL,
  `usua_datamodificado` datetime DEFAULT NULL,
  `usua_dataultimoacesso` datetime DEFAULT NULL,
  `usua_criadopor` int(11) NOT NULL,
  `usua_modificadopor` int(11) DEFAULT NULL,
  `usua_ativo` tinyint(1) NOT NULL,
  PRIMARY KEY (`usua_id`),
  KEY `fk_usuarios_criado` (`usua_criadopor`),
  KEY `fk_usuarios_modificado` (`usua_modificadopor`),
  KEY `fk_usuarios_permissao` (`usua_permissao`),
  CONSTRAINT `fk_usuarios_criado` FOREIGN KEY (`usua_criadopor`) REFERENCES `usuarios` (`usua_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_modificado` FOREIGN KEY (`usua_modificadopor`) REFERENCES `usuarios` (`usua_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_permissao` FOREIGN KEY (`usua_permissao`) REFERENCES `permissoes` (`perm_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
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

-- Dump completed on 2016-11-03 19:22:08
