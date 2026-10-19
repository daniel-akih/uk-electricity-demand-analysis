-- Average National Demand by month, 2024
SELECT
    strftime('%m', SETTLEMENT_DATE) AS month,
    ROUND(AVG(ND), 2) AS avg_demand_mw,
    ROUND(MIN(ND), 2) AS min_demand_mw,
    ROUND(MAX(ND), 2) AS max_demand_mw
FROM electricity_demand
GROUP BY strftime('%m', SETTLEMENT_DATE)
ORDER BY month;

-- Rank months by average National Demand
WITH monthly_demand AS (
    SELECT
        strftime('%m', SETTLEMENT_DATE) AS month,
        ROUND(AVG(ND), 2) AS avg_demand_mw
    FROM electricity_demand
    GROUP BY strftime('%m', SETTLEMENT_DATE)
)
SELECT
    month,
    avg_demand_mw,
    RANK() OVER (
        ORDER BY avg_demand_mw DESC
    ) AS demand_rank
FROM monthly_demand
ORDER BY demand_rank;

-- Calculate a 7-day moving average of daily National Demand
-- Analysis: 7-day moving average of daily National Demand
-- Purpose: Smooth short-term demand fluctuations to reveal broader trends.
-- Method: Calculate daily mean ND, then apply a trailing 7-day window.
-- Note: The first six dates use a partial window.
WITH daily_demand AS (
    SELECT
        DATE(SETTLEMENT_DATE) AS demand_date,
        ROUND(AVG(ND), 2) AS avg_daily_demand_mw
    FROM electricity_demand
    GROUP BY DATE(SETTLEMENT_DATE)
)
SELECT
    demand_date,
    avg_daily_demand_mw,
    ROUND(
        AVG(avg_daily_demand_mw) OVER (
            ORDER BY demand_date
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ),
        2
    ) AS moving_avg_7day_mw
FROM daily_demand
ORDER BY demand_date;

-- Identify the 10 highest National Demand observations
SELECT
    SETTLEMENT_DATE,
    SETTLEMENT_PERIOD,
    ND AS demand_mw
FROM electricity_demand
ORDER BY ND DESC
LIMIT 10;