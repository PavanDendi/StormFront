-- conjunct_ordering_aggregation_groupby.sql
---- QUERY: conjunct_ordering_aggregation_groupby
-- Description: Based on TPCDS-Q41
SELECT l_linenumber, count(*) as line_cnt
FROM lineitem
WHERE ((l_shipmode LIKE '%MAIL%'
      AND l_quantity BETWEEN 10 AND 40
      AND l_shipinstruct IN ('NONE', 'DELIVER IN PERSON'))
    OR (l_shipmode LIKE '%RAIL%'
      AND l_quantity BETWEEN 20 AND 50
      AND l_shipinstruct IN ('COLLECT COD', 'NONE'))
    OR (l_shipmode LIKE '%FOB%'
      AND l_quantity BETWEEN 0 AND 30
      AND l_shipinstruct IN ('TAKE BACK RETURN', 'DELIVER IN PERSON'))
    OR (l_shipmode LIKE '%SHIP%'
      AND l_quantity BETWEEN 0 AND 20
      AND l_shipinstruct IN ('NONE', 'COLLECT COD', 'DELIVER IN PERSON')))
    AND l_shipdate < '1995'
GROUP BY l_linenumber
