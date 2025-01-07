<!--- sources_descriptions.md --->

## Sources : localbike

{% docs srcs_localbike %}
    Les données sources proviennent de la solution logicielle ERP interne de Local Bike.
{% enddocs %}

### tables
{% docs src_brands %}
    Cette table source contient la liste des marques de vélos proposés par LocalBike
{% enddocs %}

{% docs src_categories %}
    Cette table source contient les catégories de vélos proposés par LocalBike
{% enddocs %}

{% docs src_customers %}
    Cette table source contient la liste des clients de LocalBike, ainsi que leurs coordonnées
{% enddocs %}

{% docs src_order_items %}
    Cette table source associe les produits commandés, leur quantité et prix (catalogue, réduction), et les commandes
{% enddocs %}

{% docs src_orders %}
    Cette table source contient les informations concernant les commandes
{% enddocs %}

{% docs src_products %}
    Cette table source contient la liste des produits proposés par LocalBike, avec les identifiants de catégorie et de marque, l'année-modèle et le prix catalogue
{% enddocs %}

{% docs src_staffs %}
    Cette table source contient la liste des employés de LocalBike, leurs coordonnées, leur magasin de référence et l'identifiant de leur manager
{% enddocs %}

{% docs src_stocks %}
    Cette table source décrit la quantité de produits stockés par chaque magasin, pour chaque référence produit
{% enddocs %}

{% docs src_stores %}
    Cette table source contient la liste des magasins LocalBike, ainsi que leurs coordonnées
{% enddocs %}

## Other sources
