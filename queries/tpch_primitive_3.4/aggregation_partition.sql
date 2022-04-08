-- aggregation_partition.sql
---- QUERY: aggregation_partition
-- This is interesting for looking at partitioned aggregation.
-- Ideally, we would like to have a column with more distinct values
-- but there are intermittent slow downs. l_suppkey is good enough
-- for now.
SELECT l_shipdate, count(*) as cnt
FROM lineitem
WHERE l_linenumber > 2
GROUP BY l_shipdate
ORDER BY cnt, l_shipdate
LIMIT 10
