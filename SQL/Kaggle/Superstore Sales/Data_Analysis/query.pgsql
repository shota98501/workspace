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

----profit margin
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

--monthly revenue
SELECT
date_trunc('month', o.order_date) as month,
sum(oi.sales) as total_sales,
sum(oi.profit) as total_profit
FROM kaggle.orders o
JOIN kaggle.order_items oi
ON o.order_id = oi.order_id
GROUP BY date_trunc('month', o.order_date)
order by total_profit DESC;

--category performance
SELECT
p.category,
p.sub_category,
sum(oi.sales) as total_sales,
sum(oi.profit) as total_profit
FROM kaggle.products p
join kaggle.order_items oi
on p.product_id = oi.product_id
GROUP BY p.category,p.sub_category
order by total_profit DESC;

--customer revenue
SELECT
c.customer_id,
sum(oi.sales) as total_sales,
sum(oi.profit) as total_profit
FROM kaggle.customers c
join kaggle.orders o
on c.customer_id = o.customer_id
JOIN kaggle.order_items oi
on o.order_id = oi.order_id
GROUP BY c.customer_id
order by total_profit desc;