SELECT * from practice.practice_orders
LIMIT 10;

SELECT 
count(*)
FROM practice.practice_orders
LIMIT 10;

--Net revenue
SELECT
sum(
    case when returned then 0
    else quantity * unit_price *(1-discount)
    END
) as net_revenue
from practice.practice_orders;

--Return rate
SELECT
round(
    100.0 * count(*) FILTER (WHERE returned) / count(*)
) as return_rate
from practice.practice_orders;

--Previous month’s net revenue & Month-over-month revenue growth percentage & Category revenue rank within each month
WITH monthly AS (
    SELECT
        DATE_TRUNC('month', order_date)::date AS month,
        category,
        SUM(
            CASE WHEN returned THEN 0
                 ELSE quantity * unit_price * (1 - discount)
            END
        ) AS net_revenue,
        ROUND(
            100.0 * COUNT(*) FILTER (WHERE returned) / COUNT(*),
            3
        ) AS return_rate_pct
    FROM practice.practice_orders
    GROUP BY
        DATE_TRUNC('month', order_date)::date,
        category
),
with_previous AS (
    SELECT
        *,
        LAG(net_revenue) OVER (
            PARTITION BY category
            ORDER BY month
        ) AS previous_month_net_revenue
    FROM monthly
)
SELECT
    month,
    category,
    net_revenue,
    return_rate_pct,
    previous_month_net_revenue,
    ROUND(
        100.0 * (net_revenue - previous_month_net_revenue)
        / NULLIF(previous_month_net_revenue, 0),
        2
    ) AS mom_growth_pct,
    DENSE_RANK() OVER (
        PARTITION BY month
        ORDER BY net_revenue DESC
    ) AS category_revenue_rank
FROM with_previous
ORDER BY month, category_revenue_rank, category;
