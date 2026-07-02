INSERT INTO categories (category_name) VALUES
('Electronies'),
('Books'),
('Home'),
('Clothing');

INSERT INTO customers(first_name,last_name,email,city,signup_date) VALUES
('Shota','Sakuma','shota.s@example.com','Tokyo','2025-01-15'),
('Yuki','Tanaka','yuki.t@example.com','Osaka','2025-02-10'),
('Haru','Saito','haru.s@example.com','Nagoya','2025-03-05'),
('Mina','Kobayashi','mina.k@example.com','Fukuoka','2025-03-22'),
('Ken','Yamada','ken.y@example.com','Tokyo','2025-04-01');

INSERT INTO products (product_name,category_id,price,stock) VALUES
('Laptop',1,120000.00,10),
('Wireless Mouse',1,2500.00,50),
('SQL for Beginners',1,3200.00,40),
('Data Analysis Book',2,4200.00,30),
('Desk Lamp',3,4800.00,25),
('Office Chair',3,15000.00,12),
('T-Shirt',4,2000.00,100),
('Hoodie',4,5500.00,60);

INSERT INTO orders (customer_id,order_date,status) VALUES
(1, '2025-04-02', 'completed'),
(2, '2025-04-03', 'completed'),
(1, '2025-04-05', 'pending'),
(3, '2025-04-06', 'completed'),
(4, '2025-04-07', 'cancelled'),
(5, '2025-04-08', 'completed');

INSERT INTO order_items (order_id,product_id,quantity,unit_price) VALUES
(1, 1, 1, 120000.00),
(1, 2, 2, 2500.00),
(2, 3, 1, 3200.00),
(2, 5, 1, 4800.00),
(3, 4, 1, 4200.00),
(3, 7, 3, 2000.00),
(4, 6, 1, 15000.00),
(4, 2, 1, 2500.00),
(5, 8, 2, 5500.00),
(6, 3, 2, 3200.00),
(6, 7, 1, 2000.00);