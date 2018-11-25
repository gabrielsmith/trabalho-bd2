SELECT
  t.relname as table_name,
  c.conname as fkey_name,
  a.attname as column_name
FROM
  pg_class t,
  pg_constraint c,
  pg_attribute a
WHERE
  t.oid = c.conrelid
  AND c.contype = 'f'
  AND a.attrelid = t.oid
  AND a.attnum = ANY(c.conkey)
  AND t.relkind = 'r'
  AND t.relname !~ '^(pg_|sql_)'
ORDER BY
  t.relname,
  c.conname;
