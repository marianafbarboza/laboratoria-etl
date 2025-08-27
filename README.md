# laboratoria-etl

# 1. Contexto e Objetivo da Análise

A loja Super Store enfrenta o desafio de lidar com grandes volumes de dados dispersos e não estruturados. Para enfrentar esse problema e impulsionar a tomada de decisões informadas, propõe-se a implementação de um robusto sistema ETL (Extract, Transform, Load) com tabelas de Fatos e Dimensões.
Este projeto concentra-se na criação de um sistema abrangente que permita extrair dados de diversas fontes, transformá-los conforme as necessidades específicas da Super Store e carregá-los de forma eficiente em um Data warehouse organizado. Além disso, objetiva-se aumentar a capacidade da Super Store de identificar padrões, tendências e oportunidades de mercado. 

O processo de ETL consiste basicamente em 3 etapas:
- *Extração*: durante esta fase, os dados são extraídos de uma ou mais fontes de dados, que podem ser base de dados, arquivos planos, serviços web ou outras fontes. A extração envolve a coleta das informações necessárias para o processamento posterior.

- <u>Transformação</u>: Nesta etapa, os dados extraídos são transformados conforme os requisitos do sistema. As transformações podem incluir limpeza de dados, conversão de formatos, combinação de dados de múltiplas fontes, filtragem e outras operações que garantam que os dados sejam consistentes e úteis para a análise.

- <u>Carregamento</u>: A fase final envolve carregar os dados transformados no sistema de destino, que geralmente é um Data Warehouse ou base de dados projetados para análise de negócios, como o BigQuery. Só então, os dados estão prontos para as consultas e análises desejadas.


# 2. Ferramentas e Tecnologias utilizadas
- Google BigQuery: visando um melhor entendimento dos dados e definição da tabela;
- Planilhas Google: para organizar as informações de dados de outras fontes;
- Draw SQL: para entender e projetar a estrutura da base de dados desejada;


# 3. Conjunto de dados (dataset)
O conjunto de dados com informações de vendas da Super Store, está disponível no arquivo *superstore.zip* desde projeto.
A descrição de como está organizada a tabela fonte e suas respectivas variáveis está [aqui](dataset.md).

# 4. Processamento e Preparação da base de dados
Visando realizar uma correta preparação da base de dados, assim como analisar a consistência doa mesma, foram realizadas consultas para verificar possíveis valores nulos e/ou duplicados. Além de checar possíveis discrepâncias em dados das variáveis categóricas e numéricas (valores inválidos ou fora do padrão esperado).
Nesse ponto, optou-se por não considerar a variável "unknown" por possuir um vlor único de registro "1" para todas as linhas, e portanto, não agregar valor a presente análise.

# 5. Estruturação da base de dados
Para entender qual a melhor estrutura para o projeto foi avaliada a melhor maneira de estruturar a base de dados, considerando esquema de estrela ou floco de neve. 

Tendo em vista o objetivo da Super Store de melhorar a identificação de padrões, tendências e oportunidades de mercado, entende-se que faz mais sentido focar em consultas otimizadas e uma estrutura mais simples para analistas e BI, portanto, optou-se pelo esquema de estrela.
Sabe-se que em contraponto, esse esquema apresenta possíveis redundâncias e ocupa mais espaço para armazenamento, no entanto, para as consultas, dashboards e relatórios a serem construídos, parece o melhor custo-benefício. Segue a estrutura implementada:

<img width="1467" height="687" alt="tabelas_projeto" src="https://github.com/user-attachments/assets/41800c52-45c5-489b-8752-757145258a92" />

- Tabela Fato: constitui a tabela central, com dados quantitativos e informações dos pedidos realizados (tabela fato_pedidos). Contendo as seguintes colunas: row_id (PK), order_id, customer_id, product_id, order_date_id, ship_date_id, quantity, discount, sales, profit, shipping_cost, order_priority, market, market2;

- Tabelas de Dimensões: tratam-se das tabelas com descrições ou categorias, ligadas a tabela fato, por chaves primárias (PK) usadas como chaves estrangeiras (FK) na tabela fato. Neste caso, a estrutura foi desenhada com 3 tabelas.
  - tabela dim_cliente: customer_id (PK), customer_name, segment, city, state, region, country;
  - tabela dim_produto: product_id (PK), product_name, category, sub_category;
  - tabela dim_tempo: date_id (PK), full_date, year, weeknum;
    
Destaca-se que na tabela dim_tempo foi armazenada uma data única presente no conjunto de dados, e na sequência atributos temporais como ano e número da semana. Tanto a data do pedido (order_date) quanto a data do envio (ship_date) são referenciadas na tabela fato_pedidos por chaves estrangeiras que apontam para registros distintos.

Nesta tabela, foi criado date_id (YYYYMMDD) como identificador único (PK), que será a FK da tabela fato_pedidos. Além disso, full_date nesse caso, através da função UNION, junta as datas order_date e ship_date, dando o mesmo nome às duas, além de garantir que não haja datas repetidas. A tabela dim_tempo possui, portanto, uma única linha por data, apesar de na tabela fato_pedidos, usarmos uma vez para order_date_id e outra para ship_date_id. Optei por organizar a informação dessa maneira para manter uma estrutura mais limpa e normalizada. 

