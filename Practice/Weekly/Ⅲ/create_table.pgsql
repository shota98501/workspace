CREATE TABLE practice.members(
    member_id VARCHAR(100),
    plan_type VARCHAR(100),
    monthly_fee INT
);

CREATE TABLE practice.visits(
    member_id VARCHAR(100),
    visit_date DATE
);