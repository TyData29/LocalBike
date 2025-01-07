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
        sum(orders_total) as orders_total,
        sum(distinct_customers) as distinct_customers_total,
        sum(sold_products_total) as sold_products_total,
        sum(list_based_value_sum) as list_base_value_sum,
        sum(billed_amount_sum) as revenue_sum,
        sum(billed_amount_sum) / sum(distinct_customers) as avg_revenue_per_client,
        sum(billed_amount_sum) / sum(orders_total) as avg_revenue_per_order
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