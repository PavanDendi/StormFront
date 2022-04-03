select m.Year_Qtr,  ag.AGGREGATE_MERCHANT_NAME
     , sum(c.CLEARED_NET_TRAN_AMT_USD) as CLEARED_NET_TRAN_AMT_USD
     , sum(c.CLEARED_NET_TRAN_CNT) as CLEARED_NET_TRAN_CNT
from clearing_summary_data_set c
inner join agg_merch ag on c.MERCH_LOCATION_ID = ag.MERCH_LOCATION_ID
inner join country cn on cn.COUNTRY_CODE= c.ISS_COUNTRY_CODE
inner join country mcn on mcn.COUNTRY_CODE= c.MERCH_COUNTRY_CODE
inner join month m on c.DW_PROCESS_MONTH = m.DW_PROCESS_MONTH
where m.Year = '2020'
and cn.COUNTRY_CODE = 'VCT'
and mcn.BUSINESS_REGION_CODE = '1'
and ag.Industry_Name in ('T+E Airlines','Video and Game Rentals','Accommodations')
group by m.Year_Qtr,  ag.AGGREGATE_MERCHANT_NAME;