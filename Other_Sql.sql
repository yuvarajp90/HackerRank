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


--Find cases where there are only entry. Example: Find all the instructors that taught at most one course in the year 2017.
SELECT I.EMPLOYEEID, I.NAME
FROM Instructor as I
WHERE UNIQUE (SELECT Inst.EMPLOYEEID
              FROM Instructor as Inst
              WHERE I.EMPLOYEEID = Inst.EMPLOYEEID
                          and Inst.YEAR = 2017);

--How to concatenate values in a column either as comma-separated or someother delimiter
SELECT LISTAGG(col, ' , ') WITHIN GROUP (ORDER BY col) AS SUBJECTS
FROM   table ;

SELECT col1, LISTAGG(col2, ' , ') WITHIN GROUP (ORDER BY col2) AS SUBJECTS
FROM   table
GROUP BY col1;
--Hive equivalent of listagg is collect_set,collect_list,group_concat

--Using Exist and Not Exist in place of IN and NOT IN
SELECT fname, lname 
FROM Customers 
WHERE EXISTS (SELECT * 
              FROM Orders 
              WHERE Customers.customer_id = Orders.c_id);

SELECT lname, fname
FROM Customer
WHERE NOT EXISTS (SELECT * 
                  FROM Orders 
                  WHERE Customers.customer_id = Orders.c_id);



