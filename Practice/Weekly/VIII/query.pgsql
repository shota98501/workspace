SELECT * from practice.customers;
SELECT * from practice.subscriptions;

--total customers
SELECT
count(customer_id) as total_customer
from practice.customers;


--active customers
SELECT
c.customer_id,
s.customer_id,
count(s.status)
from practice.customers c
JOIN practice.subscriptions s
on c.customer_id = s.customer_id
WHERE status = 'Active'
GROUP BY c.customer_id,s.customer_id;


--cancelled customers
SELECT
c.customer_id,
s.customer_id,
count(s.status)
from practice.customers c
JOIN practice.subscriptions s
on c.customer_id = s.customer_id
WHERE status = 'Cancelled'
GROUP BY c.customer_id,s.customer_id;

--cancellation rate
SELECT
c.customer_id,
s.customer_id,
(count(case when s.status = 'Cancelled' then 1 end) * 100.0) / count(*) as percentage
from practice.customers c
JOIN practice.subscriptions s
on c.customer_id = s.customer_id
GROUP BY c.customer_id,s.customer_id;

--monthly revenue from active customers only
SELECT
status,
sum(monthly_fee) as monthly_revenue
from practice.subscriptions
WHERE status = 'Active'
GROUP BY status;
