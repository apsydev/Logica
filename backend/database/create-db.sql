SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema LOGICA
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `LOGICA` ;
CREATE SCHEMA IF NOT EXISTS `LOGICA` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `LOGICA` ;

-- -----------------------------------------------------
-- Table `LOGICA`.`LANGUAGES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LOGICA`.`LANGUAGES` ;

CREATE TABLE IF NOT EXISTS `LOGICA`.`LANGUAGES` (
  `LANG_ID` INT NOT NULL AUTO_INCREMENT,
  `LANG_DESC` VARCHAR(45) NULL,
  PRIMARY KEY (`LANG_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LOGICA`.`CATEGORIES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LOGICA`.`CATEGORIES` ;

CREATE TABLE IF NOT EXISTS `LOGICA`.`CATEGORIES` (
  `CATEGORY_ID` INT NOT NULL AUTO_INCREMENT,
  `CATEGORY_ORDER` INT NULL,
  `LANG_ID` INT NOT NULL,
  `CATEGORY_DESC` VARCHAR(200) NULL,
  PRIMARY KEY (`CATEGORY_ID`, `LANG_ID`),
  INDEX `fk_CATEGORIES_LANGUAGES1_idx` (`LANG_ID` ASC),
  CONSTRAINT `fk_CATEGORIES_LANGUAGES1`
    FOREIGN KEY (`LANG_ID`)
    REFERENCES `LOGICA`.`LANGUAGES` (`LANG_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LOGICA`.`TASKS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LOGICA`.`TASKS` ;

CREATE TABLE IF NOT EXISTS `LOGICA`.`TASKS` (
  `TASK_ID` INT NOT NULL AUTO_INCREMENT,
  `TASK_ORDER` INT NULL,
  `CATEGORY_ID` INT NOT NULL,
  `LANG_ID` INT NOT NULL,
  PRIMARY KEY (`TASK_ID`, `CATEGORY_ID`, `LANG_ID`),
  INDEX `fk_TASKS_CATEGORIES1_idx` (`CATEGORY_ID` ASC, `LANG_ID` ASC),
  CONSTRAINT `fk_TASKS_CATEGORIES1`
    FOREIGN KEY (`CATEGORY_ID` , `LANG_ID`)
    REFERENCES `LOGICA`.`CATEGORIES` (`CATEGORY_ID` , `LANG_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LOGICA`.`TEXT_TYPES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LOGICA`.`TEXT_TYPES` ;

CREATE TABLE IF NOT EXISTS `LOGICA`.`TEXT_TYPES` (
  `TYPE_ID` INT NOT NULL AUTO_INCREMENT,
  `TYPE_DESC` VARCHAR(150) NULL,
  PRIMARY KEY (`TYPE_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LOGICA`.`TEXTS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LOGICA`.`TEXTS` ;

CREATE TABLE IF NOT EXISTS `LOGICA`.`TEXTS` (
  `TEXT_ID` BIGINT NOT NULL AUTO_INCREMENT,
  `LANG_ID` INT NOT NULL,
  `TYPE_ID` INT NOT NULL,
  `TEXT_DESC` LONGTEXT NULL,
  `TASK_ID` INT NOT NULL,
  PRIMARY KEY (`TEXT_ID`, `LANG_ID`, `TYPE_ID`, `TASK_ID`),
  INDEX `fk_TEXTS_LANGUAGES_idx` (`LANG_ID` ASC),
  INDEX `fk_TEXTS_TEXT_TYPES1_idx` (`TYPE_ID` ASC),
  INDEX `fk_TEXTS_TASKS1_idx` (`TASK_ID` ASC),
  CONSTRAINT `fk_TEXTS_LANGUAGES`
    FOREIGN KEY (`LANG_ID`)
    REFERENCES `LOGICA`.`LANGUAGES` (`LANG_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TEXTS_TEXT_TYPES1`
    FOREIGN KEY (`TYPE_ID`)
    REFERENCES `LOGICA`.`TEXT_TYPES` (`TYPE_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TEXTS_TASKS1`
    FOREIGN KEY (`TASK_ID`)
    REFERENCES `LOGICA`.`TASKS` (`TASK_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LOGICA`.`SETTINGS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LOGICA`.`SETTINGS` ;

CREATE TABLE IF NOT EXISTS `LOGICA`.`SETTINGS` (
  `SETTING_ID` INT NOT NULL,
  PRIMARY KEY (`SETTING_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LOGICA`.`THEMES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LOGICA`.`THEMES` ;

CREATE TABLE IF NOT EXISTS `LOGICA`.`THEMES` (
  `THEME_ID` INT NOT NULL AUTO_INCREMENT,
  `THEME_DESC` VARCHAR(45) NULL,
  PRIMARY KEY (`THEME_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LOGICA`.`USER_PROFILES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LOGICA`.`USER_PROFILES` ;

CREATE TABLE IF NOT EXISTS `LOGICA`.`USER_PROFILES` (
  `USER_ID` INT NOT NULL AUTO_INCREMENT,
  `DEVICE_ID` VARCHAR(255) NULL,
  `IS_ADS_FREE` TINYINT(1) NULL,
  `THEME_ID` INT NOT NULL,
  `LANG_ID` INT NOT NULL,
  PRIMARY KEY (`USER_ID`, `THEME_ID`, `LANG_ID`),
  INDEX `fk_USER_PROFILES_THEMES1_idx` (`THEME_ID` ASC),
  INDEX `fk_USER_PROFILES_LANGUAGES1_idx` (`LANG_ID` ASC),
  CONSTRAINT `fk_USER_PROFILES_THEMES1`
    FOREIGN KEY (`THEME_ID`)
    REFERENCES `LOGICA`.`THEMES` (`THEME_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_PROFILES_LANGUAGES1`
    FOREIGN KEY (`LANG_ID`)
    REFERENCES `LOGICA`.`LANGUAGES` (`LANG_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LOGICA`.`ROLES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LOGICA`.`ROLES` ;

CREATE TABLE IF NOT EXISTS `LOGICA`.`ROLES` (
  `ROLE_ID` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ROLE_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LOGICA`.`IMAGES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LOGICA`.`IMAGES` ;

CREATE TABLE IF NOT EXISTS `LOGICA`.`IMAGES` (
  `IMAGE_ID` INT NOT NULL AUTO_INCREMENT,
  `IMAGE` BLOB NULL,
  `IMAGE_POSITION` VARCHAR(80) NULL,
  `TEXT_ID` BIGINT NOT NULL DEFAULT -1,
  `LANG_ID` INT NOT NULL DEFAULT -1,
  PRIMARY KEY (`IMAGE_ID`),
  INDEX `fk_IMAGES_TEXTS1_idx` (`TEXT_ID` ASC, `LANG_ID` ASC),
  CONSTRAINT `fk_IMAGES_TEXTS1`
    FOREIGN KEY (`TEXT_ID` , `LANG_ID`)
    REFERENCES `LOGICA`.`TEXTS` (`TEXT_ID` , `LANG_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
GRANT USAGE ON *.* TO user1;
 DROP USER user1;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'user1';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;