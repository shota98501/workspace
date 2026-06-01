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
p.category,
p.sub_category,
SUM(oi.quantity * oi.sales) / oi.profit * 100 as profit_margin
From kaggle.products p
JOIN kaggle.order_items oi
ON p.product_id = oi.product_id
GROUP BY p.category,p.sub_category;
