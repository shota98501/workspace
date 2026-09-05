DROP table practice.deliveries;

create table practice.deliveries(
delivery_id VARCHAR(100),
region VARCHAR(100),
promised_date date,
delivered_date date,
order_value int
);