from django.urls import path, include
from . import views


urlpatterns = [
    path("revenue/monthly", views.revenue_monthly),
    path("kpi/aov", views.kpi_vow),
    path("kpi/repeat-rate", views.kpi_repeat_rate),
    path("revenue/by-category", views.revenue_by_category),
    path("products/top", views.products_top),
]