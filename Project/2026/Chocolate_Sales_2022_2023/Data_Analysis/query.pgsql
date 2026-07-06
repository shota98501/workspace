SELECT * FROM kaggle.products LIMIT 10;
SELECT * FROM kaggle.orders LIMIT 10;
SELECT * FROM kaggle.order_items limit 10;
SELECT * FROM kaggle.Salesperson LIMIT 10;

--Top 10 products by revenue
SELECT
p.product_id,
oi.amount AS revenue
FROM kaggle.products p
JOIN kaggle.order_items oi
ON p.product_id = oi.product_id
ORDER BY revenue DESC


--Monthly sales trends
--Revenue by country and channel
--Best-performing salespeople
--Average discount by product
--Correlation between marketing spend and sales
--Revenue per box shipped