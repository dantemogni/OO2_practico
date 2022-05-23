-- MySQL Script generated by MySQL Workbench
-- Fri May 13 01:46:46 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bd_gestion_aulas
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bd_gestion_aulas` ;

-- -----------------------------------------------------
-- Schema bd_gestion_aulas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bd_gestion_aulas` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `bd_gestion_aulas` ;

-- -----------------------------------------------------
-- Table `bd_gestion_aulas`.`rol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bd_gestion_aulas`.`rol` ;

CREATE TABLE IF NOT EXISTS `bd_gestion_aulas`.`rol` (
  `id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL
);


-- -----------------------------------------------------
-- Table `bd_gestion_aulas`.`departamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bd_gestion_aulas`.`departamento` ;

CREATE TABLE IF NOT EXISTS `bd_gestion_aulas`.`departamento` (
  `id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL
);


-- -----------------------------------------------------
-- Table `bd_gestion_aulas`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bd_gestion_aulas`.`usuario` ;

CREATE TABLE IF NOT EXISTS `bd_gestion_aulas`.`usuario` (
  `id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `tipo_documento` VARCHAR(45) NOT NULL,
  `nro_documento` DOUBLE NOT NULL,
  `id_role` BIGINT NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `enabled` BIT(1) NOT NULL DEFAULT 0,
  INDEX `fk_Usuario_Role_idx` (`id_role` ASC) VISIBLE,
  UNIQUE INDEX `username_UNIQUE` (`username` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_Role`
    FOREIGN KEY (`id_role`)
    REFERENCES `bd_gestion_aulas`.`rol` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );

-- -----------------------------------------------------
-- Table `bd_gestion_aulas`.`edificio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bd_gestion_aulas`.`edificio` ;

CREATE TABLE IF NOT EXISTS `bd_gestion_aulas`.`edificio` (
  `id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `edificio` VARCHAR(30) NOT NULL
);


-- -----------------------------------------------------
-- Table `bd_gestion_aulas`.`aula`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bd_gestion_aulas`.`aula` ;

CREATE TABLE IF NOT EXISTS `bd_gestion_aulas`.`aula` (
  `id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `numero` INT NOT NULL,
  `id_edificio` BIGINT NOT NULL,
  INDEX `fk_Aula_1_idx` (`id_edificio` ASC) VISIBLE,
  CONSTRAINT `fk_Aula_1`
    FOREIGN KEY (`id_edificio`)
    REFERENCES `bd_gestion_aulas`.`edificio` (`id`)
    );


-- -----------------------------------------------------
-- Table `bd_gestion_aulas`.`espacio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bd_gestion_aulas`.`espacio` ;

CREATE TABLE IF NOT EXISTS `bd_gestion_aulas`.`espacio` (
  `id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `turno` CHAR(1) NOT NULL,
  `id_aula` BIGINT NOT NULL,
  `libre` TINYINT NOT NULL,
  INDEX `fk_Espacio_1_idx` (`id_aula` ASC) VISIBLE,
  CONSTRAINT `fk_Espacio_1`
    FOREIGN KEY (`id_aula`)
    REFERENCES `bd_gestion_aulas`.`aula` (`id`)
    );


-- -----------------------------------------------------
-- Table `bd_gestion_aulas`.`laboratorio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bd_gestion_aulas`.`laboratorio` ;

CREATE TABLE IF NOT EXISTS `bd_gestion_aulas`.`laboratorio` (
  `id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `cant_sillas` INT NOT NULL,
  `cant_pc` INT NOT NULL,
  CONSTRAINT `fk_Laboratorio_1`
    FOREIGN KEY (`id`)
    REFERENCES `bd_gestion_aulas`.`aula` (`id`)
    );


