-- groupby_bigint_pk.sql
---- QUERY: groupby_bigint_pk
-- Description : Scan fact table and do a group by on a column with low NDV.
-- Target test case : Hash aggregation with small number of buckets.
SELECT l_orderkey, l_partkey,
       count(*) AS cnt
FROM lineitem
WHERE l_shipdate < '1993'
GROUP BY l_orderkey,l_partkey
HAVING count(*) > 9999999999999
