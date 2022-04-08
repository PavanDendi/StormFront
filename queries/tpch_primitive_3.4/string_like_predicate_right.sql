-- string_like_predicate_right.sql
---- QUERY: string_like_predicate_right
SELECT count(*) FROM lineitem
WHERE l_comment LIKE 'egular courts above the%'
