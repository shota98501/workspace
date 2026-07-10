INSERT INTO kaggle.products(Product)
SELECT DISTINCT
   Product
FROM kaggle.chocolatesale_raw;

INSERT INTO kaggle.Salesperson(Salesperson)
SELECT DISTINCT
   Salesperson
FROM kaggle.chocolatesale_raw;

INSERT INTO kaggle.orders(Order_id, Order_date, Country, Channel)
SELECT DISTINCT
    Order_id,
    Order_date,
    Country,
    Channel
FROM kaggle.chocolatesale_raw;


INSERT INTO kaggle.order_items(
    Order_id,
    Product_id,
    Salesperson_id,
    Discount_PCt,
    Price_per_Box,
    Marketing_Spend,
    Boxes_Shipped,
    Amount
)
SELECT
    r.Order_id,
    p.Product_id,
    s.Salesperson_id,
    r.Discount_PCt,
    r.Price_per_Box,
    r.Marketing_Spend,
    r.Boxes_Shipped,
    r.Amount
FROM kaggle.chocolatesale_raw r
JOIN kaggle.products p
    ON r.Product = p.Product
JOIN kaggle.Salesperson s
    ON r.Salesperson = s.Salesperson;
