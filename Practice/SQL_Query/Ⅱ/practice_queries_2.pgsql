--View all customers
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM categories;
SELECT * FROM order_items;

--Products more expensive than 5000
SELECT product_id, product_name , price FROM products WHERE price > 5000;

--All completed orders
SELECT
c.first_name,
c.last_name,
o.status
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE status = 'completed';

--Show each order with customer name
SELECT
c.first_name,
c.last_name,
o.status
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id;

--Total sales per order
SELECT
    order_id,
    SUM(quantity * unit_price) AS order_total
FROM order_items
GROUP BY order_id
ORDER BY order_total DESC;
