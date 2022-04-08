-- string_equal_predicate.sql
---- QUERY: string_equal_predicate
SELECT count(*) FROM lineitem
WHERE l_comment =     'egular courts above the'
