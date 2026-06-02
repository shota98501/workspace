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
ROUND(
    SUM(oi.profit) * 100.0 / NULLIF(SUM(oi.sales),0),2
    ) AS profit_margin
From kaggle.products p
JOIN kaggle.order_items oi
ON p.product_id = oi.product_id
GROUP BY p.category,p.sub_category
ORDER BY profit_margin DESC;

select profit from kaggle.order_items; 
