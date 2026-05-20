--Beginner
--List all products and prices.
SELECT product_name , price FROM products;
--Find customers in Tokyo.
SELECT customer_id,first_name, last_name , city FROM customers WHERE city = 'Tokyo'; 

--Show orders after 2025-04-04.
SELECT order_id,order_date FROM orders WHERE order_date > '2025-04-04';
--Sort products by price from highest to lowest.
SELECT product_id, product_name, price from products ORDER BY price DESC;
--Count total number of customers.
SELECT first_name, last_name, COUNT(customer_id) FROM customers GROUP BY first_name, last_name;

--Intermediate
--Show all orders with customer names.
SELECT
c.first_name,
c.last_name,
o.order_date
FROM orders o
JOIN customers c
ON c.customer_id = o.customer_id;

--Show all products with their category names.
SELECT
c.category_name,
p.product_name,
p.price,
p.stock
FROM categories c
JOIN products p
ON c.category_id = p.category_id;

--Calculate total sales for each order.
SELECT
order_id,
SUM(quantity * unit_price) AS order_total
FROM order_items
GROUP BY order_id
ORDER BY order_id;

--Find total revenue by product.
SELECT
p.product_name,
SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY product_name
ORDER BY total_revenue DESC;

--Find total revenue by category.
SELECT
c.category_name,
SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN categories c
    ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_revenue DESC;

--Find customers who have placed at least one order.
SELECT DISTINCT
c.first_name,
c.last_name,
o.order_date
From customers c
JOIN orders o
ON c.customer_id = o.customer_id;

--Find customers who have never placed an order.
SELECT
c.first_name,
c.last_name,
o.order_date
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

--Advanced
--Find the top 3 customers by total spending.
SELECT
c.customer_id,
c.first_name,
c.last_name,
SUM(oi.quantity * oi.unit_price) AS total_spend
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spend DESC
LIMIT 3;

--Find the best-selling product by quantity.
SELECT
p.product_id,
p.product_name,
SUM(oi.quantity) AS best_selling
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
JOIN orders o
ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY p.product_id, p.product_name
ORDER BY best_selling DESC
LIMIT 1;

--Find monthly revenue.
SELECT
    DATE_TRUNC('month', o.order_date) as month,
    SUM(quantity * unit_price) AS monthly_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY DATE_TRUNC('month', o.order_date)
ORDER BY month DESC;
--Find average order value.
SELECT
AVG(order_total) AS average_order_value
FROM
(
    SELECT
    o.order_id,
    SUM(oi.quantity * oi.unit_price) AS order_total
    FROM orders o
    JOIN order_items oi
    ON o.order_id = oi.order_id
    WHERE o.status = 'completed'
    GROUP BY o.order_id 
)order_totals;

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