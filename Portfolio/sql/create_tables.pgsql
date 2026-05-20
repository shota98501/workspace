CREATE TABLE customers_2(
id	SERIAL PRIMARY KEY,
signup_date DATE,
country VARCHAR(50)
);

CREATE TABLE products_2(
id	SERIAL PRIMARY KEY,
product_name VARCHAR(100),
category VARCHAR(50)
);

CREATE TABLE orders_2(
id	SERIAL PRIMARY KEY,
customer_id INTEGER NOT NULL REFERENCES customers_2(id),
order_date DATE,
total_amount DECIMAL(10,2)
);

CREATE TABLE order_items_2(
id	SERIAL PRIMARY KEY,
order_id INTEGER NOT NULL REFERENCES orders_2(id),
product_id INTEGER NOT NULL REFERENCES products_2(id),
quantity INTEGER NOT NULL CHECK (quantity > 0),
price NUMERIC(10,2) NOT NULL CHECK (price > 0)
);
