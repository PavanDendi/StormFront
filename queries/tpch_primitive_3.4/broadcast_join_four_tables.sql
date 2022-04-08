-- broadcast_join_four_tables.sql
---- QUERY: broadcast_join_four_tables
-- Description : Selective broadcast joins between lineitem, supplier, part and orders.
-- Target test case : More complex BI query involving a large broadcast with orders,
--   the planner currently create a left deep tree where it should be creating
--   orders x ((lineitem x supplier) x part).
SELECT /*+ BROADCAST(supplier,part,orders) */ count(*)
FROM lineitem
JOIN supplier ON l_suppkey = s_suppkey
JOIN part ON l_partkey = p_partkey
JOIN orders ON l_orderkey = o_orderkey
WHERE s_name='Supplier#001880004'
  AND p_brand = 'Brand#44'
  AND o_orderdate = '1992-01-15'
