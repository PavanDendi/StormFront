select m.Year_Qtr
, ic.BUSINESS_REGION_NAME as ISS_Region
,ag.AGGREGATE_MERCHANT_NAME
, c.CARDHOLDER_PRESENT_CODE
, sum(c.CLEARED_NET_TRAN_CNT)
from clearing_summary_data_set c
inner join country ic on ic.COUNTRY_CODE = c.ISS_COUNTRY_CODE and ic.BUSINESS_REGION_CODE = '5'
inner join month m on m.DW_PROCESS_MONTH = c.DW_PROCESS_MONTH and m.DW_PROCESS_MONTH = '2020-01-01'
inner join agg_merch ag on ag.MERCH_LOCATION_ID = c.MERCH_LOCATION_ID and ag.AGGREGATE_MERCHANT_NAME = 'Agg Merch _9004'
group by m.Year_Qtr
, ic.BUSINESS_REGION_NAME
,ag.AGGREGATE_MERCHANT_NAME
, c.CARDHOLDER_PRESENT_CODE;