insert into practice.campaigns(campaign_id,campaign_name,channel) VALUES
('C101','Autumn Sale', 'Email'),
('C102','New Customer','Social'),
('C103','Loyalty Bonus','Email'),
('C104','Search Promo','Search');


insert into practice.leads(lead_id,campaign_id,converted,revenue) VALUES
('L001','C101','true',8000),
('L002','C101','false',0),
('L003','C101','true',5000),
('L004','C102','false',0),
('L005','C102','true',6000),
('L006','C103','false',0)