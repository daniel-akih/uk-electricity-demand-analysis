from pathlib import Path
import sqlite3

import pandas as pd

# Find the project folder
PROJECT_ROOT = Path(__file__).resolve().parent.parent

# Define file locations
CSV_PATH = PROJECT_ROOT / "data" / "raw" / "demanddata_2024.csv"
DB_PATH = PROJECT_ROOT / "data" / "electricity_demand.db"

# Read the CSV
df = pd.read_csv(CSV_PATH)

# Convert the date column
df["SETTLEMENT_DATE"] = pd.to_datetime(
    df["SETTLEMENT_DATE"],
    format="%d-%b-%Y"
)

# Open the SQLite database and save the data
with sqlite3.connect(DB_PATH) as conn:
    df.to_sql(
        "electricity_demand",
        conn,
        if_exists="replace",
        index=False
    )

print("Database created successfully!")
print(f"Rows loaded: {len(df):,}")
print(f"Database location: {DB_PATH}")