-- top-n_all.sql
---- QUERY: top-n_all
-- Description : Scan a fact table and select the top-n 1Million rows.
-- Target test case : Order by all columns in the table without returning all
--      rows to the client.
SELECT count(*)
FROM
  (SELECT l_orderkey
        ,l_partkey
        ,l_suppkey
        ,l_linenumber
        ,l_quantity
        ,l_extendedprice
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
   FROM lineitem
   WHERE l_shipdate < '1992-05-01'
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
        ,l_comment LIMIT 1000000) a
