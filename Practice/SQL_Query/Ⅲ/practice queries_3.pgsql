--Beginner
--List all products and prices.
SELECT product_name , price FROM practice.products;

--Find customers in Tokyo.
SELECT first_name, last_name, city
FROM practice.customers
WHERE city = 'Tokyo';

--Show orders after 2025-04-04.
SELECT order_id, order_date
FROM practice.orders
WHERE order_date >= '2025-04-04';

--Sort products by price from highest to lowest.
SELECT product_name, price
FROM practice.products
ORDER BY price DESC;

--Count total number of customers.
SELECT
COUNT(customer_id)
FROM practice.customers;

--View all customers
SELECT customer_id, first_name, last_name
FROM practice.customers;

--Products more expensive than 5000
SELECT product_id, product_name, price
FROM practice.products
WHERE price > 5000;

--All completed orders
SELECT order_id, order_date, status
FROM practice.orders
WHERE status = 'completed'
ORDER BY order_date DESC;

--Show each order with customer name
SELECT
c.first_name,
c.last_name,
o.order_date
FROM practice.customers c
JOIN practice.orders o
ON c.customer_id = o.customer_id
ORDER BY o.order_date DESC;

--Total sales per order
SELECT
order_id,
SUM(quantity * unit_price) AS total_sales
FROM practice.order_items
GROUP BY order_id
ORDER BY total_sales DESC;

--Intermediate
--Show all orders with customer names.
SELECT
o.order_id,
o.order_date,
c.first_name,
c.last_name
from practice.orders o
JOIN practice.customers c
ON o.customer_id = c.customer_id;

--Show all products with their category names.
SELECT
p.product_id,
c.category_name,
p.price
FROM practice.products p
JOIN practice.categories c
ON p.category_id = c.category_id
ORDER BY price DESC;

--Calculate total sales for each order.
SELECT
o.order_id,
o.status,
SUM(oi.quantity * unit_price) AS total_sales
FROM practice.orders o
JOIN practice.order_items oi
ON o.order_id = oi.order_id
WHERE status = 'completed'
GROUP BY o.order_id, o.status
ORDER BY total_sales DESC;

--Find total revenue by product.
SELECT
p.product_id,
p.product_name,
SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM practice.products p
JOIN practice.order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_id,p.product_name
ORDER BY total_revenue DESC;

--Find total revenue by category.
SELECT
c.category_id,
c.category_name,
SUM(oi.quantity * oi.unit_price) total_revenue
FROM practice.categories c
JOIN practice.products p
ON c.category_id = p.category_id
JOIN practice.order_items oi
ON p.product_id = oi.product_id
GROUP BY c.category_id,c.category_name
ORDER BY total_revenue DESC;

--Find customers who have placed at least one order.
SELECT
DISTINCT
c.first_name,
c.last_name,
o.order_date
FROM practice.customers c
JOIN practice.orders o
ON c.customer_id = o.order_id;

--Find customers who have never placed an order.
SELECT
c.first_name,
c.last_name,
o.order_date
FROM practice.customers c
JOIN practice.orders o
ON c.customer_id = o.order_id
WHERE o.order_date IS NULL;

--Advanced
--Find the top 3 customers by total spending.
SELECT
c.customer_id,
c.first_name,
c.last_name,
SUM(oi.quantity * oi.unit_price) AS total_spending
FROM practice.customers c
JOIN practice.orders o
ON c.customer_id = o.customer_id
JOIN practice.order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_id,c.first_name,c.last_name
ORDER BY total_spending DESC
LIMIT 3;

--Find the best-selling product by quantity.
SELECT
p.product_id,
p.product_name,
SUM(oi.quantity) AS total_quantity,
o.status
FROM practice.products p
JOIN practice.order_items oi
ON p.product_id = oi.product_id
JOIN orders o
ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY p.product_id,p.product_name,o.status
ORDER BY total_quantity DESC;

--Find monthly revenue.
SELECT
DATE_TRUNC('month', o.order_date) AS MONTH,
SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM practice.orders o
JOIN practice.order_items oi
ON o.order_id = oi.order_id
GROUP BY DATE_TRUNC('month', o.order_date)
ORDER BY MONTH DESC;

--Find average order value.
SELECT
AVG(order_total) AS average_order
FROM
(
    SELECT
    o.order_id,
    SUM(quantity * unit_price) AS order_total
    FROM practice.orders o
    JOIN practice.order_items oi
    ON o.order_id = oi.order_id
    WHERE o.status = 'completed'
    GROUP BY o.order_id
)order_total;

--Rank products by total sales.
SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales,
    RANK() OVER(
        ORDER BY SUM(oi.quantity * oi.unit_price) DESC
    ) AS rank_sales
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY p.product_name;

--Show each customer’s most recent order date.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    MAX(o.order_date) AS most_recent_order_date
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id,c.first_name,c.last_name
ORDER BY most_recent_order_date DESC;