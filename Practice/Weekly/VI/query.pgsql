--total leads
SELECT
count(lead_id)
from practice.leads;

--converted leads
SELECT
(count(case when converted = 'true' then 1 end)) 
from practice.leads;

--conversion rate
SELECT
(count(case when converted = 'true' then 1 end) * 100.0) / count(*) as percentage
from practice.leads;

--total revenue from converted leads
select
converted,
sum(revenue) as total_leads
from practice.leads
WHERE converted = 'true'
GROUP BY converted;