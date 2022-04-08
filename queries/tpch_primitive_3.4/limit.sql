-- limit.sql
---- QUERY: limit
-- limit 0 is useful to help track performance of processing table metadata, especially
-- for tables with large numbers of partitions.
SELECT * FROM lineitem limit 0
