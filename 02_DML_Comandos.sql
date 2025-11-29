-- -- ARQUIVO: 02_DML_Comandos.sql
-- Objetivo: Script com comandos INSERT para popular as tabelas (carga inicial de dados).
-- Dependência: Executar APÓS o 01_DDL_Barbearia_TheRightCut.sql

-- SELECIONA O BANCO DE DADOS
USE barbearia_therightcut;
SET foreign_key_checks = 1; -- Garante que as restrições de FKs estejam ativas

-- COMANDOS DE INSERÇÃO DE DADOS (INSERT)
-- Ordem: Tabelas-pai primeiro, tabelas-filhas depois

-- PERFIL ACESSO
INSERT INTO PERFIL_ACESSO (id_perfil, nome_perfil) VALUES
(1, 'Administrador'),
(2, 'Barbeiro');

-- CLIENTE
INSERT INTO CLIENTE (nome, cpf, telefone, email, data_cadastro) VALUES
('André Santos', '11122233344', '(11) 98765-4321', 'andré.santos@email.com', '2025-10-01'),
('Bruno Costa', '55566677788', '(11) 99887-7665', 'bruno.costa@email.com', '2025-10-05'),
('Carlos Pereira', '99988877766', '(11) 91234-5678', 'carlos.pereira@email.com', '2025-10-10');

-- SERVICO
INSERT INTO SERVICO (id_servico, nome_servico, descricao, valor, duracao) VALUES
(101, 'Corte Masculino', 'Corte com máquina e tesoura', 45.00, '00:40:00'),
(102, 'Barba Completa', 'Barba modelada com toalha quente', 35.00, '00:30:00'),
(103, 'Combo Corte + Barba', 'Corte com Barba com desconto', 70.00, '01:10:00');

-- PRODUTO
INSERT INTO PRODUTO (nome_produto, descricao, saldo_atual, preco_venda, ponto_pedido_minimo) VALUES
('Pomada Modeladora Strong', 'Pomada de alta fixação, 150g.', 50, 49.90, 10),
('Shampoo Anticaspa 300ml', 'Shampoo para tratamento de caspa.', 20, 30.50, 5),
('Gel Pós Barba Refrescante', 'Gel para acalmar a pele após barbear.', 15, 30.00, 3);

-- BARBEIRO
INSERT INTO BARBEIRO (id_perfil, nome, cpf, telefone, data_contratacao) VALUES
(2, 'João Barbeiro', '12345678901', '(11) 977777-6666', '2024-01-15'),
(2, 'Pedro Navalha', '98765432109', '(11) 96666-5555', '2023-08-20'),
(1, 'Gerente Geral', '11223344556', '(11) 95555-4444', '2022-05-01');

-- Variáveis para referências de FKs
SET @id_cliente_andre = (SELECT id_cliente FROM CLIENTE WHERE nome = 'André Santos');
SET @id_cliente_bruno = (SELECT id_cliente FROM CLIENTE WHERE cpf = '55566677788');
SET @id_barbeiro_joao = (SELECT id_barbeiro FROM BARBEIRO WHERE nome = 'João Barbeiro');
SET @id_barbeiro_pedro = (SELECT id_barbeiro FROM BARBEIRO WHERE nome = 'Pedro Navalha');
SET @id_servico_corte = 101;
SET @id_servico_combo = 103;
SET @id_produto_pomada = (SELECT id_produto FROM PRODUTO WHERE nome_produto = 'Pomada Modeladora Strong');

-- AGENDAMENTO 
INSERT INTO AGENDAMENTO (id_cliente, id_barbeiro, id_servico, data_hora_inicio) VALUES
(@id_cliente_andre, @id_barbeiro_joao, @id_servico_corte, '2025-11-20 10:00:00'),
(@id_cliente_bruno, @id_barbeiro_pedro, @id_servico_combo, '2025-11-20 11:30:00'), 
(@id_cliente_andre, @id_barbeiro_joao, 102, '2025-11-25 14:00:00'); 

SET @id_agendamento_1 = (SELECT id_agendamento FROM AGENDAMENTO WHERE data_hora_inicio = '2025-11-20 10:00:00');
SET @id_agendamento_2 = (SELECT id_agendamento FROM AGENDAMENTO WHERE data_hora_inicio = '2025-11-20 11:30:00');
SET @id_agendamento_3 = (SELECT id_agendamento FROM AGENDAMENTO WHERE data_hora_inicio = '2025-11-25 14:00:00');

-- TRANSACAO 
INSERT INTO TRANSACAO (id_agendamento, data_hora_finalizacao, valor_total, metodo_pagamento) VALUES
(@id_agendamento_1, '2025-11-20 10:40:00', 45.00, 'Cartao Credito'),
(@id_agendamento_2, '2025-11-20 12:40:00', 119.90, 'PIX'),
(@id_agendamento_3, '2025-11-25 14:35:00', 35.00, 'Dinheiro');

SET @id_transacao_1 = (SELECT id_transacao FROM TRANSACAO WHERE id_agendamento = @id_agendamento_1);
SET @id_transacao_2 = (SELECT id_transacao FROM TRANSACAO WHERE id_agendamento = @id_agendamento_2);
SET @id_transacao_3 = (SELECT id_transacao FROM TRANSACAO WHERE id_agendamento = @id_agendamento_3);

-- PRODUTO_VENDA 
INSERT INTO PRODUTO_VENDA (id_produto, id_transacao, quantidade, preco_unitario_venda, subtotal) VALUES
(@id_produto_pomada, @id_transacao_2, 1, 49.90, 49.90);

-- HISTORICO_SERVICO
INSERT INTO HISTORICO_SERVICO (id_transacao, id_agendamento, id_cliente, id_barbeiro, id_servico, data_servico, descricao_servico_realizado, anotacoes_barbeiro) VALUES
(@id_transacao_1, @id_agendamento_1, @id_cliente_andre, @id_barbeiro_joao, @id_servico_corte, '2025-11-20', 'Corte Undercut', 'Cliente prefere máquina 3 nas laterais.'),
(@id_transacao_2, @id_agendamento_2, @id_cliente_bruno, @id_barbeiro_pedro, @id_servico_combo, '2025-11-20', 'Corte e barba completa, com pigmentação na barba.', 'Cliente comprou pomada. Agendar retorno em 20 dias.'),
(@id_transacao_3, @id_agendamento_3, @id_cliente_andre, @id_barbeiro_joao, @id_servico_barba, '2025-11-25', 'Barba simples, aparada. Aparência profissional.', 'Agendamento rápido. Gostou do resultado.');