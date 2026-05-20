SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(total_amount) AS revenue
FROM
    orders
GROUP BY 1
ORDER BY 1;


SELECT
    AVG(total_amount) AS avg_order_value
    FROM orders;


SELECT
    p.category,
    SUM(oi.quantity * oi.price) AS revenue
FROM
    order_items oi
JOIN
    products p ON oi.product_id = p.id
GROUP BY p.category
ORDER BY revenue DESC;


SELECT
    p.product_name,
    SUM(oi.quantity * oi.price) AS revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.id
GROUP BY p.product_name
ORDER BY revenue DESC;
