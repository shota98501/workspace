DROP TABLE practice.restaurants;
drop table practice.deliveries;

create table practice.restaurants(
    restaurant_id VARCHAR(50),
    restaurant_name VARCHAR(50),
    area VARCHAR(50)
);

create table practice.deliveries(
    order_id VARCHAR(50),
    restaurant_id VARCHAR(50),
    delivery_minutes INT,
    promised_minutes INT,
    revenue INT
); 