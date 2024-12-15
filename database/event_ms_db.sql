-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema event_ms_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema event_ms_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `event_ms_db` ;
USE `event_ms_db` ;

-- -----------------------------------------------------
-- Table `event_ms_db`.`organization_tb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `event_ms_db`.`organization_tb` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `org_name` VARCHAR(255) NULL,
  `created_on` DATETIME NULL,
  `company_email` VARCHAR(255) NULL,
  `contact_no` VARCHAR(255) NULL,
  `removed_on` DATETIME NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `company_email_UNIQUE` (`company_email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_ms_db`.`user_tb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `event_ms_db`.`user_tb` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(255) NULL,
  `created_on` DATETIME NULL,
  `last_logged_in` DATETIME NULL,
  `is_active` VARCHAR(45) NULL,
  `role` VARCHAR(45) NULL,
  `mobile_no` VARCHAR(255) NULL,
  `org_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_user_tb_1_idx` (`org_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_tb_1`
    FOREIGN KEY (`org_id`)
    REFERENCES `event_ms_db`.`organization_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_ms_db`.`event_tb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `event_ms_db`.`event_tb` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `venue` VARCHAR(255) NULL,
  `scheduled_date` DATETIME NULL,
  `org_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_tb_1_idx` (`org_id` ASC) VISIBLE,
  CONSTRAINT `fk_event_tb_1`
    FOREIGN KEY (`org_id`)
    REFERENCES `event_ms_db`.`organization_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_ms_db`.`event_img_tb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `event_ms_db`.`event_img_tb` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `file_path` VARCHAR(255) NULL,
  `file_type` VARCHAR(45) NULL,
  `file_name` VARCHAR(45) NULL,
  `event_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_img_tb_1_idx` (`event_id` ASC) VISIBLE,
  CONSTRAINT `fk_event_img_tb_1`
    FOREIGN KEY (`event_id`)
    REFERENCES `event_ms_db`.`event_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_ms_db`.`event_form_tb`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `event_ms_db`.`event_form_tb` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `event_id` INT NULL,
  `question` VARCHAR(255) NULL,
  `required` VARCHAR(5) NULL,
  `answer_input` VARCHAR(45) NULL,
  `options` VARCHAR(255) NULL,
  `label` VARCHAR(45) NULL,
  `display_order` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_form_tb_1_idx` (`event_id` ASC) VISIBLE,
  CONSTRAINT `fk_event_form_tb_1`
    FOREIGN KEY (`event_id`)
    REFERENCES `event_ms_db`.`event_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE `event_ms_db`.`payment_tb` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `event_id` INT NULL,
  `org_id` INT NULL,
  `amount` VARCHAR(45) NULL,
  `payment_method` VARCHAR(45) NULL,
  `payment_status` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_payment_tb_1_idx` (`event_id` ASC) VISIBLE,
  INDEX `fk_payment_tb_2_idx` (`org_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_tb_1`
    FOREIGN KEY (`event_id`)
    REFERENCES `event_ms_db`.`event_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_payment_tb_2`
    FOREIGN KEY (`org_id`)
    REFERENCES `event_ms_db`.`organization_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE `event_ms_db`.`event_participant_ans` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `answer` VARCHAR(45) NULL,
  `question_id` INT NULL,
  `event_id` INT NULL,
  `user_id` INT NULL,
  `answered_on` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_event_participant_ans_1_idx` (`question_id` ASC) VISIBLE,
  INDEX `fk_event_participant_ans_2_idx` (`event_id` ASC) VISIBLE,
  INDEX `fk_event_participant_ans_3_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_event_participant_ans_1`
    FOREIGN KEY (`question_id`)
    REFERENCES `event_ms_db`.`event_form_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_participant_ans_2`
    FOREIGN KEY (`event_id`)
    REFERENCES `event_ms_db`.`event_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_participant_ans_3`
    FOREIGN KEY (`user_id`)
    REFERENCES `event_ms_db`.`user_tb` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;




SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
