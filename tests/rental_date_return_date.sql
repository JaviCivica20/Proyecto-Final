-- Comprueba que la fecha de devolución de una película no sea anterior a la de su alquiler

SELECT *
FROM {{ ref('stg_dbt_proyecto_final__rental') }}
LEFT JOIN {{ ref('stg_dbt_proyecto_final__payment') }}
USING(rental_id)
WHERE  rental_date > target_return_date