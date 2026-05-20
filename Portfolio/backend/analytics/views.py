from django.shortcuts import render
from django.db import connection
from rest_framework.decorators import api_view
from rest_framework.response import Response

def fetch_all_dict(sql: str, params=None):
    """Run SQL and return list[dict] with column names."""
    with connection.cursor() as cursor:
        cursor.execute(sql, params or [])
        cols =[col[0] for col in cursor.description]
        rows = cursor.fetchall()
    return [dict(zip(cols, row)) for row in rows]

@api_view(["Get"])
def revenue_monthly(request):
    sql = """
        SELECT
          DATE_TRUNC('month', order_date)::date AS month,
          SUM(total_amount) AS revenue
         FROM orders_2
         GROUP BY 1
         ORDER BY 1;
    """

    return Response(fetch_all_dict(sql))

@api_view(["GET"])
def kpi_vow(request):
    sql = "SELECT AVG(total_amount) AS avg_order_value FROM orders_2"
    data = fetch_all_dict(sql)
    return Response(data[0] if data else {"avg_order_value": None})


@api_view(["GET"])
def kpi_repeat_rate(request):
    sql = """
        SELECT
         COUNT(*) FILTER (WHERE order_count > 1)::float
         / NULLIF(COUNT(*), 0) AS repeat_rate
        FROM (
         SELECT customer_id, COUNT(*) AS order_count
         FROM orders_2
         GROUP BY customer_id
         ) t;
    """
    data = fetch_all_dict(sql)
    return Response(data[0] if data else {"repeat_rate": None})

@api_view(["GET"])
def revenue_by_category(request):
    sql = """
        SELECT
         p.category,
         SUM(oi.quantity * oi.price) AS revenue
        FROM order_items_2 oi
        JOIN products_2 p ON oi.product_id = p.id
        GROUP BY p.category
        ORDER BY revenue DESC;
    """
    return Response(fetch_all_dict(sql))

@api_view(["GET"])
def products_top(request):
    # Optional: allow client to request top N, capped for saftey
    limit = int(request.query_params.get("limit", "10"))
    limit = max(1, min(limit, 50))

    sql = """
        SELECT
         p.product_name,
         SUM(oi.quantity * oi.price) AS revenue
        FROM order_items_2 oi
        JOIN products_2 p on oi.product_id = p.id
        GROUP BY p.product_name
        ORDER BY revenue DESC
        LIMIT %s;
    """
    return Response(fetch_all_dict(sql, [limit]))
# Create your views here.
