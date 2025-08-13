# laboratoria-etl

# 1. Contexto e Objetivo da Análise

A loja Super Store enfrenta o desafio de lidar com grandes volumes de dados dispersos e não estruturados. Para enfrentar esse problema e impulsionar a tomada de decisões informadas, propõe-se a implementação de um robusto sistema ETL (Extract, Transform, Load) com tabelas de fatos e dimensões.
Este projeto concentra-se na criação de um sistema abrangente que permita extrair dados de diversas fontes, transformá-los conforme as necessidades específicas da Super Store e carregá-los de forma eficiente em um Data warehouse organizado. Além disso, objetiva-se aumentar a capacidade da Super Store de identificar padrões, tendências e oportunidades de mercado. 

O processo de ETL consiste basicamente em 3 etapas:
- Extração: durante esta fase, os dados são extraídos de uma ou mais fontes de dados, que podem ser base de dados, arquivos planos, serviços web ou outras fontes. A extração envolve a coleta das informações necessárias para o processamento posterior.

- Transformação: Nesta etapa, os dados extraídos são transformados conforme os requisitos do sistema. As transformações podem incluir limpeza de dados, conversão de formatos, combinação de dados de múltiplas fontes, filtragem e outras operações que garantam que os dados sejam consistentes e úteis para a análise.

- Carregamento: A fase final envolve carregar os dados transformados no sistema de destino, que geralmente é um Data Warehouse ou base de dados projetados para análise de negócios, como o BigQuery. Os dados agora estão prontos para ser consultados e analisados de forma eficiente.


# 2. Ferramentas e Tecnologias utilizadas
- Google BigQuery: para entender os dados e definir a tabela;
- Planilhas Google: para pesquisar dados de outras fontes;
- Draw SQL: para desenhar a estrutura da base de dados;


# 3. Conjunto de dados (dataset)
O conjunto de dados com informações de vendas da Super Store, está disponível no arquivo *superstore.zip* desde projeto.
A descrição de como está organizada a tabela fonte e suas respectivas variáveis está [aqui](dataset.md).
