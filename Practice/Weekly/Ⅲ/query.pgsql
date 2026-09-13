--plan type
SELECT member_id, plan_type from practice.members;

--monthly fee
SELECT member_id, monthly_fee from practice.members;

--most recent visit date
SELECT member_id, visit_date
from  practice.visits
WHERE visit_date = '2026-09-08';

--number of visits during September 2026
SELECT member_id, visit_date
from  practice.visits
WHERE visit_date >= '2026-09-01';