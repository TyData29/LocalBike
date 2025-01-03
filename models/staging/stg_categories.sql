-- stg_categories.sql

{{
    config(
        materialized='view',
        unique_key = ['category_id']
    )
}}

select * from {{ source('source','categories') }}