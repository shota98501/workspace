DROP TABLE IF EXISTS practice.customers;
DROP TABLE IF EXISTS practice.categories;
DROP TABLE IF EXISTS practice.products;
DROP TABLE IF EXISTS practice.orders;
DROP TABLE IF EXISTS practice.order_items;

CREATE TABLE practice.customers (
customer_id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL.
last_name VARCHAR(50) NOT NULL,
email VARCHAR(50) UNIQUE NOT NULL,
city VARCHAR(50),
signup_date DATE NOT NULL
);


