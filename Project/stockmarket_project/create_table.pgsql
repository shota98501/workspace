Create SCHEMA stock_market;

DROP TABLE stock_market.stock_prices;

create table stock_market.stock_prices(
    id BIGSERIAL PRIMARY KEY,
    trade_date DATE NOT NULL,
    ticker VARCHAR(50) NOT NULL,
    open_price numeric(18,4),
    high_price numeric(18,4),
    low_price numeric(18,4),
    close_price numeric(18,4),
    volume BIGINT
);