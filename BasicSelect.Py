--Q1
--Query all columns for all American cities in CITY with populations larger than 100000. The CountryCode for America is USA.
select * from city where population > 100000 and countrycode='USA'

--Q2
--Query all columns for all American cities in CITY with populations larger than 120000. The CountryCode for America is USA.
select name as city from city where population > 120000 and countrycode='USA'

--Q3
--Query all columns (attributes) for every row in the CITY table.
select * from city

--Q4
--Query all columns for a city in CITY with the ID 1661.
select * from city where id=1661

--Q5
--Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.
select * from city where countrycode='JPN'

--Q6
--Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.
select name as city from city where countrycode='JPN'

--Q7
--Query a list of CITY and STATE from the STATION table.
select city, state from station

--Q8
--Query a list of CITY names from STATION with even ID numbers only, exclude duplicates from your answer.
select distinct city from station where id%2=0

--Q9
--Let N be the number of CITY entries in STATION, and let N' be the number of distinct CITY names in STATION; query the value of N-N' from STATION
select count(city) - count(distinct city) from station

--Q10
--Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.

--option1
select city, length(city) from station order by length(city),city limit 1;
select city, length(city) from station order by length(city) desc,city limit 1;

--option2
select min(city), len
  from (
        select city, length(city) len,
               max(length(city)) over() maxlen,
               min(length(city)) over() minlen
          from station
       )
 where len in(minlen,maxlen)
 group by len

--Q11
--Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
select distinct city from station where left(city,1) in ('a','e','i','o','u')

--Q12
--Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
select distinct city from station where right(city,1) in ('a','e','i','o','u')

--Q13
--Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters
select distinct city from station where left(city,1) in ('a','e','i','o','u') and right(city,1) in ('a','e','i','o','u')

--Q14
--Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
select distinct city from station where left(city,1) not in ('a','e','i','o','u')

--Q15
--Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
select distinct city from station where right(city,1) not in ('a','e','i','o','u')

--Q16
--Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. No duplicates
select distinct city from station where right(city,1) not in ('a','e','i','o','u') or left(city,1) not in ('a','e','i','o','u')

--Q17
--Query the list of CITY names from STATION that  do not start or end with vowels. No duplicates
select distinct city from station where right(city,1) not in ('a','e','i','o','u') and left(city,1) not in ('a','e','i','o','u')

--Q18
--Query the Name of any student in STUDENTS who scored higher than 75 Marks. Order your output by the last three characters of each ---name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.
select name from students where marks > 75 order by right(name,3),id

--Q19
--Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.
select name from employee order by name

--Q20
--Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater 2000 than per month who have been employees for less than 10 months. Sort your result by ascending employee_id.
select name from employee where salary>2000 and months<10

--Q21
--Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table: 
--Equilateral: It's a triangle with  sides of equal length. 
--Isosceles: It's a triangle with  sides of equal length. 
--Scalene: It's a triangle with  sides of differing lengths. 
--Not A Triangle: The given values of A, B, and C don't form a triangle.
