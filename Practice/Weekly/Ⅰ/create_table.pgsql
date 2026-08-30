create table practice.orders(
    order_id INT,
    order_date DATE,
    store VARCHAR(100)
);

create table practice.order_items(
    order_id int,
    product VARCHAR(100),
    quantity int,
    unit_price int
);




