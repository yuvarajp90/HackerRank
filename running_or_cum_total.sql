select
    date,
    sum(sales) over (order by date rows unbounded preceding) as cumulative_sales
from sales_table;
