-- aggregation_selective.sql
---- QUERY: aggregation_selective
-- This is a perf regression test for IMPALA-288. The goal of the query is to
-- be very selective - the filter will select only 2 rows from lineitem
-- across all scale factors.
select min(l_comment), count(*) from lineitem
where
  l_shipmode = 'AIR' and l_linenumber = 3 and
  l_orderkey > 1075680 and l_orderkey < 1075685
