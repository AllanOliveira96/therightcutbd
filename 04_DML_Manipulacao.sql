-- ARQUIVO: 04_DML_Manipulacao.sql
-- Objetivo: 3x UPDATE e 3x DELETE, usando CHAVES PRIMÁRIAS (PK) no WHERE.
-- Dependência: Executar APÓS o 01_DDL_Barbearia_TheRightCut.sql e o 02_DML_Comandos.sql

USE barbearia_therightcut;

SET foreign_key_checks = 0;

-- 1. BUSCA DE IDs (Necessário para o Safe Update Mode)

-- Busca os IDs (PKs) usando atributos não-chave, para usá-los nas manipulações seguintes
SET @id_servico_barba = (SELECT id_servico FROM SERVICO WHERE nome_servico = 'Barba Completa');
SET @id_produto_pomada = (SELECT id_produto FROM PRODUTO WHERE nome_produto = 'Pomada Modeladora Strong');
SET @id_cliente_carlos = (SELECT id_cliente FROM CLIENTE WHERE nome = 'Carlos Pereira');
SET @id_agendamento_futuro = (SELECT id_agendamento FROM AGENDAMENTO WHERE data_hora_inicio = '2025-11-25 14:00:00');
SET @id_barbeiro_gerente = (SELECT id_barbeiro FROM BARBEIRO WHERE nome = 'Gerente Geral');


-- 2. COMANDOS DE ATUALIZAÇÃO (UPDATE usando PK no WHERE)


-- 2.1. Reajuste de Valor de Serviço
UPDATE SERVICO
SET valor = 40.00,
    descricao = 'Barba modelada com toalha quente e finalização premium.'
WHERE id_servico = @id_servico_barba; -- USANDO PK

-- 2.2. Simular Reposição de Estoque
UPDATE PRODUTO
SET saldo_atual = saldo_atual + 50
WHERE id_produto = @id_produto_pomada; -- USANDO PK

-- 2.3. Mudar Contato de Cliente
UPDATE CLIENTE
SET telefone = '(11) 99191-8282',
    email = 'carlos.pereira.novo@email.com'
WHERE id_cliente = @id_cliente_carlos; -- USANDO PK


-- 3. COMANDOS DE EXCLUSÃO (DELETE usando PK no WHERE)

-- 3.1. Excluir Agendamento Cancelado
DELETE FROM AGENDAMENTO
WHERE id_agendamento = @id_agendamento_futuro; -- USANDO PK

-- 3.2. Excluir Cliente Inativo
DELETE FROM CLIENTE
WHERE id_cliente = @id_cliente_carlos; -- USANDO PK

-- 3.3. Remover Barbeiro/Gerente
DELETE FROM BARBEIRO
WHERE id_barbeiro = @id_barbeiro_gerente; -- USANDO PK

SET foreign_key_checks = 1;

-- 4. VERIFICAÇÃO (OPCIONAL)

SELECT '--- Verificação de Dados Alterados/Removidos ---' AS INFO;
SELECT nome, telefone, email FROM CLIENTE;
SELECT nome_servico, valor, descricao FROM SERVICO;