<!--- model_descriptions.md --->

## Staging models

## Intermediate models
{% docs itm_staff_performance %}
    Cette vue compile des informations sur les ventes réalisées par chaque employé et calcule des métriques dérivées
{% enddocs %}

{% docs itm_sales %}
    Cette vue compile les informations sur les ventes
{% enddocs %}

{% docs itm_inventory %}
    Cette vue compile les informations sur les stocks disponibles
{% enddocs %}

{% docs itm_customers %}
    Cette vue compile les informations sur les clients
{% enddocs %}



## Marts models
{% docs mart_staff_performance_last_month %}
    Cette table extrait la **tableau des “employés du mois”** (métriques sur les ventes par staff) pour le dernier mois échu.
    Les métriques associées visent à : 
    - Mesurer le CA généré 
    - Contrôler le taux de remise accordé pour sécuriser les marges et homogénéiser les pratiques entre employés
{% enddocs %}

{% docs mart_stores_performance %}
    Cette table extrait une **vue détaillée des ventes par POS** historisée avec une granularité fine.
    Elle sera utilisée pour des analyses poussées sur la performance des points de vente :
    - Evolution des métriques au niveau d'un point de vente en particulier (filtrer sur le point de vente)
    - Comparaison des performances entre les différents points de vente
{% enddocs %}

{% docs mart_stores_performance_last_month %}
    Cette table extrait une **synthèse des ventes par POS pour le dernier mois échu**.
    Elle permet un contrôle rapide des performances récentes de chaque point de vente.
{% enddocs %}

{% docs mart_inventory %}
    Cette table enrichit l'inventaire des stocks **date estimée des ruptures de stock par produit et POS**, calculée en fonction des stocks actuels et des ventes moyennes par jour
    Elle permet d'anticiper les commandes de réapprovisionnement pour éviter les délais de livraison clients et les éventuelles pertes de CA liées à l'indisponibilité des produits stratégiques en POS.
{% enddocs %}

{% docs mart_customers %}
    Cette table enrichit les **informations sur les clients** avec différentes métriques, en particulier sur la durée de la relation client et le statut du client
{% enddocs %}

## Macros
{% docs def__get_last_month %}
    Cet macro permet d'obtenir automatiquement le dernier mois échu (complet)

    Returns : 
        Renvoie au format YYYYMM la référence du dernier mois échu
    Paramètres :
        cte_name : la référence de CTE à partir de laquelle le calcul est réalisé
        date_expr : un champ ou une expression de date au format "YYYYMM"
    Method : 
        La macro calcule la valeur max de order_date_expr (-> le mois en cours) et soustrait 1 mois pour obtenir le dernier mois échu
{% enddocs %}

## Misc