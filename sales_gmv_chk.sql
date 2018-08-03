select
to_date(so.src_sts_chng_dt) as order_fulfilled_dt
,sum(cast(spo.line_tot_amt as decimal(18,2))) as fulfilled_gmv
,count(distinct spo.sales_order_num) fulfilled_order_cnt
,sum(coalesce(spo.actl_po_qty,0)) fulfilled_order_qty
from walmart_us_dotcom.sales_order so 
inner join walmart_us_dotcom.sales_order_line sol 
on so.sales_order_num = sol.sales_order_num
inner join walmart_us_dotcom.sales_po_line spo 
on sol.sales_order_line_num = spo.sales_order_line_num 
and sol.sales_order_num = spo.sales_order_num 
and sol.tenant_org_id=spo.tenant_org_id 
where sol.svc_id in ('19', '20')
and sol.tenant_org_id = 4571
and so.order_placed_dt >= date_sub('2018-01-05' , 10)
and sol.order_placed_dt >= date_sub('2018-01-05' , 10)
and to_date(so.src_sts_chng_dt) between '2017-12-28' and '2018-01-05'
AND so.og_items_ind = 1
AND so.src_sts_chng_ts IS NOT NULL
and so.CURR_STS_ID in ('81','637','895','896','897','898','899','1003','1004','1005','1006','1007','1008','1355','1359','1360','1364','1365','1395','1408','1415','1420')
group by so.src_sts_chng_dt
;

---tab code
select so.sales_order_num,
to_date(so.src_sts_chng_dt) as order_fulfilled_dt
,sum(cast(spo.line_tot_amt as decimal(18,2))) as fulfilled_gmv
,count(distinct spo.sales_order_num) fulfilled_order_cnt
,sum(coalesce(spo.actl_po_qty,0)) fulfilled_order_qty
from walmart_us_dotcom.sales_order so 
inner join walmart_us_dotcom.sales_order_line sol 
on so.sales_order_num = sol.sales_order_num
inner join walmart_us_dotcom.sales_po_line spo 
on sol.sales_order_line_num = spo.sales_order_line_num 
and sol.sales_order_num = spo.sales_order_num 
and sol.tenant_org_id=spo.tenant_org_id 
where 
so.sales_order_num in ('7622178661191','7624178602429','7624178602433','7624178602435','7624178602441','7624178602443','7624178602445','7624178602448','7624178602451','7624178602454') 
group by so.sales_order_num, so.src_sts_chng_dt
;

--so
select sales_order_num, order_placed_dt,src_sts_chng_dt
,sum(cast(tot_amt as decimal(18,2))),sum(cast(tax_amt as decimal(18,2)))
from walmart_us_dotcom.SALES_ORDER
where sales_order_num in ('7622178661191','7624178602429','7624178602433','7624178602435','7624178602441','7624178602443','7624178602445','7624178602448','7624178602451','7624178602454') 
group by sales_order_num, order_placed_dt,src_sts_chng_dt

--gpa_Sol
select sales_order_num, order_placed_dt
,sum(cast(placed_gmv as decimal(18,2))),sum(qty) as order_qty
from gpadata_analytics.gpa_sales_order_line_v
where sales_order_num in ('7622178661191','7624178602429','7624178602433','7624178602435','7624178602441','7624178602443','7624178602445','7624178602448','7624178602451','7624178602454') 
group by sales_order_num, order_placed_dt

--sol
SELECT sales_order_num, order_placed_dt, src_sts_upd_dt, SUM(line_tot_amt),sum(qty)
FROM walmart_us_dotcom.SALES_ORDER_LINE
where sales_order_num in ('7622178661191','7624178602429','7624178602433','7624178602435','7624178602441','7624178602443','7624178602445','7624178602448','7624178602451','7624178602454') 
group by sales_order_num, order_placed_dt, src_sts_upd_dt

--spo
SELECT sales_order_num, sum(cast(line_tot_amt as decimal(18,2))),sum(coalesce(actl_po_qty,0))
FROM walmart_us_dotcom.SALES_po_LINE
where sales_order_num in ('7622178661191','7624178602429','7624178602433','7624178602435','7624178602441','7624178602443','7624178602445','7624178602448','7624178602451','7624178602454') 
group by sales_order_num

---so vs spo
select to_date(so.src_sts_chng_dt) as order_fulfilled_dt
,sum(cast(so.tot_amt as decimal(18,2))), sum(cast(so.tax_amt as decimal(18,2)))
,sum(cast(spo.line_tot_amt as decimal(18,2))) as fulfilled_gmv
,count(distinct spo.sales_order_num) fulfilled_order_cnt
,sum(coalesce(spo.actl_po_qty,0)) fulfilled_order_qty, sum(coalesce(sol.qty,0))
from walmart_us_dotcom.sales_order so 
inner join walmart_us_dotcom.sales_order_line sol 
on so.sales_order_num = sol.sales_order_num
inner join walmart_us_dotcom.sales_po_line spo 
on sol.sales_order_line_num = spo.sales_order_line_num 
and sol.sales_order_num = spo.sales_order_num 
and sol.tenant_org_id=spo.tenant_org_id 
where sol.svc_id in ('19', '20')
and so.tenant_org_id = 4571 and sol.tenant_org_id = 4571
and so.order_placed_dt >= date_sub('2017-12-31' , 10)
and sol.order_placed_dt >= date_sub('2017-12-31' , 10)
and to_date(so.src_sts_chng_dt) between '2017-12-28' and '2018-01-05'
AND so.og_items_ind = 1
AND so.src_sts_chng_ts IS NOT NULL
and so.CURR_STS_ID in ('81','637','895','896','897','898','899','1003','1004','1005','1006','1007','1008','1355','1359','1360','1364','1365','1395','1408','1415','1420')
group by src_sts_chng_dt

