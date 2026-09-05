SELECT * from practice.deliveries;

--total deliveries
SELECT
delivery_id,
region,
delivered_date
order_value
from practice.deliveries;

--late deliveries
select 
promised_date< delivered_date as late_delervies
from practice.deliveries;

--late-delivery percentage

--total order value from late deliveries 