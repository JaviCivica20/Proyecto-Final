-- Comprueba que la fecha de devolución de una película no sea anterior a la de su fecha de devolución máxima

SELECT *
FROM {{ ref('base_dbt_proyecto_final__rental') }}
LEFT JOIN {{ ref('base_dbt_proyecto_final__payment') }}
USING(rental_id)
WHERE  rental_date > target_return_date