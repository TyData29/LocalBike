-- stg_products.sql

{{
    config(
        materialized='incremental',
        unique_key = ['product_id'],
        cluster_by = ['model_year']
    )
}}

select * from {{ source('source','products') }}