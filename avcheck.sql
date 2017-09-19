--
-- Скрипт сгенерирован Devart dbForge Studio for MySQL, Версия 7.2.78.0
-- Домашняя страница продукта: http://www.devart.com/ru/dbforge/mysql/studio
-- Дата скрипта: 18.09.2017 21:27:21
-- Версия сервера: 5.5.55-0+deb8u1
-- Версия клиента: 4.1
--


-- 
-- Отключение внешних ключей
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Установить режим SQL (SQL mode)
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Установка кодировки, с использованием которой клиент будет посылать запросы на сервер
--
SET NAMES 'utf8';

-- 
-- Установка базы данных по умолчанию
--
USE avcheck;

--
-- Описание для таблицы avc_domine
--
DROP TABLE IF EXISTS avc_domine;
CREATE TABLE avc_domine (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL DEFAULT '',
  descr VARCHAR(255) NOT NULL DEFAULT '',
  owner INT(11) NOT NULL DEFAULT 0,
  is_grp CHAR(1) NOT NULL DEFAULT 'N',
  parent INT(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 43
AVG_ROW_LENGTH = 910
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы avc_engs
--
DROP TABLE IF EXISTS avc_engs;
CREATE TABLE avc_engs (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  idkey INT(2) NOT NULL DEFAULT 0,
  enkey VARCHAR(10) NOT NULL DEFAULT '',
  name VARCHAR(50) NOT NULL DEFAULT '',
  descr VARCHAR(255) NOT NULL DEFAULT '',
  script VARCHAR(255) NOT NULL DEFAULT '',
  class VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  UNIQUE INDEX UK_avc_engs_idkey (idkey)
)
ENGINE = INNODB
AUTO_INCREMENT = 3
AVG_ROW_LENGTH = 8192
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы avc_file
--
DROP TABLE IF EXISTS avc_file;
CREATE TABLE avc_file (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL DEFAULT '',
  oname VARCHAR(100) NOT NULL DEFAULT '',
  descr VARCHAR(255) NOT NULL DEFAULT '',
  type VARCHAR(50) NOT NULL DEFAULT '',
  owner INT(11) NOT NULL DEFAULT 0,
  time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  is_grp CHAR(1) NOT NULL DEFAULT 'N',
  parent INT(10) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 77
AVG_ROW_LENGTH = 2048
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы avc_filters
--
DROP TABLE IF EXISTS avc_filters;
CREATE TABLE avc_filters (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  engine VARCHAR(10) NOT NULL DEFAULT '',
  avkey VARCHAR(10) NOT NULL DEFAULT '',
  name VARCHAR(50) NOT NULL DEFAULT '',
  class VARCHAR(10) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 85
AVG_ROW_LENGTH = 292
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы avc_jobs
--
DROP TABLE IF EXISTS avc_jobs;
CREATE TABLE avc_jobs (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  type VARCHAR(10) NOT NULL DEFAULT 'avc_file',
  object INT(11) UNSIGNED NOT NULL,
  time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  engine INT(11) UNSIGNED NOT NULL DEFAULT 1,
  user INT(11) UNSIGNED NOT NULL DEFAULT 1,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 180
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы avc_param
--
DROP TABLE IF EXISTS avc_param;
CREATE TABLE avc_param (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL DEFAULT '',
  val VARCHAR(1024) DEFAULT '',
  parent INT(11) NOT NULL DEFAULT 0,
  ptype VARCHAR(50) NOT NULL DEFAULT '',
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 11
AVG_ROW_LENGTH = 5461
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы avc_resume
--
DROP TABLE IF EXISTS avc_resume;
CREATE TABLE avc_resume (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  engine VARCHAR(10) NOT NULL DEFAULT '',
  type VARCHAR(10) NOT NULL,
  object INT(11) NOT NULL,
  time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  resume TEXT NOT NULL,
  user INT(11) UNSIGNED NOT NULL DEFAULT 0,
  iserror CHAR(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 71
AVG_ROW_LENGTH = 2340
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы avc_shedule
--
DROP TABLE IF EXISTS avc_shedule;
CREATE TABLE avc_shedule (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL DEFAULT '',
  descr VARCHAR(255) NOT NULL DEFAULT '',
  user INT(11) NOT NULL DEFAULT 1,
  shed CHAR(7) NOT NULL DEFAULT '0000000',
  time INT(11) NOT NULL DEFAULT 300,
  valid TINYINT(4) NOT NULL DEFAULT 0,
  impl TINYINT(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 8
AVG_ROW_LENGTH = 16384
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы avc_shedule2
--
DROP TABLE IF EXISTS avc_shedule2;
CREATE TABLE avc_shedule2 (
  id INT(11) NOT NULL AUTO_INCREMENT,
  sid INT(11) NOT NULL,
  itype VARCHAR(20) NOT NULL,
  item INT(11) NOT NULL,
  flag CHAR(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 9
AVG_ROW_LENGTH = 5461
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы avc_userfilters
--
DROP TABLE IF EXISTS avc_userfilters;
CREATE TABLE avc_userfilters (
  id INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  user INT(11) NOT NULL DEFAULT 0,
  avkey INT(11) NOT NULL DEFAULT 0,
  flag TINYINT(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 4
AVG_ROW_LENGTH = 5461
CHARACTER SET utf8
COLLATE utf8_general_ci;

--
-- Описание для таблицы avc_users
--
DROP TABLE IF EXISTS avc_users;
CREATE TABLE avc_users (
  id INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  login VARCHAR(50) NOT NULL DEFAULT '',
  role TINYINT(1) NOT NULL DEFAULT 9,
  pass VARCHAR(32) NOT NULL DEFAULT '',
  jabber VARCHAR(255) NOT NULL DEFAULT '',
  PRIMARY KEY (id),
  UNIQUE INDEX login (login)
)
ENGINE = INNODB
AUTO_INCREMENT = 6
AVG_ROW_LENGTH = 4096
CHARACTER SET utf8
COLLATE utf8_general_ci;

INSERT INTO avc_engs VALUES
(1, 1, 'vcm', 'VirusCheckMate', '', 'eng_vcm.cls', 'eng_vcm');
-- 
-- Вывод данных для таблицы avc_users
--
INSERT INTO avc_users VALUES
(1, 'admin', 1, '6972e6eb8488adfae83e869e6cd63e61', 'vaa7777777@jabber.ru');

-- 
-- Восстановить предыдущий режим SQL (SQL mode)
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Включение внешних ключей
-- 
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;