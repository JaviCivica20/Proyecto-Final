# Proyecto Final
Proyecto final del curso de Data Engineering de Cívica

<h3>MODELO ENTIDAD-RELACIÓN INICIAL</h3>

![diagramainicial](https://github.com/JaviCivica20/Proyecto-Final/assets/170645442/4d25ca8f-80f5-40e4-8e1a-f1731ed97336)



dbt run --models base_dbt_proyecto_final__rental stg_rental_payment_combined

dbt run --models base_dbt_proyecto_final__payment stg_rental_payment_combined
