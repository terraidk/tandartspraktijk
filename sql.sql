CREATE DATABASE IF NOT EXISTS `tandartspraktijk`;
USE `tandartspraktijk`;

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Table `tandarts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `tandarts` (
  `tandarts_id` INT NOT NULL AUTO_INCREMENT,
  `tandarts_naam` VARCHAR(45) NOT NULL,
  `tandarts_specialisatie` TEXT NOT NULL,
  `tandarts_telefoonnummer` VARCHAR(15) NOT NULL,
  `tandarts_email` VARCHAR(55) NOT NULL,
  PRIMARY KEY (`tandarts_id`),
  UNIQUE INDEX `tandarts_telefoonnummer_UNIQUE` (`tandarts_telefoonnummer` ASC),
  UNIQUE INDEX `tandarts_email_UNIQUE` (`tandarts_email` ASC))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `patient` (
  `patient_id` INT NOT NULL AUTO_INCREMENT,
  `patient_naam` VARCHAR(255) NOT NULL,
  `patient_geboortedatum` DATE NOT NULL,
  `patient_adres` VARCHAR(255) NOT NULL,
  `patient_telefoonnummer` VARCHAR(15) NOT NULL,
  `patient_email` VARCHAR(55) NOT NULL,
  `patient_verzekeringsinformatie` TEXT NOT NULL,
  PRIMARY KEY (`patient_id`),
  UNIQUE INDEX `patient_email_UNIQUE` (`patient_email` ASC))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `betaling`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `betaling` (
  `betaling_id` INT NOT NULL AUTO_INCREMENT,
  `betaling_datum` DATETIME NOT NULL,
  `betaling_bedrag` DECIMAL(10,2) NOT NULL,
  `betaling_betaalwijze` VARCHAR(45) NOT NULL,
  `patient_id` INT NOT NULL,
  PRIMARY KEY (`betaling_id`),
  CONSTRAINT `fk_betaling_patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `patient` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `behandeling`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `behandeling` (
  `behandeling_id` INT NOT NULL AUTO_INCREMENT,
  `behandeling_beschrijving` TEXT NOT NULL,
  `behandeling_kosten` DECIMAL(10,2) NULL,
  `behandeling_duur` TIME NOT NULL,
  `tandarts_id` INT NOT NULL,
  PRIMARY KEY (`behandeling_id`),
  CONSTRAINT `fk_behandeling_tandarts`
    FOREIGN KEY (`tandarts_id`)
    REFERENCES `tandarts` (`tandarts_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `afspraak`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `afspraak` (
  `afspraak_id` INT NOT NULL AUTO_INCREMENT,
  `afspraak_datum` DATETIME NOT NULL,
  `afspraak_typebehandeling` TEXT NOT NULL,
  `patient_id` INT NOT NULL,
  `behandeling_id` INT NOT NULL,
  PRIMARY KEY (`afspraak_id`),
  CONSTRAINT `fk_afspraak_patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `patient` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_afspraak_behandeling`
    FOREIGN KEY (`behandeling_id`)
    REFERENCES `behandeling` (`behandeling_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `recept`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recept` (
  `recept_id` INT NOT NULL AUTO_INCREMENT,
  `recept_medicijnnaam` VARCHAR(255) NOT NULL,
  `recept_dosering` VARCHAR(45) NOT NULL,
  `recept_beschrijving` TEXT NOT NULL,
  `patient_id` INT NOT NULL,
  PRIMARY KEY (`recept_id`),
  CONSTRAINT `fk_recept_patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `patient` (`patient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
