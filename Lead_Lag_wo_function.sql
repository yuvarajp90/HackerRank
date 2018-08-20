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
