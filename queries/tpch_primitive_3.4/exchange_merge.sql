-- exchange_merge.sql
---- QUERY: exchange_merge
-- Description : Large fact to fact shuffle.
-- Target test case : Shuffle large amuonts of data over the network.
SELECT /*+ SHUFFLE_MERGE(l1,l2) */ count(*)
FROM lineitem l1
JOIN  lineitem l2 ON l1.l_orderkey = l2.l_orderkey
WHERE l1.l_shipdate < "1994"
  AND l2.l_shipdate > "1997"
  AND l2.l_partkey > 0
  AND l2.l_suppkey > 0
  AND l2.l_linenumber > 0
