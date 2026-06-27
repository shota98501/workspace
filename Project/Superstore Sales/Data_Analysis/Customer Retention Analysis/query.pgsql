--Customer First Purchase
SELECT
customer_id,
MIN(order_id) AS first_purchase_date
From kaggle.orders
GROUP BY customer_id;

--Monthly Customer Activity
SELECT DISTINCT
customer_id,
date_trunc('month', order_date) AS activity_month
from kaggle.orders;

--New Customers Per Month
SELECT
    date_trunc('month', MIN(order_date)) as first_month,
    COUNT(*) AS new_customers
FROM kaggle.orders
GROUP BY customer_id
ORDER BY first_month;

--Returning Customers
WITH customer_orders AS (
    SELECT
    customer_id,
    COUNT(DISTINCT order_id) AS total_orders
    FROM kaggle.orders
    GROUP BY customer_id
)
SELECT
    COUNT(*) AS returning_customers
    FROM customer_orders
    WHERE total_orders > 1;

--Retention Rate

WITH customer_orders AS(
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS total_orders
    FROM kaggle.orders
    GROUP BY customer_id
)
SELECT
    ROUND(
        COUNT(
            CASE
                WHEN total_orders > 1 THEN 1
            END
        ) * 100.0
        /
        COUNT(*),
        2
    ) AS retention_rate
FROM customer_orders;`

