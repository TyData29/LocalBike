-- mart_stores_performance.sql : Activité des points de vente sur le dernier mois terminé
WITH

stores_perf as (
    select * from {{ ref('mart_stores_performance')}}
),

get_current_month as ( -- Id
    select 
        max(order_date_year*100 + order_date_month) as max_order_period
    from stores_perf
),
get_last_month as (
    select 
        case 
            when max_order_period % 100 = 1 then max_order_period -100 +11 -- Si janvier, retrancher 1 an et ajouter 11 mois
            else max_order_period - 1 
        end as last_month
    from get_current_month
),
filter_stores_perf as (
    select * 
    from stores_perf
    join get_last_month on true
    where (order_date_year*100 + order_date_month) = last_month
),
stores_synthetic_sales as (
    select 
        store_name,
        store_state,
        store_zip_code,
        store_city,
        order_date_year,
        order_date_month,
        sum(orders_count) as orders_total,
        sum(distinct_customers) as distinct_customers_total,
        sum(nb_products_total) as selled_products_total,
        sum(list_based_amount_sum) as list_base_value_sum,
        sum(billed_amount_sum) as revenue_sum
    from filter_stores_perf
    group by 
        store_name,
        store_state,
        store_zip_code,
        store_city,
        order_date_year,
        order_date_month
)

