select m.Year_Qtr
, c.ACQ_TRANSIT_ROUTING_ID
, sum(c.CLEARED_NET_TRAN_AMT_USD) as CLEARED_NET_TRAN_AMT_USD
, sum(c.CLEARED_NET_TRAN_CNT) as CLEARED_NET_TRAN_CNT
from clearing_summary_data_set c
inner join country cn on cn.COUNTRY_CODE= c.ISS_COUNTRY_CODE
inner join member_hierarchy mh on mh.CHILD_ICA_CODE = c.ISS_CHILD_ICA_CODE and mh.PARENT_ICA_NAME = 'Parent ICA Name_297'
inner join month m on c.DW_PROCESS_MONTH = m.DW_PROCESS_MONTH
where m.Year_Qtr in ('2020 Q1','2020 Q2')
and cn.COUNTRY_NAME = 'GIBRALTAR'
and c.ACQ_COUNTRY_CODE = c.MERCH_COUNTRY_CODE
and c.ISS_COUNTRY_CODE != c.MERCH_COUNTRY_CODE
group by m.Year_Qtr
, c.ACQ_TRANSIT_ROUTING_ID;