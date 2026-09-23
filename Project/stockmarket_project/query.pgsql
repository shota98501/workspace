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
WITH price_history AS (
    SELECT
        ticker,
        trade_date,
        close_price,

        LAG(close_price) OVER (
            PARTITION BY ticker
            ORDER BY trade_date
        ) AS previous_close

    FROM stock_market.stock_prices
)

SELECT
    ticker,
    trade_date,
    close_price,
    previous_close,

    (close_price - previous_close)
        / NULLIF(previous_close, 0) AS daily_return

FROM price_history
ORDER BY ticker, trade_date;


--Q6 Best and worst trading days
WITH cte1 as (
    SELECT
    ticker,
    trade_date,
    close_price,

    lag(close_price) over(
        PARTITION BY ticker
        order by trade_date
    ) as previous_close

    from stock_market.stock_prices
),

cte2 as (
SELECT
    ticker,
    trade_date,
    close_price,
    previous_close,

    (close_price - previous_close)
        / NULLIF(previous_close, 0) AS daily_return

    from cte1
),
cte3 as(
    SELECT
    ticker,
    trade_date,
    daily_return,

    row_number() over(
        PARTITION by ticker
        order by daily_return desc
    ) as best_rank,

    row_number() over(
        PARTITION by ticker
        order by daily_return ASC
    ) as worst_rank

    from cte2
    where daily_return is not null
)
SELECT *
from cte3
where best_rank = 1
or worst_rank = 1
order by ticker;


--Question 7 30-day moving average
SELECT
    ticker,
    trade_date,
    close_price,

    AVG(close_price) OVER (
        PARTITION BY ticker
        ORDER BY trade_date
        ROWS BETWEEN 29 PRECEDING AND CURRENT ROW
    ) AS moving_avg_30

FROM stock_market.stock_prices
ORDER BY ticker, trade_date;