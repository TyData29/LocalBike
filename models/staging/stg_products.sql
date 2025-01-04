-- stg_products.sql : with category and brand name to limit the number of staging tables

WITH 
products as (
    select * from {{ source('source','products') }}
),
brands as (
    select * from {{ source('source','brands') }}
),
categories as (
    select * from {{ source('source','categories') }}
),
joined_products as (
    select
        p.*,
        b.brand_name,
        c.category_name
    from products p
    left join brands b on p.brand_id = b.brand_id
    left join categories c on p.category_id = c.category_id
)
select * from joined_products
