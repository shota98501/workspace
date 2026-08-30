insert into practice.orders(order_id, order_date, store) VALUES
(101,'2026-08-01','Shibuya'),
(102,'2026-08-01','Shinjuku'),
(103,'2026-08-01','Shinbuya'),
(104, '2026-08-03','Shinjuku');


INSERT into practice.order_items(order_id, product, quantity, unit_price) VALUES
(101,'Cofffee',2,450),
(101,'Cake',1,600),
(102,'Coffee',1,450),
(103,'Tea',3,400),
(104,'Cake',2,600);
