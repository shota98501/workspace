import os
import random
from datetime import date, timedelta
import numpy as np
import pandas as pd

def random_date(start: date, end: date) -> date:
    """Random date between `start` and `end`"""
    delta_days = (end -start).days
    return start + timedelta(days=random.randint(0, delta_days))

def main():
    random.seed(42)
    np.random.seed(42)

    out_dir = os.path.join(os.path.dirname(__file__), "..", "data")
    os.makedirs(out_dir, exist_ok=True)

    # ---- Paremeters (tune these) ----
    n_customers = 200
    n_products = 50
    n_orders = 500
    start_date = date(2025, 2, 1)
    end_date = date(2026, 1, 15)

    countries = ["japan", "USA" , "Korea", "Taiwan", "Singapore", "UK", "Germany"]
    categories = ["Electronics", "Books", "Home", "Beauty", "Sports", "Food"]

    # ---- customers ----
    customers = []
    for cid in range(1, n_customers + 1):
        signup = random_date(date(2024, 1,1), end_date)
        country = random.choices(countries, weights=[70,8,6,6,4,3,3], k=1)[0]
        customers.append({"id": cid, "signup_date": signup, "country": country})
    df_customers = pd.DataFrame(customers)

    # ---- products ----
    products = []
    for pid in range(1, n_products + 1):
        cat = random.choice(categories)
        products.append(
            {
                "id": pid,
                "product_name": f"{cat} Product {pid:03d}",
                "category": cat,
            
            }
        )
    df_products = pd.DataFrame(products)

    # price ranges by category (more realistic)
    category_price = {
        "Electronics" : (3000, 80000),
        "Books" : (800, 5000),
        "Home" : (1000, 30000),
        "Beauty" : (900, 12000),
        "Sports" : (1500, 40000),
        "Food" : (300, 8000),
    }

    # ---- orders + orders_items ----
    orders = []
    orders_items = []

    # repeat customers: skew selection so some customers order more frequently
    customers_weights = np.random.zipf(a=1.5, size=n_customers).astype(float)
    customers_weights = customers_weights / customers_weights.sum()

    order_id = 1
    order_item_id = 1

    for _ in range(n_orders):
        customers_id = np.random.choice(np.arange(1, n_customers + 1), p=customers_weights)
        odate = random_date(start_date, end_date)

        # items per order
        items_count = random.choices([1,2,3,4,5], weights=[35,30,20,10,5], k=1)[0]

        chosen_products = random.sample(range(1, n_products + 1), k=items_count)
        total = 0.0

        for prod_id in chosen_products:
            prod_cat = df_products.loc[df_products["id"] == prod_id, "category"].iloc[0]
            low, high = category_price[prod_cat]

            quantity = random.choices([1,2,3], weights=[75,20,5], k=1)[0]
            price = random.randint(low,high)

            total += quantity * price

            orders_items.append(
                {
                    "id": order_item_id,
                    "order_id": order_id,
                    "product_id":prod_id,
                    "quantity": quantity,
                    "price": price,
                }
            )
            order_item_id += 1

        # store order    
        orders.append(
            {
                "id":order_id,
                "customer_id":int(customers_id),
                "order_date": odate,
                # keep DECIMAL(10,2) friendly
                "total_amount": round(total, 2)
            }
        )
        order_id += 1
    
    df_orders = pd.DataFrame(orders)
    df_order_items = pd.DataFrame(orders_items)


    # ---- Output CSVs ----
    df_customers.to_csv(os.path.join(out_dir, "customers.csv"), index=False)
    df_products.to_csv(os.path.join(out_dir, "products.csv"), index=False)
    df_orders.to_csv(os.path.join(out_dir, "orders.csv"), index=False)
    df_order_items.to_csv(os.path.join(out_dir, "order_items.csv"), index=False)

    print("✅ Generated CSV files:")
    print(" - data/customers.csv")
    print(" - data/products.csv")
    print(" - data/orders.csv")
    print(" - data/order_items.csv")

    # Quick sanity checks
    assert df_orders["customer_id"].between(1, n_customers).all()
    assert df_order_items["order_id"].between(1, n_orders).all()
    assert df_order_items["product_id"].between(1, n_products).all()
    assert (df_order_items["quantity"] > 0).all()
    assert (df_order_items["price"] >= 0).all()

    print("✅ Sanity checks passed.")


if __name__ == "__main__":
    main()
        

