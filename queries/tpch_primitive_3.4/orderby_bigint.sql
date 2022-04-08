-- orderby_bigint.sql
---- QUERY: orderby_bigint
-- Description : Scan a fact table and sort 50Million rows.
-- Target test case : Order by bigint column without returning all
--   rows to the client.
SELECT *
FROM   (SELECT Rank()
                 OVER(
                   ORDER BY  l_orderkey) AS rank
        FROM   lineitem
        WHERE  l_shipdate < '1992-02-11') a
WHERE  rank < 10
