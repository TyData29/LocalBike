-- stg_stores.sql

select * from {{ source('source','stores') }}