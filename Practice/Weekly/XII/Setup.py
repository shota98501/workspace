import numpy as np
import pandas as pd

rng = np.random.default_rng(20261109)
n = 4_800

queue = rng.choice(["Billing", "Technical", "Account"], n, p=[.30, .45, .25])
channel = rng.choice(["Email", "Chat", "Web"], n, p=[.45, .20, .35])
priority = rng.choice(["Normal", "Urgent"], n, p=[.82, .18])
backlog = rng.poisson(np.where(queue == "Technical", 20, 12))
opened_at = (
    pd.Timestamp("2026-08-01")
    + pd.to_timedelta(rng.integers(0, 92 * 24, n), unit="h")
)

# Generate first-response times with a long right tail.
response_hours = np.round(
    rng.lognormal(
        mean=(
            1.15
            + 0.05 * backlog
            + 0.42 * (queue == "Technical")
            - 0.55 * (channel == "Chat")
            - 0.32 * (priority == "Urgent")
            + 0.30 * (opened_at.dayofweek >= 5)
        ),
        sigma=0.75,
    ).clip(0.25, 96),
    2,
)

tickets = pd.DataFrame({
    "ticket_id": np.arange(1, n + 1),
    "opened_at": opened_at.strftime("%Y-%m-%d %H:%M:%S"),
    "queue": queue,
    "channel": channel,
    "priority": priority,
    "backlog_at_open": backlog,
    "first_response_hours": response_hours,
})

# Clean data for PostgreSQL.
ddl = """
CREATE TEMP TABLE practice_support_tickets (
    ticket_id integer PRIMARY KEY,
    opened_at timestamp NOT NULL,
    queue text NOT NULL,
    channel text NOT NULL,
    priority text NOT NULL,
    backlog_at_open integer NOT NULL,
    first_response_hours numeric(6,2) NOT NULL
);
"""
rows = [
    f"({i}, '{ts}', '{q}', '{c}', '{p}', {b}, {h:.2f})"
    for i, ts, q, c, p, b, h in tickets.itertuples(index=False, name=None)
]
with open("support_setup.sql", "w", encoding="utf-8") as f:
    f.write(ddl + "\nINSERT INTO practice_support_tickets VALUES\n")
    f.write(",\n".join(rows) + ";\n")

# Messy export for Python and Power BI.
raw = tickets.copy()
raw["first_response_hours"] = raw["first_response_hours"].map(
    lambda h: f"{h:.2f} hrs"
)
raw.loc[rng.choice(raw.index, 120, replace=False), "queue"] = (
    raw["queue"].str.lower().map(lambda q: f" {q} ")
)
raw.loc[rng.choice(raw.index, 65, replace=False), "first_response_hours"] = "N/A"
raw.loc[rng.choice(raw.index, 18, replace=False), "first_response_hours"] = "-2 hrs"
raw.loc[rng.choice(raw.index, 24, replace=False), "opened_at"] = "unknown"
raw.loc[rng.choice(raw.index, 20, replace=False), "backlog_at_open"] = -1

duplicates = raw.sample(60, random_state=22)
pd.concat([raw, duplicates], ignore_index=True).sample(
    frac=1, random_state=23
).to_csv("tickets_raw.csv", index=False)