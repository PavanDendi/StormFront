-- filter_decimal_selective.sql
---- QUERY: filter_decimal_selective
-- Description : Scan fact table while applying selective filter on decimal column that selects 17,844 out of 18,000,048,306 (0.0001%) records.
-- Target test case : Basic scan and filter.
SELECT count(*)
FROM lineitem
WHERE l_extendedprice < 904.00
