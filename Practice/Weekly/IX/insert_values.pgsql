insert into practice.restaurants(restaurant_id,restaurant_name,area) VALUES
('R101','Sakura Kitchen','Shibuya'),
('R102','Green Bowl','Shinjuku'),
('R103','Tokyo Curry','Meguro'),
('R104','Pasta House','Shibuya')
;

insert into practice.deliveries(order_id,restaurant_id,delivery_minutes,promised_minutes,revenue) VALUES
('O101','R101',32,40,2400),
('O102','R101',48,40,3100),
('O103','R102',25,30,1000),
('O104','R102',42,30,2600),
('O105','R103',38,45,2200)
;
