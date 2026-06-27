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

----Profit Margin
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

--Monthly Revenue
SELECT
date_trunc('month', o.order_date) as month,
sum(oi.sales) as total_sales,
sum(oi.profit) as total_profit
FROM kaggle.orders o
JOIN kaggle.order_items oi
ON o.order_id = oi.order_id
GROUP BY date_trunc('month', o.order_date)
order by total_profit DESC;

--Top 10 Products by Sales
SELECT
p.category,
p.sub_category,
SUM(oi.sales) AS total_sales
FROM kaggle.products p
JOIN kaggle.order_items oi
ON p.product_id = oi.product_id
GROUP BY p.category,p.sub_category
ORDER BY total_sales DESC
LIMIT 10;

--Top 10 Products by Profit
SELECT
p.category,
p.sub_category,
SUM(oi.profit) AS total_profit
FROM kaggle.products p
JOIN kaggle.order_items oi
ON p.product_id = oi.product_id
GROUP BY p.category,p.sub_category
ORDER BY total_profit DESC
LIMIT 10;

--Category Performance
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

--Discount vs Profit
SELECT
p.category,
p.sub_category,
ROUND(AVG(oi.discount) * 100, 2) AS discount_sales,
round(sum(oi.profit),2) as total_profit
FROM kaggle.products p
join kaggle.order_items oi
on p.product_id = oi.product_id
GROUP BY p.category,p.sub_category
ORDER BY discount_sales DESC;


--Customer Segments
SELECT
segment,
count(customer_name) as customer_total
from kaggle.customers
GROUP BY segment
ORDER BY customer_total DESC;

--Top 10 Customer Revenue
SELECT
c.customer_name,
sum(oi.sales) as total_sales
FROM kaggle.customers c
join kaggle.orders o
on c.customer_id = o.customer_id
JOIN kaggle.order_items oi
on o.order_id = oi.order_id
GROUP BY c.customer_name
order by total_sales desc
limit 10;

--Top 10 Customers by Profit
SELECT
c.customer_name,
sum(oi.profit) as total_profit
FROM kaggle.customers c
join kaggle.orders o
on c.customer_id = o.customer_id
JOIN kaggle.order_items oi
on o.order_id = oi.order_id
GROUP BY c.customer_name
order by total_profit desc
limit 10;

--Sales by Customer Segment
SELECT
c.customer_name,
c.segment,
SUM(oi.sales) as total_sales,
SUM(oi.profit) as total_profit
FROM kaggle.customers c
JOIN kaggle.orders o
ON c.customer_id = o.customer_id
JOIN kaggle.order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_name,c.segment
ORDER BY total_sales DESC , total_profit DESC;
