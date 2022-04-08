-- groupby_decimal_highndv.sql
---- QUERY: groupby_decimal_highndv
-- Description : Scan fact table and do a group by on decimal column with high NDV.
-- Target test case : Hash aggregation with large number of buckets, group by decimal
--   is more popular in the finance sector.
SELECT l_extendedprice,
       count(*) AS cnt
FROM lineitem
WHERE l_shipdate < '1995'
GROUP BY l_extendedprice
HAVING count(*) > 9999999999999
