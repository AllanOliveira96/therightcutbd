#  Sistema de Gerenciamento e Agendamento para Barbearia (The Right Cut)

**Status:** **Scripts SQL Finalizados e Validados**

## Descrição do Projeto (Mini-Mundo)

Este repositório contém os scripts SQL completos para a criação e manipulação do banco de dados relacional da Barbearia "The Right Cut".

O sistema é projetado para gerenciar todas as operações essenciais do negócio, incluindo:
* Agendamento de serviços.
* Cadastro de clientes e barbeiros.
* Controle básico de estoque de produtos.
* Registro do histórico detalhado de serviços.

O objetivo principal é otimizar a agenda, evitar conflitos de horários e fornecer dados gerenciais robustos sobre faturamento e desempenho.

---

## Requisitos e Objetivos Cumpridos

O projeto atende aos requisitos de **Criação e Manipulação de Dados com SQL**, conforme as seguintes taxonomias:

### Taxonomia de Bloom (Aplicar & Criar)
* **Aplicação:** Execução de comandos SQL de manipulação (`INSERT`, `UPDATE`, `DELETE`) em cenários reais, respeitando as regras de integridade.
* **Criação:** Desenvolvimento de um conjunto de 4 scripts SQL completos e estruturados, resultando em um banco de dados funcional.

### Entregáveis Imprescindíveis (Conformidade)
| Script | Requisito Cumprido | Cláusulas Utilizadas |
| :--- | :--- | :--- |
| `02_DML_Comandos.sql` | Povoamento das tabelas (`INSERT`). | `INSERT INTO`, `SET @Variáveis` |
| `03_DQL_Consultas.sql` | 2 a 5 consultas avançadas. | `SELECT`, `JOIN`, `WHERE`, `GROUP BY`, `SUM`, `ORDER BY`, `LIMIT` |
| `04_DML_Manipulacao.sql` | 3+ `UPDATE` e 3+ `DELETE` condicionais. | `UPDATE...WHERE`, `DELETE...WHERE`, `SET foreign_key_checks` |

---

## Estrutura do Repositório

Os scripts devem ser executados **em ordem numérica** para garantir a correta criação da estrutura e o carregamento dos dados:

| Ordem | Arquivo | Conteúdo |
| :---: | :--- | :--- |
| **01** | `01_DDL_Barbearia_TheRightCut.sql` | **DDL:** Criação do Database e todas as Tabelas (PKs, FKs). |
| **02** | `02_DML_Comandos.sql` | **DML:** Inserção de dados iniciais (Clientes, Barbeiros, Serviços, etc.). |
| **03** | `03_DQL_Consultas.sql` | **DQL:** 5 consultas complexas para relatórios gerenciais. |
| **04** | `04_DML_Manipulacao.sql` | **DML:** Atualizações e Exclusões condicionais de dados. |

---

## Instruções de Execução

Siga os passos abaixo no **MySQL Workbench** ou ambiente similar para recriar e popular o banco de dados:

1.  **Executar Script 01 (DDL):**
    * Abra o arquivo `01_DDL_Barbearia_TheRightCut.sql`.
    * Execute o script integralmente para criar o banco de dados (`barbearia_therightcut`) e todas as tabelas.

2.  **Executar Script 02 (DML - INSERT):**
    * Abra o arquivo `02_DML_Comandos.sql`.
    * Execute o script integralmente para popular as tabelas com os dados iniciais.

3.  **Executar Script 03 (DQL - SELECT):**
    * Abra o arquivo `03_DQL_Consultas.sql`.
    * Execute o script para visualizar os 5 relatórios gerenciais criados.

4.  **Executar Script 04 (DML - MANIPULAÇÃO):**
    * Abra o arquivo `04_DML_Manipulacao.sql`.
    * **Aviso:** Este script contém a instrução `SET foreign_key_checks = 0;` para evitar erros de restrição de Chave Estrangeira (FK) durante as operações de `DELETE`. Execute-o integralmente.
    * Ele irá demonstrar as atualizações (`UPDATE`) e exclusões (`DELETE`) de dados no sistema.
