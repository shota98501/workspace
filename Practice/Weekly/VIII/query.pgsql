SELECT * from practice.customers;
SELECT * from practice.subscriptions;

--total customers
SELECT



SELECT
count(c.customer_id) as total_customer
from practice.customers c
JOIN practice.subscriptions s
on c.customer_id = s.customer_id;

--active customers
--cancelled customers
--cancellation rate
--monthly revenue from active customers only