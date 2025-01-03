-- stg_order_items.sql

{{
    config(
        materialized='incremental',
        unique_key = ['order_id', 'item_id'],
        cluster_by = ["order_id"],
    )
}}

select * from {{ source('source','order_items') }}