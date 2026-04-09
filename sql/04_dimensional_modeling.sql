-- Customer dimension
CREATE OR REPLACE TABLE `projetoetl-466019.dados.dim_cliente` AS
SELECT DISTINCT
  customer_id,
  customer_name,
  segment,
  city,
  state,
  region,
  country
FROM `projetoetl-466019.dados.superstore`;
