-- Query all columns for all American cities in CITY with populations larger than 100000. The CountryCode for America is USA.

select *
from city
where population > 100000
and countrycode='USA'

-- Query all columns for all American cities in CITY with populations larger than 120000. The CountryCode for America is USA.

select name as city
from city
where population > 120000
and countrycode='USA'

-- Query all columns (attributes) for every row in the CITY table.

select * from city

-- Query all columns for a city in CITY with the ID 1661.
