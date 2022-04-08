-- string_like_predicate_middle.sql
---- QUERY: string_like_predicate_middle
SELECT count(*) FROM lineitem
WHERE l_comment LIKE 'egular courts above th%e'
