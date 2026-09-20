DROP TABLE practice.tickets;

create table practice.tickets(
ticket_id VARCHAR(10) NOT NULL,
agent_id VARCHAR(10) NOT NULL,
opened_at timestamp,
closed_at timestamp,
priority VARCHAR(10)
);