DROP TABLE practice.orders;

CREATE TABLE practice.orders(
    order_id int NOT NULL,
    category VARCHAR(50),
    order_amount int,
    returned varchar(50)
);