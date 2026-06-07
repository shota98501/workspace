--Customer First Purchase
SELECT
c.customer_id,
c.customer_name,
MIN(oi.order_date) as first_purchase_date
from kaggle.orders oi
JOIN kaggle.customers c
ON c.customer_id = oi.customer_id
GROUP BY c.customer_id, c.customer_name;

--Monthly Customer Activity
SELECT DISTINCT
c.customer_id,
c.customer_name,
date_trunc('month', o.order_date) AS activity_month
FROM kaggle.customers c
JOIN kaggle.orders o
ON c.customer_id = o.customer_id;

--New Customers Per Month
SELECT
c.customer_id,
c.customer_name,
date_trunc('month',MIN(o.order_date)) AS first_month,
count(*) as new_customers
FROM kaggle.customers c
JOIN kaggle.orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id,c.customer_name
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