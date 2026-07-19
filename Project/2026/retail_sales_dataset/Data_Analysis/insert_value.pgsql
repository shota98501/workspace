INSERT INTO kaggle.orders(order_date)
SELECT DISTINCT
    order_date
FROM kaggle.retailsale_raw;


INSERT INTO kaggle.products(products)
SELECT DISTINCT
    products
FROM kaggle.retailsale_raw;


INSERT INTO kaggle.customers(customer_id, gender, age)
SELECT DISTINCT
    customer_id,
    gender,
    age
FROM kaggle.retailsale_raw;


INSERT INTO kaggle.order_items(quantity,price_per_unit,total_amount)
SELECT DISTINCT
quantity,
price_per_unit,
total_amount
FROM kaggle.retailsale_raw;