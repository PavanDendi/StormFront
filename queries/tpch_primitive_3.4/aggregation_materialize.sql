-- aggregation_materialize.sql
---- QUERY: aggregation_materialize
-- The planner should recognize that only c1 and c2 are being materialized from
-- the inline-view. This will provide a significant performance improvement on
-- Parquet format tables.
SELECT v1.c1, v1.c2
FROM (SELECT
  sum(l_orderkey) as c1,
  sum(l_partkey) as c2,
  sum(l_suppkey) as c3,
  sum(l_linenumber) as c4,
  sum(l_quantity) as c5,
  sum(l_extendedprice) as c6,
  sum(l_discount) as c7,
  sum(l_tax) as c8 FROM lineitem
  WHERE l_orderkey > 5
    AND l_partkey > 4
    AND l_suppkey > 3
    AND l_linenumber > 2
    AND l_quantity > 1
) v1
