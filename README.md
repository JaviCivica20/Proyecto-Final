# Proyecto Final
Proyecto final del curso de Data Engineering de Cívica

<h3>MODELO ENTIDAD-RELACIÓN INICIAL</h3>

![diagramainicial](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/4d25ca8f-80f5-40e4-8e1a-f1731ed97336)


- Decisión de address
- Decisión de unión tabla de hechos
- Decisión de actores


BASE_PAYMENT

STG_FILM y la macro de special_features

SGT_RENTAL_COMBINED y las 2 macros

STG_CUSTOMER y los DATE/TIME

STG_ADDRESS y los nulos

FCT_RENTALS_RETURNS

FCT_PURCHASES

DIM_TIME Y DIM_DATE

DIM_STORE

DIM_FILM y el Intermediate

DOCS, documentación y tests





INCREMENTAL

dbt run --full-refresh --select fct_rentals_returns

dbt run --models base_dbt_proyecto_final__rental stg_rental_payment_combined

dbt run --models base_dbt_proyecto_final__payment stg_rental_payment_combined
