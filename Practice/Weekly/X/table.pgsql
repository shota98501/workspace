create table practice.stations(
station_id VARCHAR(50),
station_name VARCHAR(50)
);

CREATE table practice.rides(
    ride_id VARCHAR(50),
    station_id VARCHAR(50),
    duration_minutes int,
    fare int
);