-- shuffle_inner_join_union_all_with_groupby.sql
---- QUERY: shuffle_inner_join_union_all_with_groupby
-- Description : Fact to fact shuffle join on string column followed by group by.
-- Target test case : Large Joins and aggregations done against string column
--   done as part of ETL.
SELECT Count(*) ROWCOUNT
FROM (
    SELECT /*+ SHUFFLE_HASH(o1) */ l_orderkey
    FROM lineitem l1
    INNER JOIN orders o1 ON l1.l_orderkey = o1.o_orderkey
    WHERE l_shipdate < '1993-01-01'
        AND o1.o_orderdate < '1993-01-01'
    GROUP BY l_orderkey
    UNION ALL
    SELECT /*+ SHUFFLE_HASH(o2) */ l_orderkey
    FROM lineitem l2
    INNER JOIN orders o2 ON l2.l_orderkey = o2.o_orderkey
    WHERE l_shipdate < '1993-01-01'
        AND o2.o_orderdate < '1993-01-01'
    GROUP BY l_orderkey
    ) a
GROUP BY l_orderkey
HAVING count(*) = 99999999
