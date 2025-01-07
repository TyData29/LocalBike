-- itm_customers.sql : compile informations about customers

with 
customers as (
    select * from {{ ref('stg_customers') }}
),
sales as (
    select * from {{ ref('itm_sales') }}
),
join_customers_orders as (
    select 
        c.*,
        {{ dbt_utils.star(from=ref('itm_sales'), quote_identifiers=False, relation_alias='s', except=["customer_id"]) }}
    from customers c
    join sales s
        on c.customer_id = s.customer_id
),
get_metrics as (
    select
        -- Dimensions from customers
        customer_id,
        first_name,
        last_name,
        phone,
        email,
        street,
        city,
        state,
        zip_code,
        -- Dimensions from sales
        store_id,
        store_name,
        store_state,
        store_city,
        min(order_date) as first_order_date,
        max(order_date) as last_order_date,
        sum(orders_total) as orders_total,
        sum(sold_products_total) as sold_products_total,
        sum(list_based_value_sum) as list_based_value_sum,
        sum(billed_amount_sum) as billed_amount_sum,
        sum(list_based_value_sum) / sum(billed_amount_sum) as average_discount_ratio
    from join_customers_orders
    group by 
        -- Dimensions from customers
        customer_id,
        first_name,
        last_name,
        phone,
        email,
        street,
        city,
        state,
        zip_code,
        -- Dimensions from sales
        store_id,
        store_name,
        store_state,
        store_city
)

select * from get_metrics