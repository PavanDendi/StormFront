-- q16.sql
-- scale 30000, stream 0, seed 100
select  
   count(distinct cs_order_number) as `order count`
  ,sum(cs_ext_ship_cost) as `total shipping cost`
  ,sum(cs_net_profit) as `total net profit`
from
   catalog_sales cs1
  ,date_dim
  ,customer_address
  ,call_center
where
    d_date between '1999-4-01' and 
           date_add(cast('1999-4-01' as date),60)
and cs1.cs_ship_date_sk = d_date_sk
and cs1.cs_ship_addr_sk = ca_address_sk
and ca_state = 'WA'
and cs1.cs_call_center_sk = cc_call_center_sk
and cc_county in ('Fairfield County','Luce County','Dauphin County','Barrow County',
                  'Richland County'
)
and exists (select *
            from catalog_sales cs2
            where cs1.cs_order_number = cs2.cs_order_number
              and cs1.cs_warehouse_sk <> cs2.cs_warehouse_sk)
and not exists(select *
               from catalog_returns cr1
               where cs1.cs_order_number = cr1.cr_order_number)
order by count(distinct cs_order_number)
limit 100

