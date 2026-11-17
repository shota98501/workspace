select * from practice.practice_bike_hours
LIMIT 10;

--Return one row per week and station. 

SELECT 
service_date,
station
FROM practice.practice_bike_hours
WHERE EXTRACT(ISODOW FROM service_date) IN (6, 7);

--Show weekday morning departures, 
--total weekday morning departures across the network for that week, and the station’s percentage share of that total.
--Rank stations within each week by departures, giving ties the same rank. 
--Add the change in share from the previous week in percentage points.