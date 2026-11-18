--Return one row per week and station. 
SELECT
date_trunc('week',service_date)::date as week_start,
station
from practice.practice_bike_hours;

--Show weekday morning departures, 
SELECT
service_date,
hour
from practice.practice_bike_hours
where EXTRACT(ISODOW from service_date) not in (6,7)
and hour >= 7 AND hour < 100;

--total weekday morning departures across the network for that week, and the station’s percentage share of that total.
with weekly_station as (
    SELECT
    date_trunc('week', service_date)::date as week_start,
    station,
    sum(departures) as morning_departures
    from practice.practice_bike_hours
    WHERE extract(isodow from service_date) BETWEEN 1 and 5
    and hour >=7
    and hour < 10
    GROUP BY
    date_trunc('week', service_date)::date,
    station
),
with_network as (
    SELECT
    *,
    sum(morning_departures) over (
        PARTITION by week_start
    ) as network_morning_departures
    from weekly_station
),
with_share as (
    SELECT
    *,
    100.0 * morning_departures
    / NULLIF(network_morning_departures, 0) as share_pct
    from with_network
)
SELECT
    week_start,
    station,
    morning_departures,
    network_morning_departures,
    ROUND(share_pct, 2) AS share_pct,
    DENSE_RANK() OVER (
        PARTITION BY week_start
        ORDER BY morning_departures DESC
    ) AS station_rank,
    ROUND(
        share_pct - LAG(share_pct) OVER (
            PARTITION BY station
            ORDER BY week_start
        ),
        2
    ) AS share_change_pp
FROM with_share
ORDER BY week_start, station_rank, station;


--Rank stations within each week by departures, giving ties the same rank. 
--Add the change in share from the previous week in percentage points.