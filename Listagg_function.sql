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
