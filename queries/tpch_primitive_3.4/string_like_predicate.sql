-- string_like_predicate.sql
---- QUERY: string_like_predicate
SELECT count(*) FROM lineitem
WHERE l_comment LIKE 'egular courts above the'
