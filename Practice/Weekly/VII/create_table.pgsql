CREATE TABLE practice.products(
    product_id VARCHAR(50),
    product_name VARCHAR(50),
    category VARCHAR(50),
    stock_quantity INT
);

CREATE TABLE practice.sales(
    sale_id VARCHAR(50),
    product_id VARCHAR(50),
    quantity INT
);

