-- filter_bigint_non_selective.sql
---- QUERY: filter_bigint_non_selective
-- Description : Scan fact table while applying non-selective filter on bigint column that selects 17,997,045,816 out of 18,000,048,306 (99.98%) records.
-- Target test case : Basic scan and filter.
SELECT count(*)
FROM lineitem
WHERE l_partkey between 100000 and 600000000
