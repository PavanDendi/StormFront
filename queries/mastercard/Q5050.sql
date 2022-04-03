select m.Year_Qtr
, ag.Industry_Name
, sum(c.CLEARED_NET_TRAN_AMT_USD)
from clearing_summary_data_set c
inner join month m on c.DW_PROCESS_MONTH = m.DW_PROCESS_MONTH and m.Year = '2020'
inner join country cn on c.ISS_COUNTRY_CODE = cn.COUNTRY_CODE and cn.COUNTRY_CODE = 'IDN'
inner join agg_merch ag on c.MERCH_LOCATION_ID = ag.MERCH_LOCATION_ID and ag.Industry_Name in ('Office Supply Chains','Variety / General Merchandise Stores','Consumer Electronics / Appliances')
inner join product p on p.PRODUCT_CODE = c.PRODUCT_CODE and p.PRODUCT_GROUP_NAME like 'COMMERCIAL%'
where c.ISS_COUNTRY_CODE = c.MERCH_COUNTRY_CODE
group by m.Year_Qtr, ag.Industry_Name;