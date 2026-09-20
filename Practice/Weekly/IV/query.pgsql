select * from practice.tickets;

--total ticket
SELECT
count(ticket_id)
from practice.tickets;

--closed ticket
SELECT
count(closed_at)
from practice.tickets;

--open ticket
SELECT
count(opened_at)
from practice.tickets;

--average resolution time in hours for closed tickets only
SELECT
    agent_id,
    ROUND(
        AVG(
            EXTRACT(EPOCH FROM (closed_at - opened_at)) / 3600.0
        ) FILTER (
            WHERE closed_at IS NOT NULL
        ),
        1
    ) AS avg_resolution_hours

FROM practice.tickets
GROUP BY agent_id
ORDER BY avg_resolution_hours DESC NULLS LAST;