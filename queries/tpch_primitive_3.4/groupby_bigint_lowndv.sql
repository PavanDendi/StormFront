-- groupby_bigint_lowndv.sql
---- QUERY: groupby_bigint_lowndv
-- Description : Scan fact table and do a group by on a column with low NDV.
-- Target test case : Hash aggregation with small number of buckets.
SELECT l_linenumber,
       count(*) AS cnt
FROM lineitem
GROUP BY l_linenumber
HAVING count(*) > 9999999999999
