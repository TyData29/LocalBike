--assert_total_customer_orders_at_least_1.sql : Find customers with total orders amount <=0

{{ config(
    severity="warn"
)}}

with

customers_orders as (
    select customer_id, sum(billed_amount) as amount 
    from   
        {{ ref('stg_order_items') }} i
        join {{ ref('stg_orders') }} o on i.order_id = o.order_id
    group by customer_id
)
select customer_id from customers_orders where amount <= 0