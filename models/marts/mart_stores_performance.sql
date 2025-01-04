-- mart_stores_performance.sql : Activité des points de vente


WITH 

-- Calling staging & itm datasets
stores_sales as (
    select * from {{ ref('itm_sales') }}
),
stores_synthetic_sales as (
    select 
        store_name,
        store_state,
        store_zip_code,
        store_city,
        order_date,
        order_date_year,
        order_date_month,
        order_date_weekday,
        category_name,
        brand_name,
        product_name,
        sum(orders_count) as orders_total,
        sum(distinct_customers) as distinct_customers_total,
        sum(nb_products_total) as selled_products_total,
        sum(list_based_amount_sum) as list_base_value_sum,
        sum(billed_amount_sum) as revenue_sum
    from stores_sales
    group by 
        store_name,
        store_state,
        store_zip_code,
        store_city,
        order_date,
        order_date_year,
        order_date_month,
        order_date_weekday,
        category_name,
        brand_name,
        product_name
)
select * from stores_synthetic_sales