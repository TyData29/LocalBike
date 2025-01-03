-- stg_customers.sql

{{
    config(
        materialized='incremental',
        unique_key = ['customer_id'],
        cluster_by = ["customer_id"],
    )
}}

select * from {{ source('source','customers') }}