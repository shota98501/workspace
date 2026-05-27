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

CREATE TABLE kaggle.customers();
CREATE TABLE kaggle.products();
CREATE TABLE kaggle.orders();
CREATE TABLE kaggle.order_items();