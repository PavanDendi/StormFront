-- string_like_predicate_both.sql
---- QUERY: string_like_predicate_both
SELECT count(*) FROM lineitem
WHERE l_comment LIKE '%egular courts above the%'
