-- aggregation_distinct.sql
---- QUERY: aggregation_distinct
-- Query with multiple DISTINCT classes.
SELECT
  count(distinct l_orderkey) agg1,
  count(distinct l_partkey) agg2,
  count(l_comment) agg3
FROM
  lineitem
WHERE
  l_shipdate < "1993-01-01"
