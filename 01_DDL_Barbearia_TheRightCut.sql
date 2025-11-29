-- ARQUIVO: 01_DDL_Barbearia_TheRightCut.sql
-- Objetivo: Script de Definição de Dados (DDL) para criar o banco de dados e todas as tabelas.
-- Dependência: Deve ser o primeiro script a ser executado.

-- DROP (comando para testes)
DROP DATABASE IF EXISTS barbearia_therightcut; 

-- Criar Banco
CREATE DATABASE barbearia_therightcut;
USE barbearia_therightcut;

-- TABELA: PERFIL_ACESSO 
CREATE TABLE PERFIL_ACESSO (
	id_perfil INT NOT NULL PRIMARY KEY,
	nome_perfil VARCHAR(50) NOT NULL UNIQUE
);

-- TABELA: CLIENTE
CREATE TABLE CLIENTE (	
	id_cliente INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    telefone VARCHAR(18),
    email VARCHAR(50),
    data_cadastro DATE NOT NULL
);

-- TABELA: SERVICO
CREATE TABLE SERVICO (
	id_servico INT NOT NULL PRIMARY KEY,
    nome_servico VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    valor DECIMAL(10, 2) NOT NULL,
    duracao TIME NOT NULL
);

-- TABELA: PRODUTO
CREATE TABLE PRODUTO (
	id_produto INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    descricao VARCHAR(255),
    saldo_atual INT NOT NULL DEFAULT 0,
    preco_venda DECIMAL (10, 2) NOT NULL,
    ponto_pedido_minimo INT NOT NULL
);

-- TABELA: BARBEIRO
CREATE TABLE BARBEIRO (
	id_barbeiro INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_perfil INT NOT NULL,
    nome VARCHAR(80) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    telefone VARCHAR(18),
    data_contratacao DATE NOT NULL,
    FOREIGN KEY (id_perfil) REFERENCES PERFIL_ACESSO(id_perfil)
);

-- TABELA: AGENDAMENTO
CREATE TABLE AGENDAMENTO (
	id_agendamento INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_barbeiro INT NOT NULL, 
    id_servico INT NOT NULL,
    data_hora_inicio DATETIME NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_cliente),
    FOREIGN KEY (id_barbeiro) REFERENCES BARBEIRO (id_barbeiro),
    FOREIGN KEY (id_servico) REFERENCES SERVICO (id_servico)
);

-- TABELA: TRANSACAO
CREATE TABLE TRANSACAO (
	id_transacao INT NOT NULL PRIMARY KEY AUTO_INCREMENT, 
    id_agendamento INT NOT NULL UNIQUE,
    data_hora_finalizacao DATETIME NOT NULL,
    valor_total DECIMAL (10, 2) NOT NULL,
    metodo_pagamento VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_agendamento) REFERENCES AGENDAMENTO(id_agendamento)
);

-- TABELA: PRODUTO_VENDA
CREATE TABLE PRODUTO_VENDA (
	id_produto INT NOT NULL,
    id_transacao INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario_venda DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (id_produto, id_transacao),
    FOREIGN KEY (id_produto) REFERENCES PRODUTO(id_produto),
    FOREIGN KEY (id_transacao) REFERENCES TRANSACAO(id_transacao)
);

-- TABELA: HISTORICO_SERVICO
CREATE TABLE HISTORICO_SERVICO (
	id_historico INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_transacao INT NOT NULL,
    id_agendamento INT NOT NULL,
    id_cliente INT NOT NULL, 
    id_barbeiro INT NOT NULL,
    id_servico INT NOT NULL,
    data_servico DATE NOT NULL,
    descricao_servico_realizado VARCHAR(255),
    anotacoes_barbeiro TEXT,
    FOREIGN KEY (id_transacao) REFERENCES TRANSACAO(id_transacao),
    FOREIGN KEY (id_agendamento) REFERENCES AGENDAMENTO(id_agendamento),
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente),
    FOREIGN KEY (id_barbeiro) REFERENCES BARBEIRO(id_barbeiro),
    FOREIGN KEY (id_servico) REFERENCES SERVICO(id_servico)
);