select m.Year_Qtr
,cn.COUNTRY_NAME as Iss_Country
,ag.AGGREGATE_MERCHANT_NAME
,case when c.CARDHOLDER_PRESENT_CODE = 0 then 'CP' else 'CNP' end as CPorCNP
,sum(c.CLEARED_NET_TRAN_CNT)
from clearing_summary_data_set c
inner join country cn on cn.COUNTRY_CODE = c.ISS_COUNTRY_CODE and cn.COUNTRY_CODE = 'AUS'
inner join month m on c.DW_PROCESS_MONTH = m.DW_PROCESS_MONTH and m.Year_Qtr = '2020 Q1'
inner join agg_merch ag on ag.MERCH_LOCATION_ID = c.MERCH_LOCATION_ID and ag.AGGREGATE_MERCHANT_NAME = 'Agg Merch _4833'
group by m.Year_Qtr
,cn.COUNTRY_NAME
,ag.AGGREGATE_MERCHANT_NAME
,case when c.CARDHOLDER_PRESENT_CODE = 0 then 'CP' else 'CNP' end
order by 1;