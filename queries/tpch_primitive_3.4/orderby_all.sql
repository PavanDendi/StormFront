-- orderby_all.sql
---- QUERY: orderby_all
-- Description : Scan a fact table and sort 50Million rows.
-- Target test case : Order by all columns in the table without returning all
--   rows to the client.
SELECT *
FROM (
  SELECT Rank() OVER (
      ORDER BY l_extendedprice
        ,l_orderkey
        ,l_partkey
        ,l_suppkey
        ,l_linenumber
        ,l_quantity
        ,l_discount
        ,l_tax
        ,l_returnflag
        ,l_linestatus
        ,l_shipdate
        ,l_commitdate
        ,l_receiptdate
        ,l_shipinstruct
        ,l_shipmode
        ,l_comment
      ) AS rank
  FROM lineitem
  WHERE l_shipdate < '1992-02-11'
  ) a
WHERE rank < 10
