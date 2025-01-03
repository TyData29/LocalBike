-- stg_stores.sql

{{
    config(
        unique_key = ['store_id']
    )
}}

select * from {{ source('source','stores') }}