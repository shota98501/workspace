INSERT INTO kaggle.products(Product)
SELECT DISTINCT
   Product
FROM kaggle.chocolatesale_raw;

INSERT INTO kaggle.Salesperson(Salesperson)
SELECT DISTINCT
   Salesperson
FROM kaggle.chocolatesale_raw;

INSERT INTO kaggle.orders
SELECT DISTINCT
    Order_id,
    Order_date,
    Country,
    Channel
FROM kaggle.chocolatesale_raw;

INSERT INTO kaggle.order_items(Discount_PCt, Price_per_Box, Marketing_Spend, Boxes_Shipped, Amount)
SELECT
   Discount_PCt,
   Price_per_Box,
   Marketing_Spend,
   Boxes_Shipped,
   Amount
FROM kaggle.chocolatesale_raw;
