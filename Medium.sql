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
