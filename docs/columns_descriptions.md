# Fields descriptions


## Dimensions

**Génériques**

{% docs first_name %}
    Prénom
{% enddocs %}

{% docs last_name %}
    Nom
{% enddocs %}

{% docs phone %}
    N° de téléphone
{% enddocs %}

{% docs email %}
    Email
{% enddocs %}

{% docs street %}
    Adresse
{% enddocs %}

{% docs city %}
    Ville
{% enddocs %}

{% docs state %}
    Etat (US)
{% enddocs %}

{% docs zip_code %}
    ZIP Code (US)
{% enddocs %}

**Champs date & assimilés**

{% docs order_date %}
    Date de la commande (YYYY-mm-dd)
{% enddocs %}

{% docs order_date_year %}
    Année de la commande
{% enddocs %}

{% docs order_date_month %}
    Mois de la commande
{% enddocs %}

{% docs order_date_weekday %}
    Jour de la semaine de la commande
{% enddocs %}

{% docs required_date %}
    Date de livraison prévue
{% enddocs %}

{% docs shipped_date %}
    Date d'expédition
{% enddocs %}

**Commandes**

{% docs order_id %}
    Identifiant de la commande
{% enddocs %}

{% docs item_id %}
    Identifiant de l'item dans la commande
{% enddocs %}

{% docs quantity %}
    Quantité
{% enddocs %}

{% docs discount %}
    Taux de remise (%)
{% enddocs %}

{% docs order_status %}
    Etat de la commande
{% enddocs %}

**Stores**

{% docs store_id %}
    Identifiant du POS
{% enddocs %}

{% docs store_name %}
    Nom du POS
{% enddocs %}

{% docs store_state %}
    Etat (US) du POS
{% enddocs %}

{% docs store_zip_code %}
    ZIP Code du POS
{% enddocs %}

{% docs store_city %}
    Ville du POS
{% enddocs %}

**Products**

{% docs product_id %}
    Identifiant unique du produit
{% enddocs %}

{% docs product_name %}
    Désignation du produit
{% enddocs %}

{% docs list_price %}
    Prix unitaire catalogue
{% enddocs %}

{% docs model_year %}
    Année-modèle
{% enddocs %}

**Marques**

{% docs brand_id %}
    Identifiant de la marque
{% enddocs %}

{% docs brand_name %}
    Marque du produit
{% enddocs %}

**Catégories**

{% docs category_id %}
    Identifiant de la catégorie
{% enddocs %}

{% docs category_name %}
    Catégorie du produit
{% enddocs %}

**Staff**

{% docs staff_id %}
    Identifiant employé
{% enddocs %}

{% docs active %}
    Actif (1) / Inactif (0)
{% enddocs %}

{% docs manager_id %}
    Indentifiant du manager
{% enddocs %}

**Customers**

{% docs customer_id %}
    Identifiant client
{% enddocs %}

## Métriques

**Orders** 

{% docs billed_amount %}
    Prix réellement facturé compte tenu de la remise client
{% enddocs %}
    
{% docs discount_amount %}
    Montant de la remise client
{% enddocs %}

{% docs orders_total %}
    Nombre total de commandes
{% enddocs %}

{% docs sold_products_total %}
    Nombre total de produits vendus
{% enddocs %}

{% docs list_based_amount %}
    Valeur de l'item au prix catalogue (prix unitaire x quantité)
{% enddocs %}

{% docs list_based_value_sum %}
    Valeur totale (au prix catalogue)
{% enddocs %}

{% docs revenue_sum %}
    CA total
{% enddocs %}

{% docs billed_amout_sum %}
    Montant total facturé
{% enddocs %}

{% docs average_discount_ratio %}
    % de remise moyen
{% enddocs %}

{% docs avg_revenue_per_order %}
    Panier moyen
{% enddocs %}

{% docs avg_daily_sales %}
    Nombre moyen journalier de ventes
{% enddocs %}

{% docs shipping_delay %}
    Retard d'expédition (en jours)
 {% enddocs %}   

{% docs first_order_date %}
    Date de la première commande
 {% enddocs %}   

{% docs last_order_date %}
    Date de la dernière commande
 {% enddocs %}   


**Clients**

{% docs customer_name %}
    Prénom + Nom du client
{% enddocs %}

{% docs distinct_customers_total %}
    Nombre total de clients distincts
{% enddocs %}

{% docs avg_revenue_per_client %}
    CA moyen par client
{% enddocs %}

{% docs customer_status %}
    Statut du client (Active / Sleeping / Inactive)
 {% enddocs %}   

{% docs customer_lifetime_days %}
    Durée de la relation client (en jours)
 {% enddocs %}   

**Stocks**

{% docs stock_quantity %}
    Nombre d'unités de produit en stock
{% enddocs %}

{% docs estimated_stock_out_date %}
    Date estimée de rupture des stocks actuels
{% enddocs %}