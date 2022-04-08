-- aggregation_materialize_subquery.sql
---- QUERY: aggregation_materialize_subquery
-- Similar to aggregation_6, but with a more complicated query that contains a
-- WITH clause and an inline-view.
WITH v2 as (SELECT v1.c1, v1.c2
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
  ) v1)
SELECT c1, c2 from v2
