-- Verify null values dinamically
SELECT
  CONCAT(
    'SELECT ',
    STRING_AGG(
      FORMAT("COUNTIF(%s IS NULL) AS nulos_%s", column_name, column_name),
      ', '
    ),
    ' FROM projetoetl-466019.dados.superstore'
  ) AS query
FROM projetoetl-466019.dados.INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'superstore';
