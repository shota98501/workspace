select * from practice.stations;
select * from practice.rides;

--total rides
SELECT
count(ride_id) as total_rides
from practice.rides;

--average ride duration
SELECT
round(avg(duration_minutes)) as average_ride_duration
FROM practice.rides;

--rides longer than 30 minutes
SELECT
ride_id,
duration_minutes
from practice.rides
WHERE duration_minutes > '30';

--percentage of rides longer than 30 minutes
SELECT
ride_id,
(count(case when duration_minutes > '30' then 1 end) * 100.0) / count(*) as average_duration_minutes
from practice.rides
GROUP BY ride_id;

--total fare revenue
SELECT
sum(fare) as fare_revenue
from practice.rides;