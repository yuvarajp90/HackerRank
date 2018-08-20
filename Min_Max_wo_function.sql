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
