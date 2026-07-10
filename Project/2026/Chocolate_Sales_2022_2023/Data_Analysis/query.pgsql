--Top 10 products by revenue
SELECT
p.product,
SUM(oi.amount) AS total_revenue
FROM kaggle.products p
JOIN kaggle.order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product
ORDER BY total_revenue DESC
LIMIT 10;


--Monthly sales trends
SELECT
date_trunc('month', o.Order_date) AS month,
SUM(oi.Amount) AS revenue
FROM kaggle.orders o
JOIN kaggle.order_items oi
ON o.Order_id = oi.Order_id
GROUP BY month
ORDER BY month;

--Revenue by country and channel
SELECT
o.Country,
o.Channel,
SUM(oi.Amount) AS revenue
FROM kaggle.orders o
JOIN kaggle.order_items oi
ON o.Order_id = oi.Order_id
GROUP BY
o.Country,
o.Channel
ORDER BY revenue DESC;

--Best-performing salespeople
SELECT
s.Salesperson,
SUM(oi.Amount) AS revenue
FROM kaggle.salesperson s
JOIN kaggle.order_items oi
ON s.Salesperson_id = oi.Salesperson_id
GROUP BY s.Salesperson
ORDER BY revenue DESC;


--Average discount by product
SELECT
p.Product,
ROUND(AVG(oi.Discount_PCt),2) AS avg_discount
FROM kaggle.products p
JOIN kaggle.order_items oi
ON p.Product_id = oi.Product_id
GROUP BY p.Product
ORDER BY avg_discount DESC;

--Correlation between marketing spend and sales
SELECT
Marketing_Spend,
Amount
FROM kaggle.order_items
WHERE Marketing_Spend IS NOT NULL
ORDER BY Marketing_Spend;

--Revenue per box shipped
SELECT
p.Product,
ROUND(
    SUM(oi.Amount) / NULLIF(SUM(oi.Boxes_Shipped),0)
    ,2
    ) AS revenue_per_box
FROM kaggle.products p
JOIN kaggle.order_items oi
ON p.product_id = oi.product_id
GROUP BY p.Product
ORDER BY revenue_per_box DESC;