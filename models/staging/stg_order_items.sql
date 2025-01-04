-- stg_order_items.sql

{{
    config(
        materialized='incremental',
        unique_key = ['order_id', 'item_id'],
        cluster_by = ["order_id"],
    )
}}

with 
order_items as (
    select * from {{ source('source','order_items') }}
),
-- Calculate metrics
order_items_metrics as (
    select
        *,
        round( quantity * list_price ,2) as list_based_amount,
        round( quantity * list_price * (1 - discount) ,2) as billed_amount,
        round( quantity * list_price * discount ,2) as discount_amount
    from order_items
)

select * from order_items_metrics