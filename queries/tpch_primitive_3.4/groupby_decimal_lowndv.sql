-- groupby_decimal_lowndv.sql
---- QUERY: groupby_decimal_lowndv.test
-- Description : Scan fact table and do a group by on a column with low NDV.
-- Target test case : Hash aggregation with large number of buckets, group by decimal
--   is more popular in the finance sector.
SELECT l_discount,
       count(*) AS cnt
FROM lineitem
GROUP BY l_discount
HAVING count(*) > 9999999999999
