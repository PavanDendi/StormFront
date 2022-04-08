-- conjunct_ordering_subquery.sql
---- QUERY: conjunct_ordering_subquery
-- Description: Based on TPCDS-Q48
SELECT /*+ SHUFFLE_HASH(v1) */ sum(l_quantity)
FROM orders, lineitem,
  (SELECT * FROM customer WHERE c_comment LIKE c_comment AND c_nationkey IN (5, 10)) as v1
WHERE l_shipdate < "1993-01-01"
  AND o_orderdate < "1993-01-01"
  AND l_orderkey = o_orderkey
  AND (v1.c_custkey = o_custkey
    AND (o_totalprice BETWEEN 1000 AND 2000
      OR o_totalprice BETWEEN 3000 AND 4000
      OR o_totalprice BETWEEN 5000 AND 6000))
