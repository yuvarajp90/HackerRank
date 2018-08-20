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

--Q6
--Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. Order your output in descending order by the total number of challenges in which the hacker earned a full score. If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.

select z.hacker_id,h.name
from
(
select s.hacker_id
,case when s.score=d.score then 'Full' else 'Partial' end flag
,count(distinct s.challenge_id) cnt
from
submissions s
left join challenges c 
on s.challenge_id=c.challenge_id
left join difficulty d
on c.difficulty_level=d.difficulty_level
group by s.hacker_id,flag
)z
left join hackers h on z.hacker_id=h.hacker_id
where z.flag='Full' and z.cnt >1
order by cnt desc, hacker_id asc
;
             
--Q7
--Julia asked her students to create some coding challenges. Write a query to print the hacker_id, name, and the total number of challenges created by each student. Sort your results by the total number of challenges in descending order. If more than one student created the same number of challenges, then sort the result by hacker_id. If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.

select h.hacker_id,h.name,count(distinct c.challenge_id) cnt
from 
hackers h inner join challenges c
on h.hacker_id=c.hacker_id
group by h.hacker_id,h.name
having 
cnt=(select max(cnt) from 
        (select hacker_id,count(distinct challenge_id) cnt from challenges group by hacker_id) a
    )
or
cnt in ( select cnt from 
					(select cnt, count(distinct hacker_id) hack_cnt from
							(select hacker_id,count(distinct challenge_id) cnt from challenges group by hacker_id) a
            group by cnt
            having hack_cnt=1
         )b
            )
order by cnt desc, hacker_id
;

--Q8
--The total score of a hacker is the sum of their maximum scores for all of the challenges. Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. Exclude all hackers with a total score of  from your result.

select a.hacker_id,h.name,sum(a.max_score) score
from
(
select hacker_id,challenge_id,max(score) max_score
from submissions
group by hacker_id,challenge_id
)a
inner join
hackers h
on a.hacker_id=h.hacker_id
group by hacker_id,h.name
having score>0
order by score desc, hacker_id

--Q9
--Write a query to output the names of those students whose best friends got offered a higher salary than them. Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer
select z.name
from
(
	select a.*, p.salary as friend_salary
	from
	(
		select s.id,s.name,p.salary,f.friend_id
		from students s inner join friends f on s.id=f.id
		left join packages p on s.id=p.id
		) a
	inner join packages p on f.id=p.id
	) z
	where z.friend_salary>=z.salary
	order by z.friend_salary
;

--Q10
select c.company_code,c.founder
,count(distinct lm.lead_manager_code)
,count(distinct sm.senior_manager_code)
,count(distinct m.manager_code)
,count(distinct e.employee_code)
from
company c
left join lead_manager lm on c.company_code=lm.company_code
left join senior_manager sm on lm.company_code=sm.company_code and lm.lead_manager_code=sm.lead_manager_code
left join manager m on sm.company_code=m.company_code and sm.lead_manager_code=m.lead_manager_code and sm.senior_manager_code=m.senior_manager_code
left join employee e on m.company_code=e.company_code and m.lead_manager_code=e.lead_manager_code and m.senior_manager_code=e.senior_manager_code and m.manager_code=e.manager_code
group by c.company_code,c.founder
order by c.company_code asc
;
             
--Q11
--Find the median without using any function
--option1
select round(s.lat_n,4) median
from station s
where (select count(lat_n) from station where lat_n>s.lat_n)=(select count(lat_n) from station where lat_n<s.lat_n)

--option2
SELECT round(AVG(t1.lat_n),4)
FROM station t1, station t2
GROUP BY t1.lat_n
HAVING SUM(SIGN(t1.lat_n - t2.lat_n))=0

--Q12
--Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. If there is more than one project that have the same number of completion days, then order by the start date of the project.
select start_date,min(end_date)
from
(select distinct start_date from projects where start_date not in (select distinct end_date from projects))a
,(select distinct end_date from projects where end_date not in (select distinct start_date from projects))b
where start_date<end_date
group by start_date
order by datediff(min(end_date),start_date),start_date
                                                                
--Q13
--How to find symmetric entries
select x,y from functions where x=y group by x,y having count(*)>1
UNION
SELECT f1.X, f1.Y FROM Functions AS f1, Functions AS f2
WHERE f1.X <> f1.Y AND f1.X = f2.Y AND f1.Y = f2.X AND f1.X < f2.X
ORDER BY X;

--Q14
--Alternative to using window function like lead or lag
--Ask is to find those dates where the current temp is greater than the previous days temparature
SELECT
    weather.id AS 'Id'
FROM
    weather
        JOIN
    weather w ON DATEDIFF(weather.date, w.date) = 1
        AND weather.Temperature > w.Temperature
;


--Q15
--Mary is a teacher in a middle school and she has a table seat storing students' names and their corresponding seat ids. The column id is continuous increment. Mary wants to change seats for the adjacent students.

SELECT
    (CASE
        WHEN MOD(id, 2) != 0 AND counts != id THEN id + 1
        WHEN MOD(id, 2) != 0 AND counts = id THEN id
        ELSE id - 1
    END) AS id,
    student
FROM
    seat,
    (SELECT
        COUNT(*) AS counts
    FROM
        seat) AS seat_counts
ORDER BY id ASC;

--Q16
--Rank a column w/o using window function

SELECT
  Score,
  (SELECT count(distinct Score) FROM Scores WHERE Score >= s.Score) Rank
FROM Scores s
ORDER BY Score desc

--Q17
--Write a SQL query to find all numbers that appear at least three times consecutively

SELECT DISTINCT
    l1.Num AS ConsecutiveNums
FROM
    Logs l1,
    Logs l2,
    Logs l3
WHERE
    l1.Id = l2.Id - 1
    AND l2.Id = l3.Id - 1
    AND l1.Num = l2.Num
    AND l2.Num = l3.Num
;
