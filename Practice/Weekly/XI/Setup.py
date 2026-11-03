import numpy as np
import pandas as pd

rng = np.random.default_rng(42)
n = 1200

customers = pd.DataFrame({
    "customer_id": np.arange(1, n + 1),
    "region": rng.choice(["North", "South", "East", "West"], n),
    "tenure_days": rng.integers(30, 731, n),
    "orders_90d": rng.poisson(2.5, n),
    "avg_discount_90d": rng.uniform(0, 0.35, n).round(3),
})
customers["spend_90d"] = (
    customers["orders_90d"] * rng.gamma(4, 18, n)
).round(2)

# Features are available September 30.
# Target is whether the customer purchases during October.
logit = (
    -1.8
    + 0.45 * customers["orders_90d"]
    + 0.0008 * customers["tenure_days"]
    - 1.5 * customers["avg_discount_90d"]
)
customers["repeat_next_30d"] = rng.binomial(
    1, 1 / (1 + np.exp(-logit))
)
customers.to_csv("customers.csv", index=False)

m = 6000
orders = pd.DataFrame({
    "order_id": np.arange(1, m + 1),
    "customer_id": rng.integers(1, n + 1, m),
    "order_date": pd.Timestamp("2026-07-01")
        + pd.to_timedelta(rng.integers(0, 92, m), unit="D"),
    "category": rng.choice(["Home", "Tech", "Clothing"], m),
    "quantity": rng.integers(1, 5, m),
    "unit_price": rng.uniform(10, 150, m).round(2),
    "discount": rng.choice([0.0, 0.10, 0.20], m),
    "returned": rng.choice([False, True], m, p=[0.88, 0.12]),
})

# Create a clean PostgreSQL dataset for exercise 1.
ddl = """
DROP TABLE IF EXISTS practice_orders;
CREATE TABLE practice_orders (
    order_id integer PRIMARY KEY,
    customer_id integer NOT NULL,
    order_date date NOT NULL,
    category text NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(10,2) NOT NULL,
    discount numeric(4,2) NOT NULL,
    returned boolean NOT NULL
);
"""
values = []
for row in orders.itertuples(index=False):
    values.append(
        f"({row.order_id},{row.customer_id},"
        f"'{row.order_date:%Y-%m-%d}','{row.category}',"
        f"{row.quantity},{row.unit_price:.2f},"
        f"{row.discount:.2f},{str(row.returned).lower()})"
    )
with open("setup.sql", "w", encoding="utf-8") as f:
    f.write(ddl + "\nINSERT INTO practice_orders VALUES\n")
    f.write(",\n".join(values) + ";\n")

# Deliberately damage a copy for exercises 2, 3, and 5.
raw = orders.copy()
raw["order_date"] = raw["order_date"].dt.strftime("%Y-%m-%d")
raw["unit_price"] = raw["unit_price"].map(lambda x: f"${x:.2f}")
raw["discount"] = raw["discount"].map(lambda x: f"{x:.0%}")
raw["returned"] = raw["returned"].map({True: "Yes", False: "No"})
raw.loc[rng.choice(m, 140, replace=False), "category"] = " tech "
raw.loc[rng.choice(m, 100, replace=False), "unit_price"] = None
raw.loc[rng.choice(m, 25, replace=False), "quantity"] = -1
raw.loc[rng.choice(m, 20, replace=False), "order_date"] = "invalid"
raw = pd.concat(
    [raw, raw.sample(80, random_state=42)], ignore_index=True
)
raw.sample(frac=1, random_state=7).to_csv(
    "orders_raw.csv", index=False
)
print("Created customers.csv, orders_raw.csv, and setup.sql")