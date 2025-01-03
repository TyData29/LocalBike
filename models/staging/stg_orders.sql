-- stg_orders.sql

{{
    config(
        materialized='incremental',
        unique_key = ['order_id'],
        cluster_by = ['store_id'],
        partition_by = {
            'field': 'order_date',
            'data_type': 'date',
            'granularity' : 'year'
        },
    )
}}

select * from {{ source('source','orders') }}