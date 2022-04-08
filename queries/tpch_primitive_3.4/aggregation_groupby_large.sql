-- aggregation_groupby_large.sql
---- QUERY: aggregation_groupby_large
-- Group by l_receiptdate ~ 2500 groups
SELECT  l_receiptdate, count(*)
FROM lineitem
GROUP BY l_receiptdate
