-- Comprueba que la fecha de devolución de una película no sea anterior a la de su alquiler

SELECT *
FROM {{ ref('base_dbt_proyecto_final__rental') }}
WHERE  rental_date > return_date