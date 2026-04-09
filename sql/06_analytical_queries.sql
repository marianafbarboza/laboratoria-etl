-- Total orders per year
SELECT 
  t.year AS order_year,
  COUNT(*) AS total_orders
FROM fato_pedidos f
JOIN dim_tempo t 
  ON f.order_date_id = t.date_id
GROUP BY order_year;
