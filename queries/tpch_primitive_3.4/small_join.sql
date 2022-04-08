-- small_join.sql
---- QUERY: small_join
-- Description : join with small input on both sides
-- Target test case : Small queries where cost of codegen exceeds benefit.
-- This query has been disabled as it does not provide new insight.
SELECT count(*)
FROM (SELECT * FROM customer LIMIT 1000000) c
JOIN nation ON c_nationkey = n_nationkey
