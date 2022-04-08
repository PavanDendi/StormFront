-- exchange_shuffle.sql
---- QUERY: exchange_shuffle
-- Description : Large fact to fact shuffle.
-- Target test case : Shuffle large amuonts of data over the network.
SELECT /*+ SHUFFLE_HASH(l1,l2) */ count(*)
FROM lineitem l1
JOIN  lineitem l2 ON l1.l_orderkey = l2.l_orderkey
WHERE l1.l_shipdate < "1993" -- Fit on 30GB workers
  AND l2.l_shipdate > "1998" -- Fit on 30GB workers
  AND l2.l_partkey > 0
  AND l2.l_suppkey > 0
  AND l2.l_linenumber > 0