-- -----------------------------------------------------
-- Table `bd_gestion_aulas`.`tradicional`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bd_gestion_aulas`.`tradicional` ;

CREATE TABLE IF NOT EXISTS `bd_gestion_aulas`.`tradicional` (
  `id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `cant_bancos` INT NOT NULL,
  `pizarron` VARCHAR(10) NOT NULL,
  `tiene_proyector` TINYINT NOT NULL,
  CONSTRAINT `fk_Tradicional_1`
    FOREIGN KEY (`id`)
    REFERENCES `bd_gestion_aulas`.`aula` (`id`)
    );



-- -----------------------------------------------------
-- Table `bd_gestion_aulas`.`carrera`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bd_gestion_aulas`.`carrera` ;

CREATE TABLE IF NOT EXISTS `bd_gestion_aulas`.`carrera` (
  `id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `carrera` VARCHAR(45) NOT NULL,
  `id_departamento` BIGINT NOT NULL,
  INDEX `fk_Carrera_Departamento1_idx` (`id_departamento` ASC) VISIBLE,
  CONSTRAINT `fk_Carrera_Departamento1`
    FOREIGN KEY (`id_departamento`)
    REFERENCES `bd_gestion_aulas`.`departamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );


-- -----------------------------------------------------
-- Table `bd_gestion_aulas`.`materia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bd_gestion_aulas`.`materia` ;

CREATE TABLE IF NOT EXISTS `bd_gestion_aulas`.`materia` (
  `id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `codigo` INT(15) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `id_carrera` BIGINT NOT NULL,
  INDEX `fk_Materia_Carrera1_idx` (`id_carrera` ASC) VISIBLE,
  CONSTRAINT `fk_Materia_Carrera1`
    FOREIGN KEY (`id_carrera`)
    REFERENCES `bd_gestion_aulas`.`carrera` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );


-- -----------------------------------------------------
-- Table `bd_gestion_aulas`.`nota_pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bd_gestion_aulas`.`nota_pedido` ;

CREATE TABLE IF NOT EXISTS `bd_gestion_aulas`.`nota_pedido` (
  `id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `turno` CHAR NOT NULL,
  `cant_estudiantes` VARCHAR(45) NOT NULL,
  `observaciones` VARCHAR(45) NOT NULL,
  `id_carrera` BIGINT NOT NULL,
  `id_aula` BIGINT NOT NULL,
  `id_materia` BIGINT NOT NULL,
  INDEX `fk_NotaPedido_Carrera1_idx` (`id_carrera` ASC) VISIBLE,
  INDEX `fk_NotaPedido_aula1_idx` (`id_aula` ASC) VISIBLE,
  INDEX `fk_NotaPedido_Materia1_idx` (`id_materia` ASC) VISIBLE,
  CONSTRAINT `fk_NotaPedido_Carrera1`
    FOREIGN KEY (`id_carrera`)
    REFERENCES `bd_gestion_aulas`.`carrera` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_NotaPedido_aula1`
    FOREIGN KEY (`id_aula`)
    REFERENCES `bd_gestion_aulas`.`aula` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_NotaPedido_Materia1`
    FOREIGN KEY (`id_materia`)
    REFERENCES `bd_gestion_aulas`.`materia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );


-- -----------------------------------------------------
-- Table `bd_gestion_aulas`.`curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bd_gestion_aulas`.`curso` ;

CREATE TABLE IF NOT EXISTS `bd_gestion_aulas`.`curso` (
  `id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `codigo` VARCHAR(45) NOT NULL,
  CONSTRAINT `fk_Curso_NotaPedido1`
    FOREIGN KEY (`id`)
    REFERENCES `bd_gestion_aulas`.`nota_pedido` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );


-- -----------------------------------------------------
-- Table `bd_gestion_aulas`.`final`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bd_gestion_aulas`.`final` ;

CREATE TABLE IF NOT EXISTS `bd_gestion_aulas`.`final` (
  `id` BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `fecha_examen` DATE NOT NULL,
  CONSTRAINT `fk_Final_1`
    FOREIGN KEY (`id`)
    REFERENCES `bd_gestion_aulas`.`nota_pedido` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    );


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;