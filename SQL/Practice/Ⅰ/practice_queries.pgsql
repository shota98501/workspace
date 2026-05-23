--View all customers
SELECT * FROM customers;

--Products more expensive than 5000
SELECT product_name, price 
FROM products
WHERE price > 5000
ORDER BY price DESC;

--All completed orders
SELECT * FROM orders
WHERE status = 'completed';

--Show each order with custommer name
SELECT
    o.order_id,
    o.order_date,
    o.status,
    c.first_name,
    c.last_name
    FROM orders o
    join customers c
        ON o.customer_id = c.customer_id
    ORDER BY o.order_date; 

SELECT
    oi.order_id,
    SUM(oi.quantity * oi.unit_price) AS order_total
FROM order_items oi
GROUP BY oi.order_id
ORDER BY order_total DESC;