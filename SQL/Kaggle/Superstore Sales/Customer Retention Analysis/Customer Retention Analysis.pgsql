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
