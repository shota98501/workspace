DROP TABLE practice.orders;

CREATE TABLE practice.orders(
    order_id VARCHAR(50) NOT NULL,
    category VARCHAR(50),
    order_amount int,
    returned varchar(50)
);