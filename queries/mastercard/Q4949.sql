select m.DW_PROCESS_MONTH
, ag.Industry_Name
, sum(c.CLEARED_NET_TRAN_AMT_USD)
from clearing_summary_data_set c
inner join month m on c.DW_PROCESS_MONTH = m.DW_PROCESS_MONTH and m.DW_PROCESS_MONTH = '2020-01-01'
inner join country cn on c.ISS_COUNTRY_CODE = cn.COUNTRY_CODE and cn.COUNTRY_CODE = 'GIB'
inner join agg_merch ag on c.MERCH_LOCATION_ID = ag.MERCH_LOCATION_ID and ag.Industry_Name in ('Cosmetics and Beauty Services','Variety / General Merchandise Stores','Consumer Electronics / Appliances')
inner join product p on p.PRODUCT_CODE = c.PRODUCT_CODE and p.PRODUCT_GROUP_NAME like 'CIRRUS%'
where c.ISS_PREF_CURR_CODE = c.ACQ_PREF_CURR_CODE
group by m.DW_PROCESS_MONTH, ag.Industry_Name;