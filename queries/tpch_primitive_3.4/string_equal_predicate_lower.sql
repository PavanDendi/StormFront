-- string_equal_predicate_lower.sql
---- QUERY: string_equal_predicate_lower
-- Make sure we free local expr allocations
SELECT count(*) FROM lineitem
WHERE lower(l_comment) =     'egular courts above the'