Com base na estrutura apresentada anteriormente, e considerando, que o arquivo CSV com os dados brutos, já havia sido importado no BigQuery, optou-se pela transformação da tabela “bruta” em tabelas de fato e dimensões, com comandos SQL (CREATE TABLE).

Destaca-se que para a tabela_fato, queremos todos os registros e por isso foi utilizada a função SELECT, já que nessa tabela cada linha representa uma ocorrência, como uma venda, pedido. E a ideia é trazer todos os registros, mesmo que possuam os mesmos clientes e/ou produtos. Já para as tabelas dimensão, utilizou-se SELECT DISTINCT, já que o objetivo é uma linha única por entidade (um cliente por linha, um produto por linha). Como na base de dados importada, um mesmo cliente pode aparecer em vários pedidos, utilizando SELECT DISTINCT removo possíveis dados duplicados.

# 6. Pipeline projetado
O Pipeline envolve o processo automatizado de atualização dos dados que foram estruturados. Pensando em uma dinâmica hipotética, da empresa Super Store, acredito que a estrutura poderia se basear nas seguintes etapas:
   - Recebimento do Arquivo CSV: O arquivo com os dados de vendas da Super Store é disponibilizado regularmente, de forma automatizada (ex.: diariamente) ou manual em casos pontuais;
   - Carga Inicial para Tabela Bruta: Os dados do CSV são importados como estão para uma tabela intermediária, mantendo a estrutura original da fonte;
   - Limpeza e transformação dos dados: nessa etapa são corrigidas possíveis inconsistências, convertidos formatos (data, por exemplo) e criadas colunas auxiliares e chaves (como date_id);
   - Atualização das tabelas de dimensões, na seguinte ordem: dim_cliente, dim_produto, dim_tempo. Essas dimensões são processadas antes por serem consideradas mais “estáveis”, apresentando baixa frequência de mudança. São impactadas apenas com a entrada de novos valores (clientes, produtos, por exemplo);
   - Atualização da tabela fato_pedidos - essa tabela armazena registros transacionais (vendas, quantidade, lucro) e se referem as chaves das tabelas dimensão;

A ideia baseia-se numa atualização realizada de forma incremental, utilizando apenas dados novos ou modificados, o que evita recriar as tabelas novamente a cada execução.


# 7. Automatização das rotinas do Pipeline
Visando a inclusão de processos automatizados na rotina da loja Super Store, pensei em incluir conjuntamente o Cloud Composer (ferramenta open source do Google Cloud Platform) como orquestrador do pipeline de dados, e o dbt (Data Build Tool) para auxílio na escrita e organização das consultas SQL. Seguindo assim as seguintes etapas:

## 7.1 Orquestração e Ingestão com Cloud Composer (Airflow no GPC)
O Composer é o responsável por organizar o fluxo, carregar dados “brutos” e monitorar todo o processo, alertando sobre possíveis falhas. Com as etapas:
  - Ingestão do CSV : Uma DAG (Directed Acyclic Graph), ou seja, o roteiro de tarefas do Airflow é configurada no Cloud Composer para monitorar um bucket do GCS (Google Cloud Storage). O bucket funciona como uma pasta no storage, quando o CSV for detectado, a DAG automaticamente será disparada;
  - Carga para tabela bruta (landing zone): Uma task (tarefa dentro da DAG) carrega o CSV recebido para uma tabela no BigQuery, por ex: “superstore_raw”, que mantém os dados originais, sem qualquer transformação. Assim, tem-se sempre a versão original dos dados importados (tabela funciona como staging aqui);
  - Disparo do dbt: Quando a carga bruta termina, o Composer chama o dbt para iniciar as transformações;
  - Monitoramento e alertas: O Composer acompanha todo o processo descrito anteriormente e envia alertas (por email ou Slack, por exemplo), em caso de falhas, como CSV corrompido ou erro de conexão.

## 7.2 Transformação e Modelagem com dbt
O dbt assume a partir da tabela bruta no BigQuery, cuidando das transformações, boas práticas e documentação. Se divide nos seguintes passos:
  - Fonte: Aqui a ideia é o carregamento do CSV no BigQuery (tabela superstore_raw já mencionada anteriormente), o dbt referencia essa tabela como source, ponto de partida para as transformações;
  - Transformação inicial (staging): Nesse ponto o dbt roda queries SQL para limpar e padronizar os dados. São usadas como tabelas intermediárias de preparação (um rascunho). Esta etapa consiste na verdadeira limpeza e padronização dos dados;
  - Construção das dimensões: Modelos específicos atualizam as tabelas de dimensão (dim_cliente, dim_produto, dim_tempo);
  - Construção da tabela fato: Outro modelo cria a tabela fato_pedidos, juntando métricas e conectando às dimensões;
  - Orquestração automática: O dbt entende a ordem correta e dependências: staging - dimensões - fato;
  - Documentação e testes: O dbt gera documentação interativa (com diagramas de dependência) e também executa testes de qualidade visando garantir que os dados possuem IDs únicos, Datas não nulas e relação cliente-pedido consistente.

