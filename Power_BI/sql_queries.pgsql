SET search_path TO public_2;

SELECT 
SUM(quantity * price) AS total_revenue
FROM order_items

