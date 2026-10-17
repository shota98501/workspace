DROP TABLE practice.customers;
DROP TABLE practice.subscription;

CREATE Table practice.customers(
    customer_id VARCHAR(50),
    plan VARCHAR(50)
);

CREATE TABLE practice.subscriptions(
    customer_id VARCHAR(50),
    monthly_fee INT,
    status VARCHAR(50)
);