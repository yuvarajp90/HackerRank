-- Write a SQL statement which can generate the list of customers whose minutes streamed is consistently less than the previous mintues streamed
-- As in minutes streamed in the nth order is less than minutes streamed in n-1 th order, and the next previous order is also less. 
-- Another way to say it, list the customers that watch less and less minutes each time they watch a movie.

-- list of customers whose streaming time is continuously declining

select a.customer_id
from
(
select a.*
,lag(minutes_streamed,1) over (partition by customer_id order by purchase_date) as prev_ms
from orders a
order by customer_id,purchase_date
)a
group by a.customer_id
having sum(case when prev_ms is null or prev_ms > minutes_streamed then 0 else 1 end)=0
