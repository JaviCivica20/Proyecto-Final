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

dbt run -f -s stg_dbt_proyecto_final__rental int_rental_payment_combined

dbt run -f -s stg_dbt_proyecto_final__payment int_rental_payment_combined


![IDE _ dbt Cloud - Google Chrome 19_06_2024 16_08_20](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/7ef3e64d-3a44-43d8-9461-7d91b455b38e)

![Captura de pantalla 2024-06-19 023710](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/d3176289-1af1-4184-87f8-c116e6f9c382)






