-- ARQUIVO: 03_DQL_Consultas.sql
-- Objetivo: Script com 5 consultas SELECT para relatórios gerenciais,
-- demonstrando o uso de JOIN, WHERE, ORDER BY, LIMIT, SUM e GROUP BY.
-- Dependência: Executar APÓS o 01_DDL (barbearia_therightcut.sql) e o 02_DML (comandos.sql)


-- 1. SELECIONA O BANCO DE DADOS
USE barbearia_therightcut;

-- 2. CONSULTAS SELECT (DQL)


-- 2.1. Consulta 1: Histórico de um Serviço Específico por Barbeiro (JOIN + WHERE + ORDER BY)
-- Requisito: Exibir todas as vezes que o barbeiro 'João Barbeiro' realizou o serviço 'Barba Completa'.
SELECT '--- 2.1. Historico de "Barba Completa" por João Barbeiro ---' AS INFO;
SELECT
    C.nome AS Cliente,
    HS.data_servico AS Data,
    HS.descricao_servico_realizado AS Descricao_Realizada
FROM HISTORICO_SERVICO HS
JOIN CLIENTE C ON HS.id_cliente = C.id_cliente
JOIN BARBEIRO B ON HS.id_barbeiro = B.id_barbeiro
JOIN SERVICO S ON HS.id_servico = S.id_servico
WHERE B.nome = 'João Barbeiro' AND S.nome_servico = 'Barba Completa' 
ORDER BY HS.data_servico DESC; -- Uso de ORDER BY

-- 2.2. Consulta 2: Faturamento Total por Método de Pagamento (SUM + GROUP BY) 
-- Requisito: Calcular o total arrecadado, agrupando por tipo de pagamento.
SELECT '--- 2.2. Faturamento Total Agregado por Método de Pagamento (SUM, GROUP BY) ---' AS INFO;
SELECT
    metodo_pagamento AS Metodo,
    SUM(valor_total) AS Total_Faturado -- Uso de SUM (agregação)
FROM TRANSACAO
GROUP BY metodo_pagamento -- Uso de GROUP BY
ORDER BY Total_Faturado DESC;

-- 2.3. Consulta 3: Clientes Cadastrados Após uma Data (WHERE + ORDER BY)
-- Requisito: Listar clientes cadastrados a partir de '2025-10-05', ordenado pelo nome.
SELECT '--- 2.3. Clientes Cadastrados Após 2025-10-05 (WHERE, ORDER BY) ---' AS INFO;
SELECT
    nome AS Nome_Cliente,
    data_cadastro AS Data_Cadastro,
    telefone
FROM CLIENTE
WHERE data_cadastro > '2025-10-05' 
ORDER BY nome ASC;

-- 2.4. Consulta 4: Detalhe Completo dos Agendamentos (Múltiplos JOINs)
-- Requisito: Exibir a data e hora do agendamento, o cliente, o barbeiro e o serviço correspondente.
SELECT '--- 2.4. Detalhe Completo dos Agendamentos (Multiplos JOINs) ---' AS INFO;
SELECT
    A.data_hora_inicio AS Data_Hora,
    C.nome AS Cliente,
    B.nome AS Barbeiro,
    S.nome_servico AS Servico
FROM AGENDAMENTO A
JOIN CLIENTE C ON A.id_cliente = C.id_cliente
JOIN BARBEIRO B ON A.id_barbeiro = B.id_barbeiro 
JOIN SERVICO S ON A.id_servico = S.id_servico 
ORDER BY A.data_hora_inicio ASC;

-- --- 2.5. Consulta 5: Top 2 Serviços Mais Caros (ORDER BY + LIMIT) ---
-- Requisito: Encontrar os 2 serviços com o valor mais alto.
SELECT '--- 2.5. Top 2 Serviços Mais Caros (ORDER BY, LIMIT) ---' AS INFO;
SELECT
    nome_servico AS Servico,
    valor AS Preco
FROM SERVICO
ORDER BY valor DESC 
LIMIT 2; 