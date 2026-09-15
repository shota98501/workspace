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


 --Trading history summary