-- conjunct_ordering_aggregation.sql
---- QUERY: conjunct_ordering_aggregation
-- Description: Based on TPCDS-Q28
SELECT avg(l_extendedprice), count(l_extendedprice), count(distinct l_extendedprice)
FROM lineitem
WHERE
  (l_discount BETWEEN 0.2 AND 0.3
    OR l_discount BETWEEN 0.4 AND 0.5
    OR l_tax BETWEEN 0.1 AND 0.2
    OR l_tax BETWEEN 0 AND 0.09)
  AND l_extendedprice BETWEEN 100 AND 1000
