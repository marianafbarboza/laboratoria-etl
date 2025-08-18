# laboratoria-etl

# 1. Contexto e Objetivo da Análise

A loja Super Store enfrenta o desafio de lidar com grandes volumes de dados dispersos e não estruturados. Para enfrentar esse problema e impulsionar a tomada de decisões informadas, propõe-se a implementação de um robusto sistema ETL (Extract, Transform, Load) com tabelas de fatos e dimensões.
Este projeto concentra-se na criação de um sistema abrangente que permita extrair dados de diversas fontes, transformá-los conforme as necessidades específicas da Super Store e carregá-los de forma eficiente em um Data warehouse organizado. Além disso, objetiva-se aumentar a capacidade da Super Store de identificar padrões, tendências e oportunidades de mercado. 

O processo de ETL consiste basicamente em 3 etapas:
- Extração: durante esta fase, os dados são extraídos de uma ou mais fontes de dados, que podem ser base de dados, arquivos planos, serviços web ou outras fontes. A extração envolve a coleta das informações necessárias para o processamento posterior.

- Transformação: Nesta etapa, os dados extraídos são transformados conforme os requisitos do sistema. As transformações podem incluir limpeza de dados, conversão de formatos, combinação de dados de múltiplas fontes, filtragem e outras operações que garantam que os dados sejam consistentes e úteis para a análise.

- Carregamento: A fase final envolve carregar os dados transformados no sistema de destino, que geralmente é um Data Warehouse ou base de dados projetados para análise de negócios, como o BigQuery. Os dados agora estão prontos para consultas e análises desejadas.


# 2. Ferramentas e Tecnologias utilizadas
- Google BigQuery: para entender os dados e definir a tabela;
- Planilhas Google: para pesquisar dados de outras fontes;
- Draw SQL: para desenhar a estrutura da base de dados;


# 3. Conjunto de dados (dataset)
O conjunto de dados com informações de vendas da Super Store, está disponível no arquivo *superstore.zip* desde projeto.
A descrição de como está organizada a tabela fonte e suas respectivas variáveis está [aqui](dataset.md).

# 4. Processamento e Preparação da base de dados
Visando realizar uma correta preparação da base de dados, assim como analisar a consistência dos mesmos, foram realizadas consultas para verificar possíveis valores nulos e/ou duplicados. Além de checar possíveis discrepâncias em dados das variáveis categóricas e numéricas (valores inválidos ou fora do padrão esperado).

# 5. Estruturação da base de dados
Nesse ponto do projeto foi avaliada a melhor maneira de estruturar a base de dados, considerando esquema de estrela ou floco de neve. 

Tendo em vista o objetivo da Super Store de melhorar a identificação de padrões, tendências e oportunidades de mercado, entende-se que faz mais sentido focar em consultas otimizadas e uma estrutura mais simples para analistas e BI, portanto, optou-se pelo esquema de estrela.
Sabe-se que em contraponto, esse esquema apresenta possíveis redundâncias e ocupa mais espaço para armazenamento, no entanto, para as consultas, dashboards e relatórios a serem construídos, parece o melhor custo-benefício. Segue a estrutura implementada:

<img width="1477" height="715" alt="tabelas_projeto" src="https://github.com/user-attachments/assets/b3913491-75b9-46e0-ab11-4c04f239d989" />

- Tabela Fato: constitui a tabela central, com dados quantitativos e informações dos pedidos realizados (tabela fato_pedidos). Contendo as seguintes colunas: row_id (PK), order_id, customer_id, product_id, order_date_id, ship_date_id, quantity, discount, sales, profit, shipping_cost, order_priority, market, market2, unknown;

- Tabelas de Dimensões: tratam-se das tabelas com descrições ou categorias, ligadas a tabela fato, geralmente, por chaves primárias (PK) usadas como chaves estrangeiras (FK) na tabela fato. Neste caso, desenhamos a estrutura com 3 tabelas.
  - tabela dim_cliente: customer_id (PK), customer_name, segment, city, state, region, country;
  - tabela dim_produto: product_id (PK), product_name, category, sub_category;
  - tabela dim_tempo: date_id (PK), full_date, year, weeknum;
    
Destaca-se que na tabela dim_tempo será armazenada uma data única presente no conjunto de dados, e na sequência atributos temporais como ano e número da semana. Tanto a data do pedido (order_date) quanto a data do envio (ship_date) são referenciadas na tabela fato_pedidos por chaves estrangeiras que apontam para registros distintos.

Nesta tabela, foi criado date_id (YYYYMMDD) como identificador único (PK), que será a FK da tabela fato_pedidos. Além disso, full_date nesse caso, através da função UNION, junta as datas order_date e ship_date, dando o mesmo nome às duas, além de garantir que não haja datas repetidas. A tabela dim_tempo possui, portanto, uma única linha por data, apesar de na tabela fato_pedidos, usarmos uma vez para order_date_id e outra para ship_date_id. Optei por organizar a informação dessa maneira para manter uma estrutura mais limpa e normalizada. 

Com base na estrutura apresentada anteriormente, e considerando, que o arquivo CSV com os dados brutos, já havia sido importado no BigQuery, optou-se pela transformação da tabela “bruta” em tabelas de fato e dimensões, com comandos SQL (CREATE TABLE).




