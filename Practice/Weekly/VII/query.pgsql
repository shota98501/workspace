SELECT * from practice.products;
SELECT * from practice.sales;


--total quantity sold
--current stock
--stock status: Out of Stock, Low Stock, or Healthy
--sell-through rate: quantity sold ÷ (quantity sold + current stock) × 100

SELECT
    p.product_id,
    p.product_name,
    p.category,

    COALESCE(SUM(s.quantity), 0) AS total_quantity_sold,

    p.stock_quantity AS current_stock,

    CASE
        WHEN p.stock_quantity = 0 THEN 'Out of Stock'
        WHEN p.stock_quantity BETWEEN 1 AND 10 THEN 'Low Stock'
        ELSE 'Healthy'
    END AS stock_status,

    ROUND(
        COALESCE(SUM(s.quantity), 0) * 100.0
        / NULLIF(
            COALESCE(SUM(s.quantity), 0) + p.stock_quantity,
            0
        ),
        1
    ) AS sell_through_rate

FROM practice.products AS p

LEFT JOIN practice.sales AS s
    ON p.product_id = s.product_id

GROUP BY
    p.product_id,
    p.product_name,
    p.category,
    p.stock_quantity

ORDER BY
    sell_through_rate DESC NULLS LAST;