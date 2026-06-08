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

--Retention Rate
with customer_orders as (
    SELECT
    customer_id,
    count(DISTINCT order_id) as total_orders
    from kaggle.orders
    GROUP BY customer_id
)
SELECT
round(
    COUNT(
        case
        when total_orders >1 then 1
        end
    ) * 100.0
    /
    COUNT(*),
    2
) as retention_rate
from customer_orders;

--Customer Lifetime Value (CLV)
SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.sales) AS lifetime_value
FROM kaggle.customers c
JOIN kaggle.orders o
ON c.customer_id = o.customer_id
JOIN kaggle.order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_id,c.customer_name
ORDER BY lifetime_value DESC;

--Customer Segmentation
SELECT
c.segment,
COUNT(DISTINCT c.customer_id) AS customers,
SUM(oi.sales) AS revenue,
SUM(oi.profit) as profit
FROM kaggle.customers c
JOIN kaggle.orders o
ON c.customer_id = o.customer_id
JOIN kaggle.order_items oi
ON o.order_id = oi.order_id
GROUP BY c.segment;

--Find Customer Cohort
WITH first_purchase AS(
    SELECT
        c.customer_id,
        c.customer_name,
        date_trunc('month', MIN(o.order_date)) AS cohort_month
        FROM kaggle.orders o
        JOIN kaggle.customers c
        ON c.customer_id = o.customer_id
        GROUP BY c.customer_id,c.customer_name
)
SELECT *
FROM first_purchase;

--Cohort Retention
WITH first_purchase AS (
    SELECT
        customer_id,
        date_trunc('month', MIN(order_date)) AS cohort_month
        FROM kaggle.orders
        GROUP BY customer_id
),
customer_activity AS (
    SELECT 
    customer_id,
    date_trunc('month', order_date) AS activity_month
    from kaggle.orders
)
SELECT
fp.cohort_month,
ca.activity_month,
count(DISTINCT ca.customer_id) AS active_customers
FROM first_purchase fp
JOIN customer_activity ca
    ON fp.customer_id = ca.customer_id
GROUP BY
    fp.cohort_month,
    ca.activity_month
ORDER BY
fp.cohort_month,
ca.activity_month;
