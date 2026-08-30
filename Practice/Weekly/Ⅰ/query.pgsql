--total revenue
SELECT
SUM(quantity * unit_price)
from practice.order_items;

--number of distinct orders
SELECT DISTINCT * from practice.orders;

--average revenue per order
SELECT
round(SUM(oi.quantity * oi.unit_price))
from practice.orders o
JOIN practice.order_items oi
ON o.order_id = oi.order_id
Group BY o.order_id
order by o.order_id DESC;