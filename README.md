# Modelo Logico View

## Neste conjunto de exercícios, vamos praticar nossos conhecimentos sobre views e datas em MySQL

### 1- Crie uma view que mostra todos os produtos e suas respectivas marcas;
```SQL
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
```
![image](https://github.com/AndreFelipefer/BD_VIEW/assets/129207232/1686fc83-c7e6-4d26-b11f-196ebe59b124)

### 2- Crie uma view que mostra todos os produtos e seus respectivos fornecedores;
```SQL
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
```
![image](https://github.com/AndreFelipefer/BD_VIEW/assets/129207232/0f268a3f-7b4a-42ed-a9d5-2d2b2150e182)

### 3- Crie uma view que mostra todos os produtos e seus respectivos fornecedores e marcas;
```SQL
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

```
![image](https://github.com/AndreFelipefer/BD_VIEW/assets/129207232/b4f60a71-8586-469a-9fe1-9dfafe181f73)

### 4- Crie uma view que mostra todos os produtos com estoque abaixo do mínimo;

```SQL
create view Tab_Abaixo_media as 
select * from produtos where prd_qtd_estoque < prd_estoque_mim;
```
![image](https://github.com/AndreFelipefer/BD_VIEW/assets/129207232/e040f0c8-7199-40af-8e56-402e0a4848bd)

### 5- Adicione o campo data de validade. Insira novos produtos com essa informação;
```SQL
alter table produtos add prd_data_validade date;
```
```SQL
INSERT INTO produtos (prd_nome, prd_qtd_estoque, prd_estoque_mim, prd_data_fabricacao, prd_perecivel, prd_valor, prd_marca_id, prd_data_validade) 
VALUES ("Olympikus TUB", 3, 4, NOW(), 0, 299.90, 3, '2024-10-13');
```
![image](https://github.com/AndreFelipefer/BD_VIEW/assets/129207232/c1cde977-3ae4-4628-9443-510f6b5a0433)

### 6- Crie uma view que mostra todos os produtos e suas respectivas marcas com validade vencida;
```SQL
CREATE OR REPLACE VIEW Produtos_Data_Validade_Vencida AS
SELECT
    prd_id,
    prd_nome,
    prd_data_validade
FROM produtos
WHERE prd_data_validade < CURDATE();
```
![image](https://github.com/AndreFelipefer/BD_VIEW/assets/129207232/9b582b68-da69-4e36-bf08-f0b3b7abd1d9)

### 7- Selecionar os produtos com preço acima da média.
```SQL
SELECT *
FROM produtos
WHERE prd_valor > (SELECT AVG(prd_valor) FROM produtos);
```
![image](https://github.com/AndreFelipefer/BD_VIEW/assets/129207232/840aacf7-6e27-49d6-9dc4-a0075f87098e)

========================================================================
![image](https://github.com/AndreFelipefer/BD_VIEW/assets/129207232/61991604-88cf-40ad-9aa3-e875b9148644)



