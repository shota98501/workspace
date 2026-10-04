create table practice.campaigns(
campaign_id VARCHAR(50),
campaign_name VARCHAR(50),
channel VARCHAR(50)
);

create table practice.leads(
lead_id VARCHAR(50),
campaign_id VARCHAR(50),
converted VARCHAR(50),
revenue INT
);
