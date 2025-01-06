-- itm_sales.sql
/*
Join all staged informations about selling process
*/

WITH 

-- Calling staging datasets
orders as (
    select 
        order_id,
        customer_id,
        order_date,
        order_date_year,
        order_date_month,
        order_date_weekday,
        store_id,
        staff_id
    from {{ ref('stg_orders') }}
),

order_items as (
    select
        order_id,
        product_id,
        quantity,
        list_price,
        discount,
        list_based_amount,
        billed_amount
    from {{ ref('stg_order_items') }}
),

products as (
    select
        product_id,
        product_name,
        brand_name,
        category_name,
        model_year
    from {{ ref('stg_products') }}
),
customers as (
    select
        customer_id,
        state as customer_state,
        zip_code as customer_zip_code,
        city as customer_city
    from {{ ref('stg_customers') }}
),
stores as (
    select 
        store_id,
        store_name,
        state as store_state,
        zip_code as store_zip_code,
        city as store_city
    from {{ ref('stg_stores') }}
),

-- Join all sources
join_sales as (
    select
        -- orders
        o.order_id,
        o.order_date,
        o.order_date_year,
        o.order_date_month,
        o.order_date_weekday,
        -- order_items
        i.list_price,
        i.discount,
        i.quantity,
        i.list_based_amount,
        i.billed_amount,
        -- stores
        s.store_id,
        s.store_name,
        s.store_state,
        s.store_zip_code,
        s.store_city,
        -- customers
        c.customer_id,
        c.customer_state,
        c.customer_zip_code,
        c.customer_city,
        -- products
        p.product_id,
        p.product_name,
        p.model_year,
        p.category_name,
        p.brand_name

    from orders o
    join order_items i 
        on o.order_id = i.order_id
    join products p
        on i.product_id = p.product_id
    join customers c
        on o.customer_id = c.customer_id
    join stores s
        on o.store_id = s.store_id
),

-- Aggregate & add features
agg_sales as (
    select
        -- orders
        order_date,
        order_date_year,
        order_date_month,
        order_date_weekday,
        -- stores
        store_id,
        store_name,
        store_state,
        store_zip_code,
        store_city,
        -- customers
        customer_state,
        customer_zip_code,
        customer_city,
        -- products
        product_id,
        product_name,
        model_year,
        category_name,
        brand_name,
        -- metrics
        count(distinct customer_id) as distinct_customers,
        count(order_id) as orders_count,
        sum( list_based_amount ) as list_based_amount_sum,
        sum( billed_amount ) as billed_amount_sum,
        sum(quantity) as nb_products_total

    from join_sales
    group by 
        order_date,
        order_date_year,
        order_date_month,
        order_date_weekday,
        store_id,
        store_name,
        store_state,
        store_zip_code,
        store_city,
        customer_state,
        customer_zip_code,
        customer_city,
        product_id,
        product_name,
        model_year,
        category_name,
        brand_name
)

select * from agg_sales


