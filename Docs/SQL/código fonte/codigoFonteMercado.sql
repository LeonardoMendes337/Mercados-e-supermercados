-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Preco_de_produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Preco_de_produtos` (
  `idpreco` INT NOT NULL,
  `produto` VARCHAR(20) NOT NULL,
  `preco` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idpreco`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produtos` (
  `id_produto` INT NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `descricao` VARCHAR(500) NOT NULL,
  `marca` VARCHAR(45) NOT NULL,
  `peso` VARCHAR(10) NOT NULL,
  `origem` VARCHAR(20) NOT NULL,
  `embalagem` VARCHAR(45) NOT NULL,
  `ingredientes` VARCHAR(100) NOT NULL,
  `componentes_alergicos` VARCHAR(45) NOT NULL,
  `especificidades_alimentares` VARCHAR(45) NOT NULL,
  `fabricante` VARCHAR(45) NOT NULL,
  `sac_do_fornecedor` VARCHAR(25) NOT NULL,
  `observacoes` VARCHAR(100) NULL,
  `Preco_de_produtos_idpreco` INT NOT NULL,
  PRIMARY KEY (`id_produto`, `Preco_de_produtos_idpreco`),
  INDEX `fk_Produtos_Preco_de_produtos1_idx` (`Preco_de_produtos_idpreco` ASC) VISIBLE,
  CONSTRAINT `fk_Produtos_Preco_de_produtos1`
    FOREIGN KEY (`Preco_de_produtos_idpreco`)
    REFERENCES `mydb`.`Preco_de_produtos` (`idpreco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Servico_de_geolocalizacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Servico_de_geolocalizacao` (
  `id_geolocalizacao` INT NOT NULL,
  `raio_km` VARCHAR(20) NULL,
  PRIMARY KEY (`id_geolocalizacao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estabelecimentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estabelecimentos` (
  `id_estabelecimentos` INT NOT NULL,
  `nome_social` VARCHAR(45) NOT NULL,
  `nome_fantasia` VARCHAR(45) NOT NULL,
  `cnpj` INT NOT NULL,
  `cep` INT NOT NULL,
  `endereco` VARCHAR(60) NOT NULL,
  `bairro` VARCHAR(30) NOT NULL,
  `telefone` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `Servico_de_geolocalizacao_id_geolocalizacao` INT NOT NULL,
  PRIMARY KEY (`id_estabelecimentos`, `Servico_de_geolocalizacao_id_geolocalizacao`),
  INDEX `fk_Estabelecimentos_Servico_de_geolocalizacao1_idx` (`Servico_de_geolocalizacao_id_geolocalizacao` ASC) VISIBLE,
  CONSTRAINT `fk_Estabelecimentos_Servico_de_geolocalizacao1`
    FOREIGN KEY (`Servico_de_geolocalizacao_id_geolocalizacao`)
    REFERENCES `mydb`.`Servico_de_geolocalizacao` (`id_geolocalizacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario` (
  `id_usuario` INT NOT NULL,
  `cpf` INT NOT NULL,
  `data_de_nascimento` INT NOT NULL,
  `cep` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(45) NOT NULL,
  `Servico_de_geolocalizacao_id_geolocalizacao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  INDEX `fk_Usuario_Servico_de_geolocalizacao_idx` (`Servico_de_geolocalizacao_id_geolocalizacao` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_Servico_de_geolocalizacao`
    FOREIGN KEY (`Servico_de_geolocalizacao_id_geolocalizacao`)
    REFERENCES `mydb`.`Servico_de_geolocalizacao` (`id_geolocalizacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Comparativo_preco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Comparativo_preco` (
  `id_comparativo` INT NOT NULL,
  `produto` VARCHAR(20) NOT NULL,
  `preco` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_comparativo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Preco_de_produtos_has_Comparativo_preco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Preco_de_produtos_has_Comparativo_preco` (
  `Preco_de_produtos_idpreco` INT NOT NULL,
  `Comparativo_preco_id_comparativo` INT NOT NULL,
  PRIMARY KEY (`Preco_de_produtos_idpreco`, `Comparativo_preco_id_comparativo`),
  INDEX `fk_Preco_de_produtos_has_Comparativo_preco_Comparativo_prec_idx` (`Comparativo_preco_id_comparativo` ASC) VISIBLE,
  INDEX `fk_Preco_de_produtos_has_Comparativo_preco_Preco_de_produto_idx` (`Preco_de_produtos_idpreco` ASC) VISIBLE,
  CONSTRAINT `fk_Preco_de_produtos_has_Comparativo_preco_Preco_de_produtos1`
    FOREIGN KEY (`Preco_de_produtos_idpreco`)
    REFERENCES `mydb`.`Preco_de_produtos` (`idpreco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Preco_de_produtos_has_Comparativo_preco_Comparativo_preco1`
    FOREIGN KEY (`Comparativo_preco_id_comparativo`)
    REFERENCES `mydb`.`Comparativo_preco` (`id_comparativo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Comparativo_preco_has_Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Comparativo_preco_has_Usuario` (
  `Comparativo_preco_id_comparativo` INT NOT NULL,
  `Usuario_id_usuario` INT NOT NULL,
  PRIMARY KEY (`Comparativo_preco_id_comparativo`, `Usuario_id_usuario`),
  INDEX `fk_Comparativo_preco_has_Usuario_Usuario1_idx` (`Usuario_id_usuario` ASC) VISIBLE,
  INDEX `fk_Comparativo_preco_has_Usuario_Comparativo_preco1_idx` (`Comparativo_preco_id_comparativo` ASC) VISIBLE,
  CONSTRAINT `fk_Comparativo_preco_has_Usuario_Comparativo_preco1`
    FOREIGN KEY (`Comparativo_preco_id_comparativo`)
    REFERENCES `mydb`.`Comparativo_preco` (`id_comparativo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comparativo_preco_has_Usuario_Usuario1`
    FOREIGN KEY (`Usuario_id_usuario`)
    REFERENCES `mydb`.`Usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuario_has_Produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuario_has_Produtos` (
  `Usuario_id_usuario` INT NOT NULL,
  `Produtos_id_produto` INT NOT NULL,
  `Produtos_Preco_de_produtos_idpreco` INT NOT NULL,
  PRIMARY KEY (`Usuario_id_usuario`, `Produtos_id_produto`, `Produtos_Preco_de_produtos_idpreco`),
  INDEX `fk_Usuario_has_Produtos_Produtos1_idx` (`Produtos_id_produto` ASC, `Produtos_Preco_de_produtos_idpreco` ASC) VISIBLE,
  INDEX `fk_Usuario_has_Produtos_Usuario1_idx` (`Usuario_id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Usuario_has_Produtos_Usuario1`
    FOREIGN KEY (`Usuario_id_usuario`)
    REFERENCES `mydb`.`Usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Produtos_Produtos1`
    FOREIGN KEY (`Produtos_id_produto` , `Produtos_Preco_de_produtos_idpreco`)
    REFERENCES `mydb`.`Produtos` (`id_produto` , `Preco_de_produtos_idpreco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produtos_has_Estabelecimentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produtos_has_Estabelecimentos` (
  `Produtos_id_produto` INT NOT NULL,
  `Produtos_Preco_de_produtos_idpreco` INT NOT NULL,
  `Estabelecimentos_id_estabelecimentos` INT NOT NULL,
  PRIMARY KEY (`Produtos_id_produto`, `Produtos_Preco_de_produtos_idpreco`, `Estabelecimentos_id_estabelecimentos`),
  INDEX `fk_Produtos_has_Estabelecimentos_Estabelecimentos1_idx` (`Estabelecimentos_id_estabelecimentos` ASC) VISIBLE,
  INDEX `fk_Produtos_has_Estabelecimentos_Produtos1_idx` (`Produtos_id_produto` ASC, `Produtos_Preco_de_produtos_idpreco` ASC) VISIBLE,
  CONSTRAINT `fk_Produtos_has_Estabelecimentos_Produtos1`
    FOREIGN KEY (`Produtos_id_produto` , `Produtos_Preco_de_produtos_idpreco`)
    REFERENCES `mydb`.`Produtos` (`id_produto` , `Preco_de_produtos_idpreco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produtos_has_Estabelecimentos_Estabelecimentos1`
    FOREIGN KEY (`Estabelecimentos_id_estabelecimentos`)
    REFERENCES `mydb`.`Estabelecimentos` (`id_estabelecimentos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
