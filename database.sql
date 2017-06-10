SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mediadb` DEFAULT CHARACTER SET utf8 ;
USE `mediadb` ;

-- -----------------------------------------------------
-- Table `mediadb`.`profile`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mediadb`.`profile` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mediadb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mediadb`.`user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mediadb`.`media`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mediadb`.`media` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `profile_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_media_profile_idx` (`profile_id` ASC),
  INDEX `fk_media_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_media_profile`
    FOREIGN KEY (`profile_id`)
    REFERENCES `mediadb`.`profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_media_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mediadb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mediadb`.`file`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mediadb`.`file` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `path` VARCHAR(255) NOT NULL,
  `format` VARCHAR(45) NOT NULL,
  `media_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_file_media1_idx` (`media_id` ASC),
  CONSTRAINT `fk_file_media1`
    FOREIGN KEY (`media_id`)
    REFERENCES `mediadb`.`media` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mediadb`.`parameter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mediadb`.`parameter` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  `default_value` VARCHAR(128) NULL DEFAULT NULL,
  `regexp` VARCHAR(128) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mediadb`.`profile_has_parameter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mediadb`.`profile_has_parameter` (
  `profile_id` INT(11) NOT NULL,
  `parameter_id` INT(11) NOT NULL,
  PRIMARY KEY (`profile_id`, `parameter_id`),
  INDEX `fk_profile_has_parameter_parameter1_idx` (`parameter_id` ASC),
  CONSTRAINT `fk_profile_has_parameter_profile1`
    FOREIGN KEY (`profile_id`)
    REFERENCES `mediadb`.`profile` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profile_has_parameter_parameter1`
    FOREIGN KEY (`parameter_id`)
    REFERENCES `mediadb`.`parameter` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mediadb`.`sharing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mediadb`.`sharing` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_sharing_id` INT(11) NOT NULL,
  `user_share_to_id` INT(11) NOT NULL,
  `media_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_sharing_user1_idx` (`user_sharing_id` ASC),
  INDEX `fk_sharing_user2_idx` (`user_share_to_id` ASC),
  INDEX `fk_sharing_media1_idx` (`media_id` ASC),
  CONSTRAINT `fk_sharing_user1`
    FOREIGN KEY (`user_sharing_id`)
    REFERENCES `mediadb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sharing_user2`
    FOREIGN KEY (`user_share_to_id`)
    REFERENCES `mediadb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sharing_media1`
    FOREIGN KEY (`media_id`)
    REFERENCES `mediadb`.`media` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mediadb`.`value`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mediadb`.`value` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `media_id` INT(11) NOT NULL,
  `parameter_id` INT(11) NOT NULL,
  `value` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `unique_fks` (`media_id` ASC, `parameter_id` ASC),
  INDEX `fk_value_media1_idx` (`media_id` ASC),
  INDEX `fk_value_parameter1_idx` (`parameter_id` ASC),
  CONSTRAINT `fk_value_media1`
    FOREIGN KEY (`media_id`)
    REFERENCES `mediadb`.`media` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_value_parameter1`
    FOREIGN KEY (`parameter_id`)
    REFERENCES `mediadb`.`parameter` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;