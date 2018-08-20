--HIVE random sampling
select * from my_table
where rand() <= 0.0001
distribute by rand()
sort by rand()
limit 10000;

--SQL random sampling
select * from my_table
where rand() <= 0.0001
limit 10000;



