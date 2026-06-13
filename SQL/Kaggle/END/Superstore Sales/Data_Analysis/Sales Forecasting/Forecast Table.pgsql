DROP TABLE kaggle.sales_forecast;

CREATE TABLE kaggle.sales_forecast(
    year_num INT,
    forecast_month INT,
    predicted_sales NUMERIC(12,2) 
);