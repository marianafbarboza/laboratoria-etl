-- Duplicates check
SELECT
  order_id,
  customer_id,
  product_id,
  order_date,
  COUNT(*) AS total
FROM `projetoetl-466019.dados.superstore`
GROUP BY order_id, customer_id, product_id, order_date
HAVING COUNT(*) > 1;

-- Basic statics
SELECT
  MIN(sales) AS min_sales,
  MAX(sales) AS max_sales,
  AVG(sales) AS avg_sales,
  STDDEV(sales) AS std_sales
FROM `projetoetl-466019.dados.superstore`;
