--total_revenue
SELECT SUM(quantity * sales) AS total_revenue
FROM kaggle.order_items
WHERE quantity > 0
AND  sales > 0;

---- Monthly revenue
SELECT 
date_trunc('month', o.order_date) AS month,
SUM(oi.quantity * oi.sales) AS total_revenue
FROM kaggle.orders o
JOIN kaggle.order_items oi
ON o.order_id = oi.order_id
GROUP BY date_trunc('month', o.order_date)
ORDER BY total_revenue DESC;

-- Top 10 products
SELECT
p.product_id,
p.category,
p.sub_category,
SUM(oi.quantity * oi.sales) AS total_revenue
FROM kaggle.products p
JOIN kaggle.order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_id,p.category,p.sub_category
ORDER BY total_revenue DESC
LIMIT 3;

--Total Orders
SELECT
COUNT(order_id) as total_orders
FROM kaggle.orders;

--Total Customers
SELECT
COUNT(customer_id) AS total_customers
FROM kaggle.orders;


