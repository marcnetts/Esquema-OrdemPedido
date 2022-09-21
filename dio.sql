CREATE SCHEMA IF NOT EXISTS `diodb` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `diodb`.`cliente` (
  `id_cliente` INT(11) NOT NULL,
  `nome` VARCHAR(60) NOT NULL,
  `cpf_ou_cnpj` VARCHAR(14) NOT NULL,
  `endereco` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`id_cliente`)
);

CREATE TABLE IF NOT EXISTS `diodb`.`estoque` (
  `id_estoque` INT(11) NOT NULL,
  `local` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_estoque`)
);

CREATE TABLE IF NOT EXISTS `diodb`.`fornecedor` (
  `id_fornecedor` INT(11) NOT NULL,
  `razao_social` VARCHAR(45) NOT NULL,
  `nome_popular` VARCHAR(30) NULL DEFAULT NULL,
  `cnpj` VARCHAR(14) NOT NULL,
  `endereco` VARCHAR(90) NULL,
  PRIMARY KEY (`id_fornecedor`)
);

CREATE TABLE IF NOT EXISTS `diodb`.`pedido` (
  `id_pedido` INT(11) NOT NULL,
  `status` VARCHAR(12) NOT NULL,
  `descricao` VARCHAR(45) NULL DEFAULT NULL,
  `id_cliente` INT(11) NOT NULL,
  `frete` INT NOT NULL,
  `endereco` VARCHAR(90) NOT NULL,
  `cod_rastreio` VARCHAR(15) NULL,
  `pago_totalmente` TINYINT NOT NULL,
  PRIMARY KEY (`id_pedido`),
  INDEX `fk_pedido_cliente_idx` (`id_cliente` ASC),
  UNIQUE INDEX `endereco_UNIQUE` (`endereco` ASC),
  UNIQUE INDEX `cod_rastreio_UNIQUE` (`cod_rastreio` ASC),
  CONSTRAINT `fk_pedido_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `diodb`.`cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `diodb`.`pagamento` (
  `id_pagamento` INT(11) NOT NULL,
  `id_pedido` INT(11) NOT NULL,
  `tipo_pagamento` VARCHAR(10) NOT NULL,
  `num_parcela` INT NOT NULL,
  `valor` INT NOT NULL,
  `vencimento` DATE NOT NULL,
  `pago_em` DATE NULL,
  PRIMARY KEY (`id_pagamento`),
  INDEX `fk_pagamento_pedido1_idx` (`id_pedido` ASC),
  CONSTRAINT `fk_pagamento_pedido1`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `diodb`.`pedido` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `diodb`.`produto` (
  `id_produto` INT(11) NOT NULL,
  `categoria` VARCHAR(45) NOT NULL,
  `descricao` VARCHAR(45) NULL DEFAULT NULL,
  `valor` INT(11) NOT NULL,
  PRIMARY KEY (`id_produto`)
);

CREATE TABLE IF NOT EXISTS `diodb`.`pedido_has_produto` (
  `id_pedido` INT(11) NOT NULL,
  `id_produto` INT(11) NOT NULL,
  `quantidade` INT NOT NULL,
  PRIMARY KEY (`id_pedido`, `id_produto`),
  INDEX `fk_pedido_has_produto_produto1_idx` (`id_produto` ASC),
  INDEX `fk_pedido_has_produto_pedido1_idx` (`id_pedido` ASC),
  CONSTRAINT `fk_pedido_has_produto_pedido1`
    FOREIGN KEY (`id_pedido`)
    REFERENCES `diodb`.`pedido` (`id_pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_has_produto_produto1`
    FOREIGN KEY (`id_produto`)
    REFERENCES `diodb`.`produto` (`id_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `diodb`.`estoque_has_produto` (
  `id_estoque` INT(11) NOT NULL,
  `id_produto` INT(11) NOT NULL,
  `quantidade` INT NOT NULL,
  PRIMARY KEY (`id_estoque`, `id_produto`),
  INDEX `fk_estoque_has_produto_produto1_idx` (`id_produto` ASC),
  INDEX `fk_estoque_has_produto_estoque1_idx` (`id_estoque` ASC),
  CONSTRAINT `fk_estoque_has_produto_estoque1`
    FOREIGN KEY (`id_estoque`)
    REFERENCES `diodb`.`estoque` (`id_estoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estoque_has_produto_produto1`
    FOREIGN KEY (`id_produto`)
    REFERENCES `diodb`.`produto` (`id_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `diodb`.`produto_has_fornecedor` (
  `id_produto` INT(11) NOT NULL,
  `id_fornecedor` INT(11) NOT NULL,
  `quantidade` INT NOT NULL,
  PRIMARY KEY (`id_produto`, `id_fornecedor`),
  INDEX `fk_has_fornecedor1_idx` (`id_fornecedor` ASC),
  INDEX `fk_has_produto1_idx` (`id_produto` ASC),
  CONSTRAINT `fk_has_produto1`
    FOREIGN KEY (`id_produto`)
    REFERENCES `diodb`.`produto` (`id_produto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_has_fornecedor1`
    FOREIGN KEY (`id_fornecedor`)
    REFERENCES `diodb`.`fornecedor` (`id_fornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);
