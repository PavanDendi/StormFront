-- filter_string_non_selective.sql
---- QUERY: filter_string_non_selective
-- Description : Scan fact table while applying non-selective filter on string column.
-- Target test case : Basic scan and filter.
SELECT count(*)
FROM lineitem
WHERE l_comment != 'non exist'
