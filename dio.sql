CREATE SCHEMA IF NOT EXISTS tbl_ordemservico DEFAULT CHARACTER SET latin1 ;
USE tbl_ordemservico ;

CREATE TABLE IF NOT EXISTS cliente (
  id_cliente INT(11) NOT NULL AUTO_INCREMENT,
  nome VARCHAR(60) NOT NULL,
  cpf_ou_cnpj VARCHAR(14) NOT NULL,
  endereco VARCHAR(90) NOT NULL,
  PRIMARY KEY (id_cliente),
  UNIQUE INDEX cpf_ou_cnpj (cpf_ou_cnpj ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS estoque (
  id_estoque INT(11) NOT NULL AUTO_INCREMENT,
  localizacao VARCHAR(45) NOT NULL,
  PRIMARY KEY (id_estoque))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS produto (
  id_produto INT(11) NOT NULL AUTO_INCREMENT,
  categoria VARCHAR(45) NOT NULL,
  descricao VARCHAR(45) NULL DEFAULT NULL,
  valor INT(11) NOT NULL,
  PRIMARY KEY (id_produto))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS estoque_do_produto (
  id_estoque INT(11) NOT NULL AUTO_INCREMENT,
  id_produto INT(11) NOT NULL,
  quantidade INT(11) NOT NULL,
  PRIMARY KEY (id_estoque, id_produto),
  INDEX fk_estoque_has_produto_produto1_idx (id_produto ASC),
  INDEX fk_estoque_has_produto_estoque1_idx (id_estoque ASC),
  CONSTRAINT fk_estoque_has_produto_estoque1
    FOREIGN KEY (id_estoque)
    REFERENCES estoque (id_estoque)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_estoque_has_produto_produto1
    FOREIGN KEY (id_produto)
    REFERENCES produto (id_produto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS fornecedor (
  id_fornecedor INT(11) NOT NULL AUTO_INCREMENT,
  razao_social VARCHAR(45) NOT NULL,
  nome_popular VARCHAR(30) NULL DEFAULT NULL,
  cnpj VARCHAR(14) NOT NULL,
  endereco VARCHAR(90) NULL DEFAULT NULL,
  PRIMARY KEY (id_fornecedor),
  UNIQUE INDEX cnpj (cnpj ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS pedido (
  id_pedido INT(11) NOT NULL AUTO_INCREMENT,
  status VARCHAR(12) NOT NULL,
  descricao VARCHAR(45) NULL DEFAULT NULL,
  id_cliente INT(11) NOT NULL,
  frete INT(11) NOT NULL,
  endereco VARCHAR(90) NOT NULL,
  cod_rastreio VARCHAR(15) NULL DEFAULT NULL,
  pago_totalmente TINYINT(4) NOT NULL,
  PRIMARY KEY (id_pedido),
  UNIQUE INDEX endereco_UNIQUE (endereco ASC),
  UNIQUE INDEX cod_rastreio_UNIQUE (cod_rastreio ASC),
  INDEX fk_pedido_cliente_idx (id_cliente ASC),
  CONSTRAINT fk_pedido_cliente
    FOREIGN KEY (id_cliente)
    REFERENCES cliente (id_cliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS pagamento (
  id_pagamento INT(11) NOT NULL AUTO_INCREMENT,
  id_pedido INT(11) NOT NULL,
  tipo_pagamento VARCHAR(10) NOT NULL,
  num_parcela INT(11) NULL,
  valor INT(11) NOT NULL,
  vencimento DATE NOT NULL,
  pago_em DATE NULL DEFAULT NULL,
  PRIMARY KEY (id_pagamento),
  INDEX fk_pagamento_pedido1_idx (id_pedido ASC),
  CONSTRAINT fk_pagamento_pedido1
    FOREIGN KEY (id_pedido)
    REFERENCES pedido (id_pedido)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS pedido_do_produto (
  id_pedido INT(11) NOT NULL AUTO_INCREMENT,
  id_produto INT(11) NOT NULL,
  quantidade INT(11) NOT NULL,
  PRIMARY KEY (id_pedido, id_produto),
  INDEX fk_pedido_has_produto_produto1_idx (id_produto ASC),
  INDEX fk_pedido_has_produto_pedido1_idx (id_pedido ASC),
  CONSTRAINT fk_pedido_has_produto_pedido1
    FOREIGN KEY (id_pedido)
    REFERENCES pedido (id_pedido)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_pedido_has_produto_produto1
    FOREIGN KEY (id_produto)
    REFERENCES produto (id_produto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS produto_do_fornecedor (
  id_produto INT(11) NOT NULL AUTO_INCREMENT,
  id_fornecedor INT(11) NOT NULL,
  PRIMARY KEY (id_produto, id_fornecedor),
  INDEX fk_has_fornecedor1_idx (id_fornecedor ASC),
  INDEX fk_has_produto1_idx (id_produto ASC),
  CONSTRAINT fk_has_fornecedor1
    FOREIGN KEY (id_fornecedor)
    REFERENCES fornecedor (id_fornecedor)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_has_produto1
    FOREIGN KEY (id_produto)
    REFERENCES produto (id_produto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS terceiro (
  id_terceiro INT(11) NOT NULL AUTO_INCREMENT,
  razao_social VARCHAR(45) NOT NULL,
  cnpj VARCHAR(14) NOT NULL,
  endereco VARCHAR(90) NULL DEFAULT NULL,
  PRIMARY KEY (id_terceiro),
  UNIQUE INDEX cnpj (cnpj ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;

CREATE TABLE IF NOT EXISTS produto_do_terceiro (
  produto_id_produto INT(11) NOT NULL,
  terceiro_id_terceiro INT(11) NOT NULL,
  quantidade INT NOT NULL,
  PRIMARY KEY (produto_id_produto, terceiro_id_terceiro),
  INDEX fk_produto_has_terceiro_terceiro1_idx (terceiro_id_terceiro ASC),
  INDEX fk_produto_has_terceiro_produto1_idx (produto_id_produto ASC),
  CONSTRAINT fk_produto_has_terceiro_produto1
    FOREIGN KEY (produto_id_produto)
    REFERENCES produto (id_produto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_produto_has_terceiro_terceiro1
    FOREIGN KEY (terceiro_id_terceiro)
    REFERENCES terceiro (id_terceiro)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


# INSERTS TESTE
INSERT INTO cliente (nome, cpf_ou_cnpj, endereco) VALUES
 ('João', '44455566677', 'Rua Morais, 93 - Bauru, Santos'),
 ('RobertoTec', '33111333000101', 'Rua Treze, 13 - Casqueiro, Cubatao'),
 ('Maria do Carmo', '78945612345', 'Rua Dalmatas, 101 - Bauru, Santos'),
 ('Coca-Mola', '88777222000105', 'Av Teclado, 44 - Bauru, Santos')
;

INSERT INTO estoque (localizacao) VALUES
 ('Santos'), ('Bertioga'), ('Cubatão')
;

INSERT INTO fornecedor (razao_social, nome_popular, cnpj, endereco) VALUES
 ('Pao-De-Forma Ltda', 'Paozinho de Forma', '11222111000101', 'Av Eng Luiz, 45 - Cartola, São Paulo'),
 ('Rubinho SA', 'Rubinho Coxinhas', '99222111000101', 'Rua do Pulo, 3 - Cartola, Jundiaí'),
 ('Treze Pasteis', 'Treze Pasteis', '44222111000101', 'Av Zebra, 562 - Potiguar, Praia Grande')
;

INSERT INTO produto (categoria, descricao, valor) VALUES
 ('Alimentos', 'Massa de pastel 1kg', 10.5),
 ('Alimentos', 'Arroz Pardo 1kg', 4.3),
 ('Alimentos', 'Pão de Forma 400g', 3.4)
;

INSERT INTO terceiro (razao_social, cnpj, endereco) VALUES
 ('Zero Dez Alimentos','44555777000155','Rua V, 45 - Centro, Rio de Janeiro'),
 ('Maria Lanches','88999444000211','Rua X, 56 - Centro, Santos')
;

INSERT INTO estoque_do_produto (id_estoque, id_produto, quantidade) VALUES
 (1, 1, 10),
 (1, 2, 4),
 (2, 1, 63),
 (2, 2, 5),
 (3, 3, 20)
;

INSERT INTO produto_do_fornecedor (id_produto, id_fornecedor) VALUES
 (1, 1),
 (1, 2),
 (2, 1),
 (2, 2),
 (3, 3)
;

INSERT INTO produto_do_terceiro VALUES
 (1,1,65),
 (2,1,53),
 (2,2,23)
;

INSERT INTO pedido VALUES
 (1,'Entregue',NULL,1,45,'Rua X, 23','123',1),
 (2,'Em andamento','Alimentos gerais',1,34,'Rua X, 32','124',0)
;

INSERT INTO pagamento VALUES
 (1,1,'Vista',NULL,300,'2022-09-01','2022-09-01'),
 (2,2,'Parcelado',1,200,'2022-09-30',NULL),
 (3,2,'Parcelado',2,200,'2022-10-30',NULL)
;

INSERT INTO pedido_do_produto VALUES
 (1,1,3),
 (2,1,4),
 (2,2,8)
;

# SELECTS
