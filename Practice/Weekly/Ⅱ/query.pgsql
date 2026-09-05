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

--late-delivery percentage & total order value from late deliveries
SELECT
    region,
    COUNT(*) AS total_deliveries,

    COUNT(*) FILTER (
        WHERE delivered_date > promised_date
    ) AS late_deliveries,

    ROUND(
        COUNT(*) FILTER (
            WHERE delivered_date > promised_date
        ) * 100.0 / COUNT(*),
        1
    ) AS late_delivery_percentage,

    COALESCE(
        SUM(order_value) FILTER (
            WHERE delivered_date > promised_date
        ),
        0
    ) AS late_order_value

FROM practice.deliveries
GROUP BY region
ORDER BY late_delivery_percentage DESC;