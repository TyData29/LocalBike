# marts.md

## Marts models
{% docs mart_t__staff_performance_last_month %}
    Cette table extrait la **tableau des “employés du mois”** (métriques sur les ventes par staff) pour le dernier mois échu
{% enddocs %}

{% docs mart_t__stores_performance %}
    Cette table extrait une **vue détaillée des ventes par POS** historisée avec une granularité fine : elle sera utilisée pour des analyses poussées sur la performance des points de vente
{% enddocs %}

{% docs mart_t__stores_performance_last_month %}
    Cette table extrait une **synthèse des ventes par POS pour le dernier mois échu**
{% enddocs %}

## Marts fields

### Champs date & assimilés

{% docs f_order_date %}
    Date de la commande (YYYY-mm-dd)
{% enddocs %}

{% docs f_order_date_year %}
    Année de la commande
{% enddocs %}

{% docs f_order_date_month %}
    Mois de la commande
{% enddocs %}

{% docs f_order_date_weekday %}
    Jour de la semaine de la commande
{% enddocs %}

### Dimensions

**Stores**

{% docs f_store_id %}
    Identifiant du POS
{% enddocs %}

{% docs f_store_name %}
    Nom du POS
{% enddocs %}

{% docs f_store_state %}
    Etat (US) du POS
{% enddocs %}

{% docs f_store_zip_code %}
    ZIP Code du POS
{% enddocs %}

{% docs f_store_city %}
    Ville du POS
{% enddocs %}

**Products**

{% docs f_category_name %}
    Catégorie du produit
{% enddocs %}

{% docs f_brand_name %}
    Marque du produit
{% enddocs %}

{% docs f_product_name %}
    Désignation du produit
{% enddocs %}

**Staff**

{% docs f_staff_id %}
    Identifiant employé
{% enddocs %}

**Génériques**

{% docs f_first_name %}
    Prénom
{% enddocs %}

{% docs f_last_name %}
    Nom
{% enddocs %}

### Métriques

**Orders** 

{% docs f_orders_total %}
    Nombre total de commandes
{% enddocs %}

{% docs f_selled_products_total %}
    Nombre total de produits vendus
{% enddocs %}

{% docs f_list_base_value_sum %}
    Valeur totale (au prix catalogue)
{% enddocs %}

{% docs f_revenue_sum %}
    CA total
{% enddocs %}

{% docs f_average_discount_ratio %}
    % de remise moyen
{% enddocs %}

{% docs f_avg_revenue_per_order %}
    Panier moyen
{% enddocs %}

**Clients**

{% docs f_distinct_customers_total %}
    Nombre total de clients distincts
{% enddocs %}

