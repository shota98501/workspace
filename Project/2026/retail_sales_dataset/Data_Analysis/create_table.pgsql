DROP TABLE kaggle.retailsale_raw;
DROP TABLE kaggle.orders CASCADE;
DROP TABLE kaggle.products CASCADE;
DROP TABLE kaggle.customers CASCADE;
DROP TABLE kaggle.order_items CASCADE;



CREATE TABLE kaggle.retailsale_raw(
    order_id INT,
    transaction_id INT,
    order_date DATE,
    customer_id VARCHAR(100),
    gender VARCHAR(100),
    age INT,
    products VARCHAR(100),
    quantity INT,
    price_per_unit INT,
    total_amount INT
);

CREATE TABLE kaggle.orders(
    order_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_date date
);



CREATE TABLE kaggle.products(
    transaction_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    products VARCHAR(100)

);



CREATE TABLE kaggle.customers(
    customer_id VARCHAR(100) PRIMARY KEY,
    gender VARCHAR(100),
    age INT
);



CREATE TABLE kaggle.order_items(
    order_item_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    order_id INT REFERENCES kaggle.orders(order_id),
    transaction_id INT REFERENCES kaggle.products(transaction_id),
    customer_id VARCHAR(100) REFERENCES kaggle.customers(customer_id),
    quantity INT,
    price_per_unit INT,
    total_amount INT
);