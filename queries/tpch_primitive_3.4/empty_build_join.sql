-- empty_build_join.sql
---- QUERY: empty_build_join
-- Description : Join with empty build side and large probe side.
-- Target test case : Analytic query with selective filters where evaluation of
--   the join can be short-circuited for a dramatic speedup.
SELECT *
FROM lineitem
INNER JOIN orders ON l_orderkey = o_orderkey
WHERE o_comment = 'no matching comments' AND o_orderdate < "1993"
