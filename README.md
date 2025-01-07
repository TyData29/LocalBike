Welcome to localbike dbt project!

### Purpose

This project uses LocalBike datas in order to prepare and set marts for dashboards using DBT.

The context is the final project of Databird Analytics Engineer training course.

We will be abble to :
- Find analysis axes for operations team of Localbike
- Help the team to optimize sells and maximize incomes using smart insights

## Datas

The datasets lies in BigQuery

## Main points & method
### [EN]

**Project initalizing**
- **Due to difficulties encountered in setting up DBT Cloud** (free accounts expired), I chose to use DBT Core for this project.
- **Importing RAW data into BigQuery** did not pose any issues.
- **Initializing the DBT project locally** presented some challenges with the connection to BigQuery, which were quickly resolved by creating:
    - A new role with the appropriate privileges
    - A new JSON service key
- **In DBT**, the first step was to define the project sources and document them:
    - I created and populated:
        - A file: `sources/sources.yml`
        - A documentation file: `sources/sources.md`
    - I ran a `dbt compile` to verify the setup.
    - I had to correct the name of the source in `sources/sources.yml`, which must match the schema name in BigQuery.
    - **Packages** :
        - I used the `dbt-utils` package for specific tests and SQL generation
    - **Tests**:
        - `not null` and `unique` tests were implemented on the primary keys of each RAW table.
        - `not null` tests were implemented on foreign keys.
        - All these tests passed.

**Staging models**
- Staging models make few modifications to the source data, except for:
    - The `stg_orders` table:
        - Reformatting `string->date` for the **shipped_date** field
        - Adding a few date-related features
    - The `stg_products` table:
        - Directly includes `brand_name` and `category_name` through joins to limit the number of tables to operate on.
- **Materialization choices**:
    - Considering LocalBike's growth objectives, I anticipated significant dataset growth by:
        - Implementing incremental materializations
        - Clustering and, in some cases, partitioning for tables most likely to grow significantly (e.g., `customers`, `orders`, `order_items`).
- **Tests**:
    - Focused on value verification (`accepted_values`), relationships between tables (`relationships`), and custom logic:
        - `assert_total_orders_amount_is_positive`: checks order consistency.
        - `assert_total_customer_orders_at_least_1`: ensures all customers have at least one order.

**Intermediate models**
- **Purpose**:
    - Perform the main transformations on the data to enable the creation of marts (business-oriented models).
    - Not designed to be shared directly, except with designated data champions in business teams.
    - Therefore, the documentation effort is minimal.
- **Materialization choice**: Views.
- **Tests**:
    - One test checking date consistency: `last_order_date >= first_order_date`.

**Marts**
- **Defined marts**:
    - `mart_stores_performance`: extracts a detailed sales history by POS.
    - `mart_stores_performance_last_month`: extracts a sales summary by POS for the most recent completed month.
    - `mart_staff_performance_last_month`: provides the "employee of the month" dashboard for the most recent completed month.
    - `mart_inventory`: provides estimated stock-out dates per product and POS to optimize supplier orders.
    - `mart_customers`: enhances customer insights, particularly through their status (active, sleeping, inactive).
- **Use of macros**:
    - The last two marts leverage the macro `get_last_month()` to modularly identify the most recent completed month.
- **Materialization choice**: Tables, to speed up dashboard display.
- **Documentation**: Complete and detailed.

**Documentation management**
- Descriptions of sources, models, macros, and columns are centralized in three Markdown files in the `docs/` directory:
    - `sources_descriptions.md`
    - `models_descriptions.md`
    - `columns_descriptions.md`
- These files are logically organized to make documentation management as easy as possible.

### [FR]

**Initlialisation du projet** 

