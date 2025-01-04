--stg_inventory: Vue unifiée des stocks (volume et valeur, détail)

WITH inventory_data AS (
    SELECT
        st.store_id,
        st.store_name,
        st.city,
        st.state,
        s.product_id,
        s.quantity AS stock_quantity,
        p.product_name,
        p.category_name,
        p.brand_name,
        p.list_price
    FROM {{ ref('stg_stores') }} st
    JOIN {{ ref('stg_stocks') }} s ON st.store_id = s.store_id
    JOIN {{ ref('stg_products') }} p ON s.product_id = p.product_id
)
SELECT
    store_id,
    store_name,
    city,
    state,
    product_id,
    product_name,
    category_name,
    brand_name,
    stock_quantity,
    list_price
FROM inventory_data