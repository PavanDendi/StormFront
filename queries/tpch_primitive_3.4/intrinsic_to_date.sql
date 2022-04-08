-- intrinsic_to_date.sql
---- QUERY: intrinsic_to_date
-- Description : Cast string to date.
-- Target test case : Validate and track performance of to_date().
select
  max(to_date(l_shipdate)),
  min(to_date(l_commitdate)),
  max(to_date(l_receiptdate))
from
  lineitem
where
  l_orderkey > 1
