-- Criação da Tabela virutla [Nome da tabela] 
create view Produtos_Marcas as 
-- seleciona quais campos eu quero de quais tabelas ex: produtos.prd_nome extrair nome da tabela produtos
select
	produtos.prd_nome as produto,  -- as cria a coluna dentro do view 
	marcas.marc_nome as	 marca
-- pega a tabela principal     
from produtos
-- uni a tabela marcas e on são as chaves estrangeiras da tabela  MARCAS e = Tabela produtos. 
join marcas on marcas.mrc_id = produtos.prd_marca_id ;

-- Criação da tabela virtual Produtos_Fornecedores
CREATE VIEW Produtos_Fornecedores AS 
-- Seleciona as informações necessárias, começando por especificar a tabela de origem
SELECT 
	-- Define os nomes das colunas na tabela virtual
	produtos.prd_nome AS produtos,
	fornecedor.frn_nome AS fornecedores 
-- Define a tabela principal da consulta
FROM produtos 	
	-- Realiza uma junção usando a chave estrangeira definida no modelo relacional
    -- A condição "ON" liga o ID na tabela estrangeira ao ID na tabela de produtos
JOIN produtos_has_fornecedor ON produtos_has_fornecedor.pf_prod_id = produtos.prd_id 
	-- Realiza uma segunda junção com a tabela fornecedor, usando a chave estrangeira
    -- A condição "ON" liga o segundo ID na chave estrangeira ao ID na tabela de fornecedor
JOIN fornecedor ON produtos_has_fornecedor.pf_forn_id = fornecedor.frn_id;

-- Criação da tabela virutal [nome tabela]
create view Produtos_Fornecedores_marcas as 
-- seleciona as informaçoes que preciso iniciando por qual tabela sera extraida as informações 
select 
	-- as cria a tabela dentro do view 
	produtos.prd_nome as produtos,
	fornecedor.frn_nome as fornecedores ,
	marcas.marc_nome as	 marca
    -- Pega a tabela principal 
from produtos 	
	-- Join sera a chave estrangeira criada do modelo relacional 
    -- on pega da tabela estrangeira o ID que ira ser conectado ao ID da tabela produtos
join produtos_has_fornecedor on produtos_has_fornecedor.pf_prod_id = produtos.prd_id 
	-- Join secundario da tabela fornecedor, On novamente pegando da chave estrangeira o segundo ID 
    -- que sera conectado a ID da tabela fornecedor
join fornecedor on produtos_has_fornecedor.pf_forn_id = fornecedor.frn_id
join marcas on marcas.mrc_id = produtos.prd_marca_id ;


create view Tab_Abaixo_media as 
select * from produtos where prd_qtd_estoque < prd_estoque_mim;

alter table produtos add prd_data_validade date;

INSERT INTO produtos (prd_nome, prd_qtd_estoque, prd_estoque_mim, prd_data_fabricacao, prd_perecivel, prd_valor, prd_marca_id, prd_data_validade) 
VALUES ("Olympikus TUB", 3, 4, NOW(), 0, 299.90, 3, '2024-10-13');

CREATE OR REPLACE VIEW Produtos_Data_Validade_Vencida AS
SELECT
    prd_id,
    prd_nome,
    prd_data_validade
FROM produtos
WHERE prd_data_validade < CURDATE();

SELECT *
FROM produtos
WHERE prd_valor > (SELECT AVG(prd_valor) FROM produtos);

