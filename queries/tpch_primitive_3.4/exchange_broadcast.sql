-- exchange_broadcast.sql
---- QUERY: exchange_broadcast
-- Description : Large broadcast join with no rows qualifying from the probe side.
-- Target test case : Broadcast large amounts of data over the network while stressing the
--   exchange operator along with HashTable build.
SELECT /*+ BROADCAST(lineitem) */ count(*)
FROM nation
JOIN lineitem ON l_orderkey = n_nationkey
WHERE l_partkey > 0
  AND l_suppkey > 0
  AND l_linenumber > 0
  AND n_regionkey < 0
  AND l_orderkey < 60000000
