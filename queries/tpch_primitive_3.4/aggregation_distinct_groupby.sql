-- aggregation_distinct_groupby.sql
---- QUERY: aggregation_distinct_groupby
-- Query with multiple DISTINCT classes and outer group by.
SELECT
  count(distinct l_orderkey) agg1,
  count(distinct l_partkey) agg2,
  count(l_comment) agg3
FROM
  lineitem
WHERE
  l_shipdate < "1993-01-01"
GROUP BY l_shipmode
