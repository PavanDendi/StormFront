-- broadcast_join_three_tables.sql
---- QUERY: broadcast_join_three_tables
-- Description : Selective broadcast joins between lineitem, supplier and part.
-- Target test case : Basic BI query with simple aggregation and two highly selective join,
--   and 99% of lineitem rows are filtered out.
SELECT /*+ BROADCAST(supplier,part) */ count(*)
FROM lineitem
JOIN supplier ON l_suppkey = s_suppkey
JOIN part ON l_partkey = p_partkey
WHERE s_name='Supplier#001880004'
  AND p_brand = 'Brand#12'
