-- min_max_runtime_filter.sql
---- QUERY: min_max_runtime_filter
-- Description: a query that results in a highly selective min-max runtime filter. Will
-- only see a perf improvement when runtime filters are implemented.
-- In Spark this filter is implemented by the dynamic file pruning.
select count(*)
from lineitem a, lineitem b
where a.l_orderkey = b.l_orderkey * 2 and b.l_orderkey between 1 and 1000
