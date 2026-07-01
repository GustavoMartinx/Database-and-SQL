DROP DATABASE ATELIE;
CREATE DATABASE ATELIE;
USE ATELIE;


CREATE TABLE FUNCIONARIOS(
	cpf INTEGER,
    nome VARCHAR(50),
    endereco VARCHAR(100),
    PRIMARY KEY(cpf)
);

CREATE TABLE ATENDENTES(
	cpf_func INTEGER,
    telefone INTEGER,
    nome_usuario VARCHAR(30),
    senha VARCHAR(50),
    PRIMARY KEY(cpf_func),
    FOREIGN KEY(cpf_func) REFERENCES FUNCIONARIOS(cpf)
);

CREATE TABLE ALFAIATES(
	telefone INTEGER,
    hora_extra INTEGER,
    comissão INTEGER,
    cpf_func INTEGER,
    PRIMARY KEY(cpf_func),
    FOREIGN KEY(cpf_func) REFERENCES FUNCIONARIOS(cpf)
);

CREATE TABLE GERENTES(
	telefone INTEGER,
    nome_usuario VARCHAR(30),
    senha VARCHAR(50),
    cpf_func INTEGER,
    PRIMARY KEY(cpf_func),
    FOREIGN KEY(cpf_func) REFERENCES FUNCIONARIOS(cpf)
);

CREATE TABLE CLIENTES(
	cpf INTEGER,
    nome VARCHAR(40),
    telefone INTEGER,
    endereco VARCHAR(100),
    PRIMARY KEY(cpf)
);

CREATE TABLE PEDIDOS(
	nro INTEGER,
    valor REAL,
    forma_pagamento VARCHAR(30),
    qtde_pecas INTEGER,
    cpf_cliente INTEGER NOT NULL,
    cpf_atendente INTEGER NOT NULL,
    PRIMARY KEY(nro),
    FOREIGN KEY(cpf_cliente) REFERENCES CLIENTES(cpf),
    FOREIGN KEY(cpf_atendente) REFERENCES ATENDENTES(cpf_func)
);

CREATE TABLE ROUPAS(
	id INTEGER,
    tamanho CHAR,
    tipo_roupa VARCHAR(30),
    descricao_ajustes VARCHAR(300),
    descricao_tecido VARCHAR(300),
    PRIMARY KEY(id)
);

CREATE TABLE CONTAS(
	nro INTEGER,
    tipo VARCHAR(30),
    valor INTEGER,
    pago VARCHAR(3),
    data_vencimento VARCHAR(100),
    cpf_gerente INTEGER NOT NULL,
    PRIMARY KEY(nro),
    FOREIGN KEY(cpf_gerente) REFERENCES GERENTES(cpf_func)
);

CREATE TABLE SALARIOS(
	cpf_funcionario INTEGER,
    valor REAL,
    mes VARCHAR(15),
    pago VARCHAR(3),
    cpf_gerente INTEGER NOT NULL,
    PRIMARY KEY(cpf_funcionario),
    FOREIGN KEY(cpf_gerente) REFERENCES GERENTES(cpf_func)
);

CREATE TABLE PEDIDO_TEM_ROUPA(
	id_roupa INTEGER,
	nro_pedido INTEGER,
    PRIMARY KEY(id_roupa, nro_pedido),
    FOREIGN KEY(id_roupa) REFERENCES ROUPAS(id),
    FOREIGN KEY(nro_pedido) REFERENCES PEDIDOS(nro)
);

CREATE TABLE FUNCIONARIOS_RECEBEM_SALARIOS(
	cpf_func INTEGER,
    cpf_func_salario INTEGER,
    PRIMARY KEY(cpf_func, cpf_func_salario),
    FOREIGN KEY(cpf_func) REFERENCES FUNCIONARIOS(cpf),
    FOREIGN KEY(cpf_func_salario) REFERENCES SALARIOS(cpf_funcionario)
);