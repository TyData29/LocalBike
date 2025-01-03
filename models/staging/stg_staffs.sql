-- stg_staffs.sql

{{
    config(
        unique_key = ['staff_id'],
        cluster_by = ['store_id']
    )
}}

select * from {{ source('source','staffs') }}