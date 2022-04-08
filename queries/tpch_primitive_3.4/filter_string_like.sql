-- filter_string_like.sql
---- QUERY: filter_string_like
-- Description : Scan fact table while applying like filter on string column.
-- Target test case : Basic scan and filter.
SELECT Count(*)
FROM   lineitem
WHERE  l_comment LIKE '%the%final%%' AND l_shipdate < '1993'
LIMIT  100
