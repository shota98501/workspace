SET search_path TO public_2;

SELECT 
SUM(quantity * price) AS total_revenue
FROM order_items;

SELECT
date_trunc('month',o.order_date) AS month,
SUM(oi.quantity * oi.price) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.id = oi.order_id
JOIN products p
    ON oi.product_id = p.id
GROUP BY month
ORDER BY month;

SELECT 
    c.country,
    SUM(oi.price * oi.quantity) AS total_spent
FROM customers c
JOIN orders o
    ON c.id = o.customer_id
JOIN order_items oi
    ON o.id = oi.order_id
JOIN products p
    ON oi.product_id = p.id
GROUP BY c.country
ORDER BY total_spent DESC
LIMIT 10;