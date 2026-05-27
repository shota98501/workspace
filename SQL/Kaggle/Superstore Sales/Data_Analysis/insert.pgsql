INSERT INTO kaggle.customers
SELECT DISTINCT
    customer_id,
    customer_name,
    segment
FROM kaggle.superstore_raw;

INSERT INTO kaggle.products
SELECT DISTINCT
    product_id,
    category,
    sub_category
FROM kaggle.superstore_raw;

INSERT INTO kaggle.orders
SELECT DISTINCT ON (order_id)
    order_id,
    order_date,
    ship_date,
    ship_mode,
    customer_id,
    country_region,
    city,
    state_province,
    postal_code,
    region
FROM kaggle.superstore_raw
ORDER BY order_id, order_date;

INSERT INTO kaggle.order_items (
    order_id,
    product_id,
    sales,
    quantity,
    discount,
    profit
)
SELECT
    order_id,
    product_id,
    sales,
    quantity,
    discount,
    profit
FROM kaggle.superstore_raw;