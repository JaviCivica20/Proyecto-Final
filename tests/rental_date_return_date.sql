SELECT *
FROM {{ ref('base_dbt_proyecto_final__rental') }}
WHERE  rental_date > return_date