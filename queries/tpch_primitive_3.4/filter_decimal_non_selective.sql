-- filter_decimal_non_selective.sql
---- QUERY: filter_decimal_non_selective
-- Description : Scan fact table while applying non-selective filter on decimal column that selects 18,000,030,462 out of 18,000,048,306 (99.99%) records.
-- Target test case : Basic scan and filter.
SELECT count(*)
FROM lineitem
WHERE l_extendedprice > 904.00
