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

with 

src_orders as (
    select * from {{ source('source','orders') }}
),

shipped_date_format as (
    select 
        order_id,
        customer_id,
        order_status,
        order_date,
        required_date,
        SAFE.PARSE_DATE('%Y-%m-%d', shipped_date) as shipped_date,
        store_id,
        staff_id
    from src_orders
),

get_date_features as ( -- Extraction de features à partir des champs de date
    select 
        s.*,
        EXTRACT(YEAR FROM order_date)  as order_date_year,
        EXTRACT(MONTH FROM order_date) as order_date_month,
        MOD(EXTRACT(DAYOFWEEK FROM order_date) + 5, 7) + 1 as order_date_weekday, -- Lundi = 1
        DATE_DIFF(required_date, shipped_date, DAY) as shipping_delay

    from shipped_date_format s
)

select * from get_date_features
