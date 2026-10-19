# Data Analytics Notes

## Inspecting a DataFrame

First 5 rows:
`df.head()`

Number of rows and columns:
`df.shape`

Column names:
`df.columns.tolist()`

Data types:
`df.dtypes`

Dataset overview:
`df.info()`

Missing values:
`df.isna().sum()`


## Working with Dates

Convert a text column to datetime:
`pd.to_datetime()`

Example:
`df["date"] = pd.to_datetime(df["date"])`

## Data Quality Checks

Count duplicate rows:
`df.duplicated().sum()`

Count missing values by column:
`df.isna().sum()`