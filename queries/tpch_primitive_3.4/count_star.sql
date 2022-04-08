-- count_star.sql
---- QUERY: count_star
-- Description : Excercise Parquet stats optimization when evaluating count(*)
-- Target test case : Simple count(*) query.
SELECT count(*)
FROM lineitem
