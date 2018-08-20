--Q1
--Generate the following two result sets
--Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
--Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format: There are a total of [occupation_count] [occupation]s. where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.

select concat(name,'(',upper(left(occupation,1)),')') from occupations order by name;

select concat("There are a total of ", count(Occupation), " ", lower(occupation), "s.") from occupations group by Occupation order by count(Occupation),occupation;
                             
--Q2
--Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:
--Root: If node is root node. Leaf: If node is leaf node. Inner: If node is neither root nor leaf node.
                             
select n,
case 
when p='null' or p is null then 'Root'
when n in (select distinct p from bst) then 'Inner'
else 'Leaf' end
from bst
order by n

--Q3
--Query the Manhattan Distance between points p1 and p1 and round it to a scale of 4 decimal places
select round(abs(min(lat_n)-max(lat_n))+abs(min(long_w)-max(long_w)),4) from station;
                                            
--Q4
--Query the euclidean Distance between points p1 and p1 and round it to a scale of 4 decimal places
select round(sqrt((power((max(lat_n)-min(lat_n)),2) + power((max(long_w)-min(long_w)),2))),4) from station;
             
--Q5
--Generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.
                                            
select case when b.grade >7 then a.name else null end as name,b.grade,a.marks
from students a
left join
grades b
on a.marks between b.min_mark and b.max_mark
order by grade desc, name asc, marks asc

