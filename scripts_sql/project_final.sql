-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema project_final
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema project_final
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `project_final` DEFAULT CHARACTER SET utf8 ;
USE `project_final` ;

-- -----------------------------------------------------
-- Table `project_final`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_final`.`user` (
  `user_id` INT NOT NULL,
  `fname` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NOT NULL,
  `is_freelancer` BOOLEAN  NULL,
  `is_owner` BOOLEAN  NULL,
  `address` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(50) NOT NULL,
  `reg_date` DATE NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project_final`.`project_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_final`.`project_status` (
  `project_status_id` INT NOT NULL,
  `project_status_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`project_status_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project_final`.`project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_final`.`project` (
  `project_id` INT NOT NULL,
  `p_name` VARCHAR(45) NOT NULL,
  `p_description` VARCHAR(45) NOT NULL,
  `project_post_date` DATE NOT NULL,
  `project_duration` INT NOT NULL,
  `owner_id` INT NOT NULL,
  `project_status` INT NOT NULL,
  `appointed_freelancer` INT NULL,
  PRIMARY KEY (`project_id`),
  INDEX `fk_project_user1_idx` (`owner_id` ASC),
  INDEX `fk_project_project_status1_idx` (`project_status` ASC),
  INDEX `fk_project_user2_idx` (`appointed_freelancer` ASC),
  CONSTRAINT `fk_project_user1`
    FOREIGN KEY (`owner_id`)
    REFERENCES `project_final`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_project_status1`
    FOREIGN KEY (`project_status`)
    REFERENCES `project_final`.`project_status` (`project_status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_user2`
    FOREIGN KEY (`appointed_freelancer`)
    REFERENCES `project_final`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project_final`.`proposal_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_final`.`proposal_status` (
  `proposal_status_id` INT NOT NULL,
  `proposal_status_name` VARCHAR(45) NULL,
  PRIMARY KEY (`proposal_status_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project_final`.`proposal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_final`.`proposal` (
  `proposal_id` INT NOT NULL,
  `rate` VARCHAR(45) NOT NULL,
  `rate_type` BOOLEAN NOT NULL,
  `proposal_status` INT NOT NULL,
  `freelancer_id` INT NOT NULL,
  `project_id` INT NOT NULL,
  `proposal_post_date` DATE NOT NULL,
  PRIMARY KEY (`proposal_id`),
  INDEX `fk_proposal_proposal_status_idx` (`proposal_status` ASC),
  INDEX `fk_proposal_user1_idx` (`freelancer_id` ASC),
  INDEX `fk_proposal_project1_idx` (`project_id` ASC),
  CONSTRAINT `fk_proposal_proposal_status`
    FOREIGN KEY (`proposal_status`)
    REFERENCES `project_final`.`proposal_status` (`proposal_status_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proposal_user1`
    FOREIGN KEY (`freelancer_id`)
    REFERENCES `project_final`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_proposal_project1`
    FOREIGN KEY (`project_id`)
    REFERENCES `project_final`.`project` (`project_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project_final`.`message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_final`.`message` (
  `message_id` INT NOT NULL,
  `message_content` VARCHAR(45) NOT NULL,
  `message_from` INT NOT NULL,
  `message_date` DATE NOT NULL,
  `message_to` INT NOT NULL,
  `project_id` INT NOT NULL,
  `proposal_id` INT NOT NULL,
  PRIMARY KEY (`message_id`),
  INDEX `fk_message_user1_idx` (`message_from` ASC),
  INDEX `fk_message_user2_idx` (`message_to` ASC),
  INDEX `fk_message_project1_idx` (`project_id` ASC),
  INDEX `fk_message_proposal1_idx` (`proposal_id` ASC),
  CONSTRAINT `fk_message_user1`
    FOREIGN KEY (`message_from`)
    REFERENCES `project_final`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_user2`
    FOREIGN KEY (`message_to`)
    REFERENCES `project_final`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_project1`
    FOREIGN KEY (`project_id`)
    REFERENCES `project_final`.`project` (`project_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_proposal1`
    FOREIGN KEY (`proposal_id`)
    REFERENCES `project_final`.`proposal` (`proposal_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project_final`.`review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_final`.`review` (
  `review_id` INT NOT NULL,
  `review_content` VARCHAR(45) NOT NULL,
  `review_date` VARCHAR(45) NOT NULL,
  `rating` INT NOT NULL,
  `project_id` INT NOT NULL,
  `review_from` INT NOT NULL,
  `review_to` INT NOT NULL,
  PRIMARY KEY (`review_id`),
  INDEX `fk_review_project1_idx` (`project_id` ASC),
  INDEX `fk_review_user1_idx` (`review_from` ASC),
  INDEX `fk_review_user2_idx` (`review_to` ASC),
  CONSTRAINT `fk_review_project1`
    FOREIGN KEY (`project_id`)
    REFERENCES `project_final`.`project` (`project_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_user1`
    FOREIGN KEY (`review_from`)
    REFERENCES `project_final`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_user2`
    FOREIGN KEY (`review_to`)
    REFERENCES `project_final`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project_final`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_final`.`category` (
  `category_id` INT NOT NULL,
  `category_name` VARCHAR(45) NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `project_final`.`project_has_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_final`.`project_has_category` (
  `project_project_id` INT NOT NULL,
  `category_category_id` INT NOT NULL,
  PRIMARY KEY (`project_project_id`, `category_category_id`),
  INDEX `fk_project_has_category_category1_idx` (`category_category_id` ASC),
  INDEX `fk_project_has_category_project1_idx` (`project_project_id` ASC),
  CONSTRAINT `fk_project_has_category_project1`
    FOREIGN KEY (`project_project_id`)
    REFERENCES `project_final`.`project` (`project_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_project_has_category_category1`
    FOREIGN KEY (`category_category_id`)
    REFERENCES `project_final`.`category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
