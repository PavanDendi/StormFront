-- decimal_arithmetic.sql
---- QUERY: decimal_arithmetic
-- Description : Query dominated by decimal arithmetic
-- Target test case : Validate and track decimal arithmetic performance .
 select
  sum(l_quantity * l_tax), sum(l_extendedprice * l_discount) ,
   sum(l_quantity / l_tax), sum(l_extendedprice / l_discount),
   sum(l_quantity + l_tax), sum(l_extendedprice + l_discount) ,
   sum(l_quantity - l_tax), sum(l_extendedprice - l_discount)
 from lineitem where l_shipdate > '1998-06-01' and l_tax > 0 and l_discount > 0
