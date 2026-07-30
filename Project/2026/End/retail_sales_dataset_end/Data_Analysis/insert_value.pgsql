INSERT INTO kaggle.orders(order_date)
SELECT
    order_date
FROM kaggle.retailsale_raw;


INSERT INTO kaggle.products(products)
SELECT 
    products
FROM kaggle.retailsale_raw;


INSERT INTO kaggle.customers(customer_id, gender, age)
SELECT 
    customer_id,
    gender,
    age
FROM kaggle.retailsale_raw;


INSERT INTO kaggle.order_items(
    order_id,
    transaction_id,
    customer_id,
    quantity,
    price_per_unit,
    total_amount)
SELECT
o.order_id,
p.transaction_id,
r.customer_id,
r.quantity,
r.price_per_unit,
r.total_amount
FROM kaggle.retailsale_raw r
JOIN kaggle.orders o
ON r.order_date = o.order_date
JOIN kaggle.products p
ON r.products = p.products;