- **Suite à des difficultés rencontrées pour paramétrer DBT Cloud** (comptes gratuits expirés), j’ai fait le choix d’utiliser DBT Core pour ce projet
- **L’import des données RAW dans BigQuery** n’a pas posé de problème
- **L’initialisation du projet DBT en local** a posé quelques difficultés au niveau de la connexion à BigQuery, rapidement résolues par la création d’un nouveau rôle avec les privilèges adaptés et d’une nouvelle clé de services JSON
- **Dans DBT**, la première étape a été de définir les sources du projet et de les documenter
    - J’ai créé et renseigné :
        - Un fichier `sources/sources.yml`
        - Un fichier de documentation sur les sources `sources/sources.md`
    - J’ai lancé un `dbt compile` pour vérification
    - J’ai du corriger le name de la source dans `sources/sources.yml`, qui doit correspondre au nom du schéma dans BigQuery
    - **Packages** :
        - J'ai utilisé le package `dbt-utils` pour des tests spécifiques et des fonctions de génération SQL
    - **Tests** : J’ai mis en place de tests `not null` et `unique` sur les clés primaires de chaque table RAW, ainsi que des tests `not null` sur les clés étrangères : tous ces tests passent

**Modèles de staging**
    - Dans l’ensemble, les modèles de staging apportent assez peu de modifications aux données sources, à l’exception de :
        - la table `stg_orders` qui connait un reformatage `string->date` pour le champ **shipped_date** et ****se voit ajouter quelques features liées aux dates
        - la table `stg_products` qui héberge directement, grâce à des jointures `brand_name` et `category_name` pour limiter le nombre de tables à opérer
    - **Choix de matérialisation** :
        - Globalement, compte-tenu des objectifs de croissance de LocalBike, j’ai choisi d’anticiper une augmentation assez forte de la taille de certains dataset et de mettre en place des matérialisations incrémentales, du clustering et parfois du partitionnement sur les tables les plus succeptibles de connaitre un fort développement (customers, orders, order_items)
    - **Tests** : au niveau du staging, les tests sont orientés vers la vérification des valeurs (`accepted_values`), des relations entre les tables (`relationships`), et de la cohérence des commandes (test personnalisé : `assert_total_orders_amount_is_positive` ) et de la définition des clients (test personnalisé : `assert_total_customer_orders_at_least_1`)

**Modèles intermédiaires**
    - Les modèles intermédiaires définis produisent les principales transformations sur les données, de manière à permettre la création de marts (modèles orientées vers les logiques métier)
    - Ils n’ont pas vocation à être mis à disposition directement, sauf éventuellement pour des data champions désignés dans les équipes métiers, capables de rentrer en profondeur dans les données. Par conséquent, l’effort de documentation est moindre
    - **Choix de matérialisation** : vues
    - **Tests** : 1 test vérifiant la cohérence entre 2 dates `last_order_date >= first_order_date`

**Marts**
    - `mart_stores_performance` extrait une synthèse des ventes par POS historisée
    - `mart_stores_performance_last_month` extrait une synthèse des ventes par POS pour le dernier mois échu
    - `mart_staff_performance_last_month` extrait la tableau des “employés du mois” pour le dernier mois échu
    - Ces 2 derniers modèles exploitent une macro `get_last_month()` afin d’identifier de manière modulaire le dernier mois échu
    - `mart_inventory` apporte une information sur la date estimée de rupture de stocks par produit et POS pour optimiser les commandes fournisseurs
    - `mart_customers` apporte une meilleure connaissance des clients, notamment au travers de leur statut (active, sleeping, inactive)
    - **Choix de matérialisation** : tables, pour accélérer l’affichage en dashboard
    - **Documentation** : complète et détaillée

**Gestion de la documentation**
    - Les éléments de description des sources, modèles & macros, et columns sont centralisés dans 3 fichiers Markdown du répertoire `docs/` :
        - `sources_descriptions.md`
        - `models_descriptions.md`
        - `columns_descriptions.md`
    - Ces fichiers sont organisés logiquement de manière à faciliter au maximum la gestion de la documentation


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
