  -- 1) Write a SQL statement which returns the customer_Ids that have purchased both movie_Ids P1 & P5.
  
select customer_id,count(distinct movie_id) movie_cnt
from orders
where movie_id in ('P1','P5')
group by customer_id
having movie_cnt=2
;

-- OR

select distinct t1.customer_id
from 
orders t1 inner JOIN orders t2 
on t1.customer_id=t2.customer_id
where t1.movie_id = 'P1' 
and t2.movie_id = 'P5'
;
