{% macro get_last_month(cte_name, date_expr) %}
{# 
    Renvoie au format YYYYMM la référence du dernier mois échu
    Paramètres :
        cte_name : la référence de CTE à partir de laquelle le calcul est réalisé
        date_expr : un champ ou une expression de date au format YYYYMM
    La macro calcule la valeur max de order_date_expr (-> le mois en cours) et soustrait 1 mois pour obtenir le dernier mois échu
 #}
  with get_current_month as (
    select 
      CAST(max( {{ date_expr }} ) AS INT64) as max_order_period
    from {{ cte_name }}
  ),
  get_last_month as (
    select 
      case 
        when MOD(max_order_period, 100) = 1 then max_order_period - 100 + 11 -- Si janvier, retrancher 1 an et ajouter 11 mois
        else max_order_period - 1 
      end as last_month
    from get_current_month
  )
  select CAST(last_month AS INT64) as last_month from get_last_month
{% endmacro %}