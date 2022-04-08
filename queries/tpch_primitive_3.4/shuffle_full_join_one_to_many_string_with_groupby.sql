-- shuffle_full_join_one_to_many_string_with_groupby.sql
---- QUERY: shuffle_full_join_one_to_many_string_with_groupby
-- Description : Fact to fact shuffle join on string column followed by group by.
-- Target test case : Large Joins and aggregations done against string column
--   done as part of ETL.
SELECT /*+ SHUFFLE_HASH(l,o) */ Count(*) AS cnt
FROM
  ( SELECT Upper(Concat(Cast(l_orderkey AS STRING),'bla')) AS l_orderkey_string
   FROM lineitem WHERE l_shipdate < "1993-01-01" ) l
FULL JOIN
  ( SELECT upper(concat(cast(o_orderkey AS string),'bla')) o_orderkey_string
   FROM orders WHERE o_orderdate < "1993-01-01" ) o
ON l.l_orderkey_string = o.o_orderkey_string
GROUP BY o.o_orderkey_string
HAVING count(*) = 999999
