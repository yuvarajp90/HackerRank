with user_cohort as (
select user_id, min(convert(date,created_at)) as cohort
from users
group by user_id
),
cohort_size as (
select concat(year(cohort),month(cohort)) cohort_grp, count(distinct user_id) as num_users
from user_chort
group by 1
order by 1
)

select t1.cohort_grp, t1.num_users, t2.mnth_diff, count(distinct t2.user_id) mnthly_active_users
from cohort_size t1
left join
(
select distinct a.user_id, DATEDIFF(MONTH, b.cohort, convert(date,a.created_at)) mnth_diff, concat(year(b.cohort),month(b.cohort)) cohort_grp
from trips a
left join user_cohort b
on a.user_id=b.user_id
)t2
on t1.cohort_grp=t2.cohort.grp
group by 1,2,3
;
