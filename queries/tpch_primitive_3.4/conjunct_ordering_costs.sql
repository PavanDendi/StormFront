-- conjunct_ordering_costs.sql
---- QUERY: conjunct_ordering_costs
-- Description : A simple select with one expensive conjunct and one cheap conjunct.
--   The Spark SQL planner does not prioritize cheap range filters over the regex one.
--   This issue has been reported, see https://databricks.atlassian.net/browse/SC-42520.
select count(*)
from lineitem
where l_comment rlike '%a%b%d%' and l_orderkey between 100 and 999999 and l_shipdate < '1994'
