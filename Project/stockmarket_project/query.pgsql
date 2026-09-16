SELECT *
FROM stock_market.stock_prices
LIMIT 10;

SELECT COUNT(*)
FROM stock_market.stock_prices;

SELECT DISTINCT ticker
FROM stock_market.stock_prices;

SELECT
    MIN(trade_date),
    MAX(trade_date)
FROM stock_market.stock_prices;


--Question 1 Trading history summary
 SELECT
 ticker,
 min(trade_date) as first_date,
 max(trade_date) as last_date,
 count(trade_date) as trading_days,
 avg(close_price) as avg_close
 from stock_market.stock_prices
 GROUP by ticker;

 --Question 2 Highest and lowest closing price
 SELECT
 ticker,
 max(close_price) as highest_close,
 min(close_price) as lowest_close
 FROM stock_market.stock_prices
 GROUP BY ticker;

 --Question 3 Monthly trading performance
SELECT
date_trunc('month', trade_date) as month,
ticker,
avg(close_price) as avg_close
from stock_market.stock_prices
GROUP BY month, ticker
order by avg_close DESC;