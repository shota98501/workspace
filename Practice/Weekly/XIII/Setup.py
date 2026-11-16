import numpy as np
import pandas as pd

rng = np.random.default_rng(20261116)

stations = ["Central", "Riverside", "University", "Market", "Park", "Harbor"]
days = pd.date_range("2026-08-03", periods=56, freq="D")

hours = pd.MultiIndex.from_product(
    [days, stations, range(7, 21)],
    names=["service_date", "station", "hour"],
).to_frame(index=False)

station_base = hours["station"].map(dict(zip(stations, [18, 10, 14, 13, 9, 8])))
weekend = hours["service_date"].dt.dayofweek >= 5
commute = hours["hour"].isin([7, 8, 9, 16, 17, 18])
leisure = hours["hour"].between(11, 15)

# Simulate one weather forecast per day, shared across stations.
daily = pd.DataFrame({
    "service_date": days,
    "forecast_temp_c": rng.normal(24, 4, len(days)).round(1),
    "forecast_rain": rng.random(len(days)) < 0.28,
})
hours = hours.merge(daily, on="service_date", validate="many_to_one")

expected = (
    station_base.to_numpy()
    * np.where(~weekend & commute, 1.65, 1.0)
    * np.where(weekend & leisure, 1.40, 1.0)
    * np.where(hours["forecast_rain"], 0.68, 1.0)
    * np.exp(-0.008 * (hours["forecast_temp_c"] - 24) ** 2)
)
hours["departures"] = rng.poisson(expected)
hours.insert(0, "record_id", np.arange(1, len(hours) + 1))

# Generate a clean SQL table for exercise 1.
ddl = """CREATE TEMP TABLE practice_bike_hours (
    record_id integer PRIMARY KEY,
    service_date date NOT NULL,
    station text NOT NULL,
    hour integer NOT NULL,
    forecast_temp_c numeric(4,1) NOT NULL,
    forecast_rain boolean NOT NULL,
    departures integer NOT NULL,
    UNIQUE (service_date, station, hour)
);
"""
with open("bike_setup.sql", "w", encoding="utf-8") as f:
    f.write(ddl + "\nINSERT INTO practice_bike_hours VALUES\n")
    f.write(",\n".join(
        f"({i}, '{d:%Y-%m-%d}', '{s}', {h}, {t:.1f}, "
        f"{str(r).lower()}, {y})"
        for i, d, s, h, t, r, y in hours.itertuples(index=False, name=None)
    ) + ";\n")

# Introduce export errors for exercise 2.
raw = hours.copy()
raw["service_date"] = raw["service_date"].dt.strftime("%Y-%m-%d")
raw["forecast_temp_c"] = raw["forecast_temp_c"].map(lambda x: f"{x:.1f} C")
raw["forecast_rain"] = raw["forecast_rain"].map({True: "Yes", False: "No"})

idx = rng.choice(raw.index, 100, replace=False)
raw.loc[idx, "station"] = raw.loc[idx, "station"].str.lower().map(" {} ".format)
raw.loc[rng.choice(raw.index, 35, replace=False), "service_date"] = "unknown"
raw.loc[rng.choice(raw.index, 45, replace=False), "forecast_temp_c"] = "missing"
raw.loc[rng.choice(raw.index, 18, replace=False), "hour"] = 25
raw.loc[rng.choice(raw.index, 25, replace=False), "departures"] = -1

pd.concat([raw, raw.sample(55, random_state=16)], ignore_index=True).sample(
    frac=1, random_state=17
).to_csv("bike_hours_raw.csv", index=False)