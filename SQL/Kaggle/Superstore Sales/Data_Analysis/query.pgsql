--Total Sales
SELECT
SUM(sales) as total_sales
FROM kaggle.order_items;

--Total Profit
SELECT
SUM(profit) as total_profit
FROM kaggle.order_items;

--Total Orders
SELECT
count(order_id) as total_orders
from kaggle.orders;

--Total Customers
SELECT
count(customer_id) as total_customers
from kaggle.customers;


SELECT
    DATE_TRUNC('month', o.order_date) AS month,
    SUM(oi.sales) AS total_sales,
    SUM(oi.profit) AS total_profit
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY DATE_TRUNC('month', o.order_date);
