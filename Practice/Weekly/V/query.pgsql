SELECT * from practice.orders;

--total orders
SELECT
count(order_id)
from practice.orders;


--returned orders
SELECT
returned
from practice.orders
WHERE returned = 'true';


--return rate as a percentage
select
(count(case when returned = 'true' then 1 end) * 100.0) / count(*) as percentage
from practice.orders;


--gross revenue



--retained revenue excluding returned orders