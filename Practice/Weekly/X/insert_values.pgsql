insert into practice.stations(station_id , station_name) VALUES
('S101','Shibuya'),
('S102','Shinjuku'),
('S103','Meguro'),
('S104','Ebisu')
;

insert into practice.rides(ride_id,station_id,duration_minutes,fare) VALUES
('R001','S101',22,600),
('R002','S101',45,1000),
('R003','S102',18,500),
('R004','S102',55,1200),
('R005','S103',30,800)
;
