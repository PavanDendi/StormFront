select m.Year_Qtr
,cn.COUNTRY_NAME as Acq_Country
,ag.PARENT_AGGREGATE_MERCHANT_NAME
,case when c.ACCOUNT_CATEGORY_CODE = 'C' then 'CP' else 'DB' end as CreditDebitInd
,sum(c.CLEARED_NET_TRAN_AMT_ACQ_PREF)
,sum(c.CLEARED_NET_TRAN_CNT)
from clearing_summary_data_set c
inner join agg_merch ag on c.MERCH_LOCATION_ID = ag.MERCH_LOCATION_ID and ag.PARENT_AGGREGATE_MERCHANT_NAME = 'Parent Agg Merch _7204'
inner join month m on m.DW_PROCESS_MONTH = c.DW_PROCESS_MONTH and m.DW_PROCESS_MONTH = '2020-01-01'
inner join country cn on cn.COUNTRY_CODE = c.ACQ_COUNTRY_CODE and cn.COUNTRY_CODE = 'NZL'
group by m.Year_Qtr,
cn.COUNTRY_NAME
,ag.PARENT_AGGREGATE_MERCHANT_NAME
,case when c.ACCOUNT_CATEGORY_CODE = 'C' then 'CP' else 'DB' end;