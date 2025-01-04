-- mart_staff_performance_last_month.sql : Vue des performances du personnel sur le dernier mois terminé

WITH 

staff_perf AS (
    SELECT
       *
    FROM {{ ref('itm_staff_performance') }} 
),

last_month_detected as (
    {{ get_last_month("staff_perf","order_date_year * 100 + order_date_month") }}
),

filter_staff_perf as (
    select * 
    from staff_perf
    join last_month_detected on true
    where (order_date_year * 100 + order_date_month) = last_month_detected.last_month
)

SELECT
    staff_id,
    first_name,
    last_name,
    store_id,
    store_name,
    order_date_year,
    order_date_month,
    orders_total,
    list_base_value_sum,
    revenue_sum,
    average_discount_ratio,
    avg_revenue_per_order
FROM filter_staff_perf
ORDER BY revenue_sum desc