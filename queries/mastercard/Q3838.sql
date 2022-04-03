select m.DW_PROCESS_MONTH
, cn.BUSINESS_REGION_NAME as Iss_Region
, cn.COUNTRY_NAME as Iss_Country
, mh.PARENT_ICA_NAME as Iss_Parent_ICA_Name
, ag.Industry_Name,  ag.AGGREGATE_MERCHANT_NAME
, sum(c.CLEARED_NET_TRAN_AMT_USD) as CLEARED_NET_TRAN_AMT_USD
, sum(c.CLEARED_NET_TRAN_CNT) as CLEARED_NET_TRAN_CNT
from clearing_summary_data_set c
inner join agg_merch ag on c.MERCH_LOCATION_ID = ag.MERCH_LOCATION_ID
inner join country cn on cn.COUNTRY_CODE= c.ISS_COUNTRY_CODE
inner join member_hierarchy mh on mh.CHILD_ICA_CODE = c.ISS_CHILD_ICA_CODE and mh.PARENT_ICA_NAME = 'Parent ICA Name_727'
inner join month m on c.DW_PROCESS_MONTH = m.DW_PROCESS_MONTH
where m.DW_PROCESS_MONTH = '2020-01-01'
and c.ISS_PREF_CURR_CODE = c.ACQ_PREF_CURR_CODE
and cn.COUNTRY_NAME = 'NIUE'
and ag.AGGREGATE_MERCHANT_NAME in ('Agg Merch _12025','Agg Merch _8693', 'Agg Merch _15913')
and ag.Industry_Name = 'Department Stores'
group by m.DW_PROCESS_MONTH, cn.BUSINESS_REGION_NAME , cn.COUNTRY_NAME, ag.AGGREGATE_MERCHANT_NAME,mh.PARENT_ICA_NAME, ag.Industry_Name;