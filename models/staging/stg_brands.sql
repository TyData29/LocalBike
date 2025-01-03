-- stg_brands.sql

{{
    config(
        materialized='view',
        unique_key = ['brand_id']
    )
}}

select * from {{ source('source','brands') }}