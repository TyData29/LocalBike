-- itm_staff_performance.sql : Vue des performances du personnel par mois

WITH staff_sales AS (
    SELECT
        s.staff_id,
        s.first_name,
        s.last_name,
        s.store_id,
        st.store_name,
        o.order_date_year,
        o.order_date_month,
        COUNT(o.order_id) AS order_count,
        SUM(list_based_amount) AS total_sales_potential,
        SUM(billed_amount) AS total_revenue
    FROM {{ ref('stg_staffs') }} s
    LEFT JOIN {{ ref('stg_orders') }} o ON s.staff_id = o.staff_id
    LEFT JOIN {{ ref('stg_order_items') }} oi ON o.order_id = oi.order_id
    LEFT JOIN {{ ref('stg_stores') }} st ON s.store_id = st.store_id
    GROUP BY s.staff_id, s.first_name, s.last_name, s.store_id, st.store_name, o.order_date_year,
    o.order_date_month
)
SELECT
    staff_id,
    first_name,
    last_name,
    store_id,
    store_name,
    order_date_year,
    order_date_month,
    order_count,
    total_sales_potential,
    total_revenue,
    round( (total_sales_potential - total_revenue)/total_sales_potential ,2) AS average_discount_ratio,
    total_revenue / NULLIF(order_count, 0) AS avg_revenue_per_order
FROM staff_sales