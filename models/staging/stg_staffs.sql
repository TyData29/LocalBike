-- stg_staffs.sql

select * from {{ source('source','staffs') }} order by store_id, manager_id