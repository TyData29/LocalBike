--assert_total_orders_amount_is_positive.sql : find orders with total amount <= 0

{{ config(
    severity="warn"
)}}


with

order_items as (
    select order_id, sum(billed_amount) as amount from {{ ref('stg_order_items') }} group by order_id
)
select  order_id from order_items where amount <= 0