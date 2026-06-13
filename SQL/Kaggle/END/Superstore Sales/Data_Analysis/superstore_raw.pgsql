CREATE TABLE kaggle.superstore_raw (
order_id VARCHAR(50),
order_date DATE,
ship_date DATE,
ship_mode VARCHAR(50),
customer_id VARCHAR(20),
customer_name VARCHAR(50),
segment VARCHAR(50),
country_region VARCHAR(100),
city VARCHAR(100),
state_province VARCHAR(100),
postal_code VARCHAR(20),
region VARCHAR(50),
product_id VARCHAR(50),
category VARCHAR(50),
sub_category VARCHAR(50),
sales NUMERIC(10,2),
quantity INT,
discount NUMERIC(5,2),
profit NUMERIC(10,2)
);

CREATE TABLE kaggle.customers(
customer_id VARCHAR(20) PRIMARY KEY,
customer_name VARCHAR(100),
segment VARCHAR(50)
);


CREATE TABLE kaggle.products(
product_id VARCHAR(50) PRIMARY KEY,
category VARCHAR(50),
sub_category VARCHAR(50)
);


CREATE TABLE kaggle.orders(
    order_id VARCHAR(50) PRIMARY KEY,
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(50),
    customer_id VARCHAR(20),
    country_region VARCHAR(100),
    city VARCHAR(100),
    state_province VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    FOREIGN KEY(customer_id) REFERENCES kaggle.customers(customer_id)
);


CREATE TABLE kaggle.order_items(
    order_item_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id VARCHAR(50),
    product_id VARCHAR(50),
    sales NUMERIC(10,2),
    quantity INT,
    discount NUMERIC(5,2),
    profit NUMERIC(10,2),
    FOREIGN KEY (order_id) REFERENCES kaggle.orders(order_id),
    FOREIGN KEY (product_id) REFERENCES kaggle.products(product_id)
);
