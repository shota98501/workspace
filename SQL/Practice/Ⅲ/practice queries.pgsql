--Beginner
--List all products and prices.
SELECT product_name , price FROM practice.products;

--Find customers in Tokyo.
SELECT first_name, last_name, city
FROM practice.customers
WHERE city = 'Tokyo';

--Show orders after 2025-04-04.
SELECT order_id, order_date
FROM practice.orders
WHERE order_date >= '2025-04-04';

--Sort products by price from highest to lowest.
SELECT product_name, price
FROM practice.products
ORDER BY price DESC;

--Count total number of customers.
SELECT
COUNT(customer_id)
FROM practice.customers;

--View all customers
SELECT customer_id, first_name, last_name
FROM practice.customers;

--Products more expensive than 5000
SELECT product_id, product_name, price
FROM practice.products
WHERE price > 5000;

--All completed orders
SELECT order_id, order_date, status
FROM practice.orders
WHERE status = 'completed'
ORDER BY order_date DESC;

--Show each order with customer name
SELECT
c.first_name,
c.last_name,
o.order_date
FROM practice.customers c
JOIN practice.orders o
ON c.customer_id = o.customer_id
ORDER BY o.order_date DESC;

--Total sales per order
SELECT
order_id,
SUM(quantity * unit_price) AS total_sales
FROM practice.order_items
GROUP BY order_id
ORDER BY total_sales DESC;

--Intermediate
--Show all orders with customer names.
--Show all products with their category names.
--Calculate total sales for each order.
--Find total revenue by product.
--Find total revenue by category.
--Find customers who have placed at least one order.
--Find customers who have never placed an order.

--Advanced
--Find the top 3 customers by total spending.
--Find the best-selling product by quantity.
--Find monthly revenue.
--Find average order value.
--Rank products by total sales.
--Show each customer’s most recent order date.

--Expert
--Find the total number of orders for each customer
--Find customers who made more than 1 order
--Show the most expensive product in each category
--Find products that have never been ordered
--Calculate the total quantity sold for each category
--Find the average product price by category
--Show all orders with the number of items in the order
--Find the customer who bought the largest total quantity of items
--Find orders whose total value is greater than the average order value
--Show cumulative revenue over time

--Bonus
--Find the second highest selling product
--Find customers who ordered from more than one category
--Find the percentage contribution of each category to total revenue
--Find the day with the highest sales
--Rank customers by total spending within each city