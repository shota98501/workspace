SELECT
    date_trunc('month', o.order_date) as month,
    sum(oi.sales) AS total_sales
From kaggle.orders o
JOIN kaggle.order_items oi
    ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;