-- aggregation_groupby_small.sql
---- QUERY: aggregation_groupby_small
-- Group by l_shipmode - 7 groups
SELECT l_shipmode, count(*)
FROM lineitem
GROUP BY l_shipmode
