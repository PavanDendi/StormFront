-- many_independent_stages.sql
---- QUERY: many_independent_stages
-- Description : Query with a large number of independent shuffle joins
-- Target test case : Run a query with a large number of stages
--  stressing query startup, connection creation and query teardown
--  This query has been disabled as it crashes the cluster. See JIRA ticket
--  https://databricks.atlassian.net/browse/SC-41675.
with subquery as (select count(*) from lineitem a join
orders b on a.l_orderkey = b.o_orderkey where a.l_orderkey = b.o_orderkey and l_shipdate
between "1992-01-01" and "1994-01-01" and o_orderdate between "1992-01-01" and
"1994-01-01" group by a.l_orderkey having count(*) > 9999999999) select * from (select *
from subquery) a1, (select * from subquery) a2, (select * from subquery) a3, (select * from subquery) a4,
(select * from subquery) a5, (select * from subquery) a6, (select * from subquery) a7,
(select * from subquery) a8, (select * from subquery) a9, (select * from subquery) a10,
(select * from subquery) a11, (select * from subquery) a12, (select * from subquery) a13,
(select * from subquery) a14, (select * from subquery) a15, (select * from subquery) a16,
(select * from subquery) a17, (select * from subquery) a18, (select * from subquery) a19,
(select * from subquery) a20, (select * from subquery) a21, (select * from subquery) a22,
(select * from subquery) a23, (select * from subquery) a24, (select * from subquery) a25,
(select * from subquery) a26, (select * from subquery) a27, (select * from subquery) a28,
(select * from subquery) a29, (select * from subquery) a30, (select * from subquery) a31,
(select * from subquery) a32, (select * from subquery) a33, (select * from subquery) a34,
(select * from subquery) a35, (select * from subquery) a36, (select * from subquery) a37,
(select * from subquery) a38, (select * from subquery) a39, (select * from subquery) a40,
(select * from subquery) a41, (select * from subquery) a42, (select * from subquery) a43,
(select * from subquery) a44, (select * from subquery) a45, (select * from subquery) a46,
(select * from subquery) a47, (select * from subquery) a48, (select * from subquery) a49,
(select * from subquery) a50
