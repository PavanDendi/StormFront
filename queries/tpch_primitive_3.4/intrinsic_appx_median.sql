-- intrinsic_appx_median.sql
---- QUERY: intrinsic_appx_median
-- Description : Query dominated by APPX_MEDIAN
-- Target test case : Validate and track memory consumption and perf for APPX_MEDIAN .
-- Note : Spark SQL does not support APPX_MEDIAN. Use PERCENTILE_APPROX instead .
select percentile_approx(o_totalprice, 0.5),percentile_approx(o_orderpriority, 0.5), count(*)
from orders
where o_orderdate >= '1997-01-01'
group by o_orderdate,o_orderpriority
having count(*) > 100000
