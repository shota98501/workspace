SELECT * FROM kaggle.orders LIMIT 5;
SELECT * FROM kaggle.customers LIMIT 5;
SELECT * FROM kaggle.products LIMIT 5;
SELECT * FROM kaggle.order_items LIMIT 5;

--What are the top-selling products?
SELECT
p.products,
sum(oi.quantity) as top_selling
from kaggle.products p
join kaggle.order_items oi
on p.transaction_id = oi.transaction_id
group by p.products
order by top_selling DESC
limit 5; 


--Which categories generate the most revenue?
SELECT
p.products,
sum(oi.total_amount) as revenue
from kaggle.products p
join kaggle.order_items oi
on p.transaction_id = oi.transaction_id
group by p.products
order by revenue DESC
limit 5; 


--What are the monthly sales trends?
SELECT
date_trunc('month', o.order_date) as month,
sum(oi.total_amount) as monthly_sales
from kaggle.orders o
join kaggle.order_items oi
on o.order_id = oi.order_id
GROUP BY month
order by monthly_sales DESC
LIMIT 5;


--Who are the top customers by spending?

SELECT
c.customer_id,
c.gender,
c.age,
sum(oi.total_amount) as total_spending
from kaggle.customers c
JOIN kaggle.order_items oi
on c.customer_id = oi.customer_id
GROUP BY c.customer_id, c.gender, c.age
order by total_spending DESC
LIMIT 5;

--What is the average order value?
SELECT
p.products,
round(avg(oi.total_amount),2) as avg_order_value,
round(avg(oi.quantity),2) as avg_quantity
from kaggle.products p
join kaggle.order_items oi
on p.transaction_id = oi.transaction_id
group by p.products
order by avg_order_value DESC
limit 5; 


--Which age group buys the most?
SELECT
CASE
    WHEN age < 25 THEN 'UNDER 25'
    WHEN age between 25 AND 40 THEN '25-40'
    WHEN age between 41 and 55 then '41-55'
    else 'over 55'
end as age_group,
SUM(oi.total_amount) as total_revenue,
count(c.gender) as total_orders
from kaggle.order_items oi
JOIN kaggle.customers c
on oi.customer_id = c.customer_id
group BY age_group
order by total_revenue DESC;