--only so
select to_date(so.src_sts_chng_dt) as order_fulfilled_dt
,sum(cast(so.tot_amt as decimal(18,2))), sum(cast(so.tax_amt as decimal(18,2)))
from walmart_us_dotcom.sales_order so 
where 1=1
and so.tenant_org_id = 4571
and so.order_placed_dt >= date_sub('2017-12-31' , 10)
and to_date(so.src_sts_chng_dt) between '2017-12-28' and '2018-01-05'
AND so.og_items_ind = 1
AND so.src_sts_chng_ts IS NOT NULL
and so.CURR_STS_ID in ('81','637','895','896','897','898','899','1003','1004','1005','1006','1007','1008','1355','1359','1360','1364','1365','1395','1408','1415','1420')
group by src_sts_chng_dt

---so vs spo
select to_date(so.src_sts_chng_dt) as order_fulfilled_dt
,sum(cast(so.tot_amt as decimal(18,2))), sum(cast(so.tax_amt as decimal(18,2)))
,count(distinct so.sales_order_num) fulfilled_order_cnt
,sum(coalesce(sol.qty,0))
from walmart_us_dotcom.sales_order so 
inner join walmart_us_dotcom.sales_order_line sol 
on so.sales_order_num = sol.sales_order_num
where sol.svc_id in ('19', '20')
and so.tenant_org_id = 4571 and sol.tenant_org_id = 4571
and so.order_placed_dt >= date_sub('2017-12-31' , 10)
and sol.order_placed_dt >= date_sub('2017-12-31' , 10)
and to_date(so.src_sts_chng_dt) between '2017-12-28' and '2018-01-05'
AND so.og_items_ind = 1
AND so.src_sts_chng_ts IS NOT NULL
and so.CURR_STS_ID in ('81','637','895','896','897','898','899','1003','1004','1005','1006','1007','1008','1355','1359','1360','1364','1365','1395','1408','1415','1420')
group by src_sts_chng_dt

select
coalesce(dev.device_type, 'Web: Unknown') as device_type
,(
case 
when sol.fulfmt_type_id = 6 then 'Pickup'
when sol.fulfmt_type_id = 7 then 'Delivery'
when sol.fulfmt_type_id = 8 then 'Express Pickup'
when sol.fulfmt_type_id = 9 then 'Express Delivery'
else 'Other'
end) as pickup_type
,sum(so.tot_amt) as fulfilled_gmv
,count(distinct so.sales_order_num) as fulfilled_order_cnt
,sum(coalesce(sol.qty,0)) as fulfilled_order_qty
,to_date(so.src_sts_chng_dt) as order_fulfilled_dt
from
walmart_us_dotcom.sales_order so
inner join
(
select distinct sales_order_num, fulfmt_type_id, sum(qty) as qty
from walmart_us_dotcom.sales_order_line
where tenant_org_id = 4571
and svc_id in ('19', '20')
and order_placed_dt >= date_sub('2017-12-31' , 10)
)sol
on so.sales_order_num = sol.sales_order_num
left join vn0nfh2.tab_og_order_device_map dev 
on dev.order_id = so.sales_order_num
where so.tenant_org_id = 4571
and so.order_placed_dt >= date_sub('2017-12-31' , 10)
and to_date(so.src_sts_chng_dt) between '2017-12-28' and '2018-01-05'
AND so.og_items_ind = 1
AND so.src_sts_chng_ts IS NOT NULL
and so.CURR_STS_ID in ('81','637','895','896','897','898','899','1003','1004','1005','1006','1007','1008','1355','1359','1360','1364','1365','1395','1408','1415','1420')
group by 1,2,6
;


select
(
case 
when sol.fulfmt_type_id = 6 then 'Pickup'
when sol.fulfmt_type_id = 7 then 'Delivery'
when sol.fulfmt_type_id = 8 then 'Express Pickup'
when sol.fulfmt_type_id = 9 then 'Express Delivery'
else 'Other'
end) as pickup_type
,sum(so.tot_amt) as fulfilled_gmv
,count(distinct so.sales_order_num) as fulfilled_order_cnt
,sum(coalesce(sol.qty,0)) as fulfilled_order_qty
,to_date(so.src_sts_chng_dt) as order_fulfilled_dt
from
walmart_us_dotcom.sales_order so
inner join
(
select sales_order_num, fulfmt_type_id, sum(qty) as qty
from walmart_us_dotcom.sales_order_line
where tenant_org_id = 4571
and svc_id in ('19', '20')
and order_placed_dt >= date_sub('2017-12-31' , 10)
group by 1,2
)sol
on so.sales_order_num = sol.sales_order_num
where so.tenant_org_id = 4571
and so.order_placed_dt >= date_sub('2017-12-31' , 10)
and to_date(so.src_sts_chng_dt) between '2017-12-28' and '2018-01-05'
AND so.og_items_ind = 1
AND so.src_sts_chng_ts IS NOT NULL
and so.CURR_STS_ID in ('81','637','895','896','897','898','899','1003','1004','1005','1006','1007','1008','1355','1359','1360','1364','1365','1395','1408','1415','1420')
group by 1,5
;