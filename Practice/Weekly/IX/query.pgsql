select * from practice.restaurants;
select * from practice.deliveries;

--total orders
SELECT
count(order_id) as total_orders
from practice.deliveries;

--average delivery time
SELECT
avg(delivery_minutes) as average_time
from practice.deliveries;

--late deliveries
SELECT
delivery_minutes,
promised_minutes
from practice.deliveries
WHERE delivery_minutes > promised_minutes;

--late-delivery percentage
SELECT
delivery_minutes,
promised_minutes,
(count(case when delivery_minutes > promised_minutes THEN 1 end) * 100.0) /count(*) as percentage
from practice.deliveries
GROUP by delivery_minutes,promised_minutes;

--total revenue
SELECT
sum(revenue) as total_revenue
from practice.deliveries;