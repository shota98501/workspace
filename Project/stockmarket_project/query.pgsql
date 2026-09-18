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

--Question 4 Highest-volume trading days
with ranked_volume as (
    SELECT
    ticker,
    trade_date,
    volume,

    row_number() over(
        PARTITION by ticker
        order by volume desc
    ) as volume_rank

    from stock_market.stock_prices
)

SELECT *
from ranked_volume
where volume_rank <= 5
order by ticker, volume_rank;

--Question 5 Daily return
SELECT
    ticker,
    trade_date,
    close_price,

    LAG(close_price) OVER (
        PARTITION BY ticker
        ORDER BY trade_date
    ) AS previous_close

FROM stock_market.stock_prices
ORDER BY ticker, trade_date;
