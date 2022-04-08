-- string_like_predicate_left.sql
---- QUERY: string_like_predicate_left
SELECT count(*) FROM lineitem
WHERE l_comment LIKE '%egular courts above the'
