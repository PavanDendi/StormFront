select m.Year_Qtr
, cn.BUSINESS_REGION_NAME as Iss_Region
, cn.COUNTRY_NAME as Iss_Country
, ag.Industry_Name,  ag.AGGREGATE_MERCHANT_NAME
, sum(c.CLEARED_NET_TRAN_AMT_USD) as CLEARED_NET_TRAN_AMT_USD
, sum(c.CLEARED_NET_TRAN_CNT) as CLEARED_NET_TRAN_CNT
from clearing_summary_data_set c
inner join agg_merch ag on c.MERCH_LOCATION_ID = ag.MERCH_LOCATION_ID
inner join country cn on cn.COUNTRY_CODE= c.ISS_COUNTRY_CODE
inner join month m on c.DW_PROCESS_MONTH = m.DW_PROCESS_MONTH
where m.Year = '2020'
and cn.COUNTRY_NAME = 'ARGENTINA'
and ag.AGGREGATE_MERCHANT_NAME in ('Agg Merch _11125','Agg Merch _5093', 'Agg Merch _14013')
and ag.Industry_Name = 'Department Stores'
group by m.Year_Qtr
, cn.BUSINESS_REGION_NAME
, cn.COUNTRY_NAME
, ag.AGGREGATE_MERCHANT_NAME
, ag.Industry_Name;