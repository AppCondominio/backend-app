-- MySQL Script generated by MySQL Workbench
-- Thu Mar  2 18:43:51 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema easycondo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema easycondo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `easycondo` DEFAULT CHARACTER SET utf8 ;
USE `easycondo` ;

-- -----------------------------------------------------
-- Table `easycondo`.`tb_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easycondo`.`tb_user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(30) NOT NULL,
  `lastaName` VARCHAR(30) NOT NULL,
  `document` VARCHAR(11) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(140) NOT NULL,
  `phone` VARCHAR(13) NOT NULL,
  `dtCreated` DATETIME NOT NULL DEFAULT now(),
  `dtUpdated` DATETIME NULL,
  `deviceToken` VARCHAR(255) NULL,
  `status` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `easycondo`.`tb_condo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easycondo`.`tb_condo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `document` VARCHAR(14) NOT NULL,
  `email` VARCHAR(45) NULL,
  `zipCode` VARCHAR(8) NOT NULL,
  `addressNumber` VARCHAR(10) NOT NULL,
  `optAddress` VARCHAR(20) NULL,
  `dtCreated` DATETIME NOT NULL DEFAULT now(),
  `dtUpdated` DATETIME NULL,
  `status` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `easycondo`.`tb_resident`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easycondo`.`tb_resident` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `apartament` VARCHAR(10) NOT NULL,
  `optApartament` VARCHAR(45) NULL,
  `isRental` TINYINT NOT NULL,
  `idUser` INT NOT NULL,
  `idCondo` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_resident_tb_user_idx` (`idUser` ASC) VISIBLE,
  INDEX `fk_tb_resident_tb_condo1_idx` (`idCondo` ASC) VISIBLE,
  CONSTRAINT `fk_tb_resident_tb_user`
    FOREIGN KEY (`idUser`)
    REFERENCES `easycondo`.`tb_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_resident_tb_condo1`
    FOREIGN KEY (`idCondo`)
    REFERENCES `easycondo`.`tb_condo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `easycondo`.`tb_complaint`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easycondo`.`tb_complaint` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `topic` ENUM('reclamacao', 'aviso', 'sugestao', 'outros') NOT NULL COMMENT '1 - Reclamação\n2 - Aviso\n3 - Sugestão\n4 -  \n0 - Outros',
  `description` VARCHAR(45) NOT NULL,
  `attached` BLOB NULL,
  `dtCreated` DATETIME NOT NULL DEFAULT now(),
  `dtUpdated` DATETIME NULL,
  `status` VARCHAR(1) NOT NULL,
  `idCondo` INT NOT NULL,
  `idResident` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_complaint_tb_condo1_idx` (`idCondo` ASC) VISIBLE,
  INDEX `fk_tb_complaint_tb_resident1_idx` (`idResident` ASC) VISIBLE,
  CONSTRAINT `fk_tb_complaint_tb_condo1`
    FOREIGN KEY (`idCondo`)
    REFERENCES `easycondo`.`tb_condo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_complaint_tb_resident1`
    FOREIGN KEY (`idResident`)
    REFERENCES `easycondo`.`tb_resident` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `easycondo`.`tb_setting_condo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easycondo`.`tb_setting_condo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idCondo` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_setting_condo_tb_condo1_idx` (`idCondo` ASC) VISIBLE,
  CONSTRAINT `fk_tb_setting_condo_tb_condo1`
    FOREIGN KEY (`idCondo`)
    REFERENCES `easycondo`.`tb_condo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `easycondo`.`tb_tower_settings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easycondo`.`tb_tower_settings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `dtCreated` DATETIME NOT NULL DEFAULT now(),
  `dtUpdated` DATETIME NULL,
  `idSettingCondo` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_tower_settings_tb_setting_condo1_idx` (`idSettingCondo` ASC) VISIBLE,
  CONSTRAINT `fk_tb_tower_settings_tb_setting_condo1`
    FOREIGN KEY (`idSettingCondo`)
    REFERENCES `easycondo`.`tb_setting_condo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `easycondo`.`tb_recreation_settings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easycondo`.`tb_recreation_settings` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` DOUBLE NULL,
  `dtCreated` DATETIME NOT NULL DEFAULT now(),
  `dtUpdated` DATETIME NULL,
  `status` VARCHAR(1) NULL,
  `idSettingCondo` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_recreation_settings_tb_setting_condo1_idx` (`idSettingCondo` ASC) VISIBLE,
  CONSTRAINT `fk_tb_recreation_settings_tb_setting_condo1`
    FOREIGN KEY (`idSettingCondo`)
    REFERENCES `easycondo`.`tb_setting_condo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `easycondo`.`tb_cooperators`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easycondo`.`tb_cooperators` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `job` VARCHAR(45) NOT NULL,
  `dtCreated` DATETIME NOT NULL DEFAULT now(),
  `dtUpdated` DATETIME NULL,
  `idSettingCondo` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_cooperators_tb_setting_condo1_idx` (`idSettingCondo` ASC) VISIBLE,
  CONSTRAINT `fk_tb_cooperators_tb_setting_condo1`
    FOREIGN KEY (`idSettingCondo`)
    REFERENCES `easycondo`.`tb_setting_condo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `easycondo`.`tb_notices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easycondo`.`tb_notices` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(140) NOT NULL,
  `attached` BLOB NULL,
  `dtToDelete` DATETIME NOT NULL,
  `dtCreated` DATETIME NOT NULL DEFAULT now(),
  `dtUpdated` DATETIME NULL,
  `status` VARCHAR(1) NOT NULL,
  `idCondo` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_notices_tb_condo1_idx` (`idCondo` ASC) VISIBLE,
  CONSTRAINT `fk_tb_notices_tb_condo1`
    FOREIGN KEY (`idCondo`)
    REFERENCES `easycondo`.`tb_condo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `easycondo`.`tb_push`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easycondo`.`tb_push` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(140) NOT NULL,
  `dtSent` DATETIME NOT NULL COMMENT '\n',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `easycondo`.`tb_push_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `easycondo`.`tb_push_user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idPush` INT NOT NULL,
  `idUser` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tb_push_user_tb_push1_idx` (`idPush` ASC) VISIBLE,
  INDEX `fk_tb_push_user_tb_user1_idx` (`idUser` ASC) VISIBLE,
  CONSTRAINT `fk_tb_push_user_tb_push1`
    FOREIGN KEY (`idPush`)
    REFERENCES `easycondo`.`tb_push` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tb_push_user_tb_user1`
    FOREIGN KEY (`idUser`)
    REFERENCES `easycondo`.`tb_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
