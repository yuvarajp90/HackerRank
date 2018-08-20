--for column level min and max
select min(col),max(col) from table;

--for row level
select least(col1,col2), greatest(col1,col2) from table;

--Hive equivalent of least and greatest
select sort_array(col1,col2)[0] as least,
sory_array(col1,col2)[1] as greatest
from table
;
