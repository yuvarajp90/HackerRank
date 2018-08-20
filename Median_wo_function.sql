--option1
select round(s.lat_n,4) median
from station s
where (select count(lat_n) from station where lat_n>s.lat_n)=(select count(lat_n) from station where lat_n<s.lat_n)

--option2
SELECT round(AVG(t1.lat_n),4)
FROM station t1, station t2
GROUP BY t1.lat_n
HAVING SUM(SIGN(t1.lat_n - t2.lat_n))=0
