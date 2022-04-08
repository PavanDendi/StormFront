-- top-n_bigint.sql
---- QUERY: topn_bigint
-- Description : Scan a fact table and select the top-n 1Million rows.
-- Target test case : Order by bigint column without returning all
--   rows to the client.
SELECT count(*)
FROM
  (SELECT l_orderkey
   FROM lineitem
   WHERE l_shipdate < '1993-01-01'
   ORDER BY l_orderkey LIMIT 1000000)a
