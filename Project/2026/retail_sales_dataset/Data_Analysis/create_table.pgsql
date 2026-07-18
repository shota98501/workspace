DROP TABLE kaggle.retailsale_raw;

CREATE TABLE kaggle.retailsale_raw(
    transaction_id INT,
    order_date date,
    customer_id VARCHAR(100),
    gender VARCHAR(100),
    age INT,
    products VARCHAR(100),
    quantity INT,
    price_per_unit INT,
    total_amount INT
);
