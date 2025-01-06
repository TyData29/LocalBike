-- mart_stoks_turnover.sql : Délai avant rupture de stock par produit et magasin à partir de l'inventaire et des ventes passées
with

inventory as (
    select * from {{ ref('itm_inventory') }}
),
sales as (
    select * from {{ ref('itm_sales') }}
),
sales_max_date as (
    SELECT MAX(order_date) as order_date_max FROM sales
),

filtered_sales as ( -- Limiter l'analyse à 1 an avant la dernière vente
    select * 
    from sales, sales_max_date
    WHERE order_date >= DATE_SUB(order_date_max, INTERVAL 1 YEAR)
),

date_range AS ( -- Génère toutes les dates correspondant à la période supérieur à 1 an avant la dernière vente
    SELECT 
        day AS date
    FROM sales_max_date,
        UNNEST(
            GENERATE_DATE_ARRAY(
                DATE_SUB(sales_max_date.order_date_max, INTERVAL 1 YEAR), 
                (sales_max_date.order_date_max),
                INTERVAL 1 DAY
            )
        ) AS day
),
stores_sales_by_product as ( -- Aggréger les ventes par date de commande, produit et POS
    select store_id, product_id, order_date, sum(nb_products_total) as daily_sales 
    from filtered_sales
    group by store_id, product_id, order_date
),
full_date_sales AS (
    SELECT 
        d.date AS order_date, 
        s.store_id, 
        s.product_id, 
        COALESCE(s.daily_sales, 0) AS daily_sales
    FROM date_range d
    LEFT JOIN stores_sales_by_product s
        ON d.date = s.order_date
),
join_invent_n_sales as (
    select 
        i.*,
        s.order_date,
        s.daily_sales
    from inventory i 
    join stores_sales_by_product s 
        on (i.store_id, i.product_id) = (s.store_id, s.product_id)
),
average_daily_sales AS (
    SELECT 
        store_id, 
        product_id, 
        ROUND(AVG(daily_sales),1) AS avg_daily_sales
    FROM join_invent_n_sales
    WHERE daily_sales IS NOT NULL
    GROUP BY store_id, product_id
),
stock_turnover_prediction AS (
    SELECT 
        i.store_id,
        i.store_name,
        i.city,
        i.state,
        i.product_id,
        i.product_name,
        i.brand_name,
        i.category_name,
        i.stock_quantity,
        a.avg_daily_sales,
        CASE 
            WHEN i.stock_quantity < 1 THEN CURRENT_DATE()
            WHEN a.avg_daily_sales > 0 THEN DATE_ADD(CURRENT_DATE(), INTERVAL CAST(FLOOR(i.stock_quantity / a.avg_daily_sales) AS INT64) DAY)
            ELSE NULL
        END AS estimated_stock_out_date
    FROM inventory i
    LEFT JOIN average_daily_sales a
        ON i.store_id = a.store_id AND i.product_id = a.product_id
)

SELECT 
    store_id,
    store_name, 
    product_id,
    category_name,
    brand_name,
    product_name, 
    stock_quantity, 
    avg_daily_sales, 
    estimated_stock_out_date
FROM stock_turnover_prediction