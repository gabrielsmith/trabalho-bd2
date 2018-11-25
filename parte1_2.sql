CREATE OR REPLACE FUNCTION delete_indexes (tbl_name regclass) RETURNS integer
AS $$
BEGIN
  EXECUTE (
  SELECT 'DROP INDEX ' || string_agg(indexrelid::regclass::text, ', ')
  FROM pg_index i
  LEFT JOIN pg_depend d ON d.objid = i.indexrelid
    AND d.deptype = 'i'
  WHERE i.indrelid = tbl_name
  AND d.objid IS NULL
  );
  return 1;
END;
$$ LANGUAGE plpgsql;
