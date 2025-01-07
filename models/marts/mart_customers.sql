-- mart_customers.sql
WITH customer_lifetime_value AS (
    SELECT
        customer_id,
        CONCAT(first_name, ' ', last_name) AS customer_name,
        city,
        state,
        MIN(first_order_date) AS first_order_date,
        MAX(last_order_date) AS last_order_date,
        DATE_DIFF(MAX(last_order_date), MIN(first_order_date), DAY) AS customer_lifetime_days,
        SUM(billed_amount_sum) AS revenue_sum,
        SUM(orders_total) AS orders_total,
        SUM(sold_products_total) AS sold_products_total,
        SUM(billed_amount_sum) / NULLIF(SUM(orders_total), 0) AS avg_revenue_per_order,
        CASE
            WHEN DATE_DIFF(CURRENT_DATE(), MAX(last_order_date), DAY) <= 182 THEN 'Active' -- Dernière commande <= 6 mois
            WHEN DATE_DIFF(CURRENT_DATE(), MAX(last_order_date), DAY) BETWEEN 183 AND 365*2 THEN 'Sleeping' -- Dernière commande <= 2 ans
            ELSE 'Inactive'
        END AS customer_status
    FROM {{ ref('itm_customers') }}
    GROUP BY
        customer_id,
        first_name,
        last_name,
        city,
        state
)
SELECT * FROM customer_lifetime_value
