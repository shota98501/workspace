SELECT * from practice.practice_orders
LIMIT 10;

--Net revenue
SELECT
sum(quantity) * sum(unit_price) * sum(1 - discount) as net_revenue
FROM practice.practice_orders;

--Return rate
SELECT
round((count(case when returned = 'True' then 1 end)* 100.0) /sum(order_id),3)  as return_rate
from practice.practice_orders;

--Previous month’s net revenue
SELECT
order_date,
date_trunc('month',order_date) as months,
sum(quantity) * sum(unit_price) * sum(1 - discount) as net_revenue
FROM practice.practice_orders
GROUP BY order_date;
--Month-over-month revenue growth percentage

--Category revenue rank within each month