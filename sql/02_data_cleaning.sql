-- Example of text standardization
SELECT
  segment,
  LOWER(TRIM(segment)) AS segment_padrao,
  COUNT(*) AS total
FROM `projetoetl-466019.dados.superstore`
GROUP BY segment, segment_padrao;
