-- filter_bigint_selective.sql
---- QUERY: filter_bigint_selective
-- Description : Scan fact table while applying selective filter on bigint column that selects 27,012,411 out of 18,000,048,306 (0.15%) records.
-- Target test case : Basic scan and filter.
SELECT count(*)
FROM lineitem
WHERE l_partkey between 1 and 900000
