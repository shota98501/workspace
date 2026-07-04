DROP TABLE kaggle.chocolatesale_raw;
DROP TABLE kaggle.products CASCADE;
DROP TABLE kaggle.order_items CASCADE;
DROP TABLE kaggle.orders CASCADE;

Create TABLE kaggle.chocolatesale_raw(
Order_id VARCHAR(100),
Product VARCHAR(100),
Country VARCHAR(100),
Channel VARCHAR(100),
Salesperson VARCHAR(100),
Order_date DATE,
Discount_PCt NUMERIC(5,2),
Price_per_Box NUMERIC(5,2),
Marketing_Spend NUMERIC(5,2),
Boxes_Shipped NUMERIC(5,2),
Amount NUMERIC(7,2)
);


CREATE TABLE kaggle.orders(
    Order_id VARCHAR(100) PRIMARY KEY,
    Order_date DATE,
    Country VARCHAR(100),
    Channel VARCHAR(100)
);

CREATE TABLE kaggle.order_items(
    Order_id VARCHAR(100),
    Discount_PCt NUMERIC(5,2),
    Price_per_Box NUMERIC(5,2),
    Marketing_Spend NUMERIC(5,2),
    Boxes_Shipped NUMERIC(5,2),
    Amount NUMERIC(7,2),
    FOREIGN KEY (Order_id) REFERENCES kaggle.orders(Order_id)
);

CREATE TABLE kaggle.products(
    Product VARCHAR(100),
    Salesperson VARCHAR(100)
);



