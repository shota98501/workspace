customers
- id (PK)
- signup_date
- country

orders
- id (PK)
- customer_id (FK)
- order_date
- total_amount

order_items
- id (PK)
- order_id (FK)
- product_id (FK)
- quantity
- price

products
- id (PK)
- product_name
- category
