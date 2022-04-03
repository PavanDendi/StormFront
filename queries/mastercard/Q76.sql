select mt.Year_Qtr
, m.PARENT_ICA_NAME
, cn.COUNTRY_NAME
, ag.Merch_Group_Name
, sum(c.CLEARED_NET_TRAN_AMT_EUR)
from clearing_summary_data_set c
inner join agg_merch ag on ag.MERCH_LOCATION_ID = c.MERCH_LOCATION_ID and ag.Merch_Group_Name in ('CASH','RETAIL','SERVICES','T+E')
inner join country cn on c.MERCH_COUNTRY_CODE = cn.COUNTRY_CODE and cn.COUNTRY_CODE = 'DNK'
inner join member_hierarchy m on m.CHILD_ICA_CODE = c.ACQ_CHILD_ICA_CODE and m.PARENT_ICA_NAME = 'Parent ICA Name_87'
inner join month mt on mt.DW_PROCESS_MONTH = c.DW_PROCESS_MONTH and mt.Year = '2020'
group by mt.Year_Qtr, m.PARENT_ICA_NAME, cn.COUNTRY_NAME,ag.Merch_Group_Name;