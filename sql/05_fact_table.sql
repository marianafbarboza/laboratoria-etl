CREATE OR REPLACE TABLE `projetoetl-466019.dados.fato_pedidos` AS
SELECT
  row_id,
  order_id,
  customer_id,
  product_id,
  order_date AS order_date_id,
  ship_date AS ship_date_id,
  quantity,
  discount,
  sales,
  profit,
  shipping_cost,
  ship_mode,
  order_priority,
  market,
  market2
FROM `projetoetl-466019.dados.superstore`;
