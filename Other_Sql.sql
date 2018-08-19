--how to find max, min w/o using the aggregate functions

--max
SELECT DISTINCT Numbers
FROM Compare
WHERE Numbers NOT IN (
SELECT Smaller.Numbers
FROM Compare AS Larger
JOIN Compare AS Smaller ON Smaller.Numbers < Larger.Numbers
)

--min
SELECT DISTINCT Numbers
FROM Compare
WHERE Numbers NOT IN (
SELECT Smaller.Numbers
FROM Compare AS Larger
JOIN Compare AS Smaller ON Smaller.Numbers > Larger.Numbers
)

--Find the nth highest salary
SELECT *
FROM Employee Emp1
WHERE (1) = (
SELECT COUNT(DISTINCT(Emp2.Salary))
FROM Employee Emp2
WHERE Emp2.Salary > Emp1.Salary)

--Find the nth highest salary using the TOP keyword
SELECT TOP 1 Salary
FROM (
      SELECT DISTINCT TOP N Salary
      FROM Employee
      ORDER BY Salary DESC
      ) AS Emp
ORDER BY Salary

--Find the nth highest salary in MySQL
SELECT Salary FROM Employee 
ORDER BY Salary DESC LIMIT n-1,1

--Find the nth highest salary in Oracle using rownum
select * from (
  select Emp.*, 
row_number() over (order by Salary DESC) rownumb 
from Employee Emp
)
where rownumb = n

--Find the nth highest salary in Oracle using RANK
select * FROM (
select EmployeeID, Salary
,rank() over (order by Salary DESC) ranking
from Employee
)
WHERE ranking = N

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
