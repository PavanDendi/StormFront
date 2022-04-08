-- aggregation_simple.sql
---- QUERY: aggregation_simple
-- Simple aggregations across a few different data types
SELECT count(*), min(l_linenumber), max(l_quantity), round(sum(l_tax), 2)
FROM lineitem
