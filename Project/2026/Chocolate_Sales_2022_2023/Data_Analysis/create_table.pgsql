DROP TABLE kaggle.chocolatesale_raw;
DROP TABLE kaggle.orders CASCADE;
DROP TABLE kaggle.products CASCADE;
DROP TABLE kaggle.Salesperson CASCADE;
DROP TABLE kaggle.order_items CASCADE;


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
Amount NUMERIC(12,2)
);


CREATE TABLE kaggle.orders(
    Order_id VARCHAR(100) PRIMARY KEY,
    Order_date DATE,
    Country VARCHAR(100),
    Channel VARCHAR(100)
);

CREATE TABLE kaggle.products(
    Product_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Product VARCHAR(100)
);

CREATE TABLE kaggle.Salesperson(
     Salesperson_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     Salesperson VARCHAR(100)
);


CREATE TABLE kaggle.order_items(
    Order_item_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    Order_id VARCHAR(100),
    Product_id INT,
    Salesperson_id INT,
    Discount_PCt NUMERIC(5,2),
    Price_per_Box NUMERIC(5,2),
    Marketing_Spend NUMERIC(5,2),
    Boxes_Shipped NUMERIC(5,2),
    Amount NUMERIC(12,2),
    FOREIGN KEY (Order_id) REFERENCES kaggle.orders(Order_id),
    FOREIGN KEY (Product_id) REFERENCES kaggle.products(Product_id),
    FOREIGN KEY (Salesperson_id) REFERENCES kaggle.Salesperson(Salesperson_id)
);






