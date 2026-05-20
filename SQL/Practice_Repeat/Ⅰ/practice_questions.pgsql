--Beginner
--List all products and prices
SELECT product_name , price FROM products;

--Find customers in Tokyo
SELECT * FROM customers WHERE city = 'Tokyo';

--Show orders after 2025-04-04
SELECT * FROM orders WHERE order_date > '2025-04-04';

--Sort products by price from highest to lowest
SELECT product_name , price FROM products ORDER BY price DESC; 

--Count total number of customers
SELECT COUNT(customer_id) FROM customers;


--Intermediate
--Show all orders with customer names
SELECT
o.order_id,
o.order_date,
o.status,
c.first_name,
c.last_name
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id;

--Show all products with their category names
SELECT
p.product_id,
p.product_name,
p.price,
p.stock,
c.category_name
FROM products p
JOIN categories c
ON p.category_id = c.category_id;

--Calculate total sales for each order
SELECT
order_id,
SUM(quantity * unit_price) AS order_total
FROM order_items
GROUP BY order_id
ORDER BY order_id;

--Find total revenue by product
SELECT
p.product_name,
SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items oi
JOIN products p
on oi.product_id = p.product_id
GROUP BY product_name
ORDER BY total_revenue DESC;

--Find total revenue by category
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

--Find customers who have placed at least one order
SELECT DISTINCT
    c.customer_id,
    c.first_name,
    c.last_name
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id;

--Find customers who have never placed an order
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers c
LEFT JOIN orders o
    on c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

--Advanced
--Find the top 3 customers by total spending.
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 3;

--Find the best-selling product by quantity.
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 1;

--Find monthly revenue.
SELECT
    DATE_TRUNC('month', o.order_date) AS month,
    SUM(oi.quantity * oi.unit_price) AS month_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY DATE_TRUNC('month', o.order_date)
ORDER BY month;


--Find average order value.
SELECT
    AVG(order_total) AS average_order_value
FROM(
    SELECT
        o.order_id,
        SUM(oi.quantity * oi.unit_price) AS order_total
        FROM orders o
        JOIN order_items oi
            ON o.order_id = oi.order_id
        WHERE o.status = 'completed'
        GROUP BY o.order_id
) order_totals;

--Rank products by total sales.
SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS total_sales,
    RANK() OVER(
        ORDER BY SUM(oi.quantity * oi.unit_price) DESC
    ) AS sales_rank
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
JOIN orders o
    ON oi.order_id = o.order_id
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

