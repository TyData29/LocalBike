-- stg_stocks.sql

{{
    config(
        unique_key = ['store_id', 'product_id'],
        cluster_by = ['store_id']
    )
}}

select * from {{ source('source','stocks') }}