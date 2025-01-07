-- mart_stores_performance_last_month.sql : Activité des points de vente sur le dernier mois terminé
WITH

stores_perf as (
    select * from {{ ref('mart_stores_performance') }}
),

last_month_detected as (
    {{ get_last_month("stores_perf","order_date_year * 100 + order_date_month") }}
),

filter_stores_perf as (
    select * 
    from stores_perf
    join last_month_detected on true
    where (order_date_year * 100 + order_date_month) = last_month_detected.last_month
),
stores_synthetic_sales as (
    select 
        store_name,
        store_state,
        store_zip_code,
        store_city,
        order_date_year,
        order_date_month,
        sum(orders_total) as orders_total,
        sum(distinct_customers_total) as distinct_customers_total,
        sum(sold_products_total) as sold_products_total,
        sum(list_base_value_sum) as list_base_value_sum,
        sum(revenue_sum) as revenue_sum
    from filter_stores_perf
    group by 
        store_name,
        store_state,
        store_zip_code,
        store_city,
        order_date_year,
        order_date_month
)
select * from stores_synthetic_sales
