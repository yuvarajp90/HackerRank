-- ###################################################################################################
-- Calculate per region aggregated usage stats on a specific promotion named
-- ‘TestPromo’. How many users, how many trips for each region. And how many
-- percentage of the usage are in the first day of the promotion.
-- ###################################################################################################

select t.region_id
,r.name region_name
,count(distinct t.trip_id) trip_cnt
,count(distinct t.user_id) user_cnt
from
trips t inner join regions r
on t.region_id=r.id
inner join (select promotion_name,start_at,end_at from promotions where promotion_name='TestPromo') p
on t.start_dt between p.start_at and p.end_at 
-- and t.status='completed' --if only completed trips are to be considered
group by t.region_id,r.name
;

-- %usage on the first day of the promotion
select a.*
(
select region_id,started_at
,count(distinct trip_id) trip_cnt
,count(distinct trip_id) / sum(count(distinct trip_id)) over (partition by region_id order by start_dt) pct_trips
,count(distinct user_cnt) user_cnt
,count(distinct user_cnt) / sum(count(distinct user_cnt)) over (partition by region_id order by start_dt) pct_users
from trips
-- and status='completed' --if only completed trips are to be considered
group by region_id,started_at
)a
inner join (select promotion_name,start_at,end_at from promotions where promotion_name='TestPromo') p
on convert(date,a.started_at)=convert(date,p.start_dt)
;
