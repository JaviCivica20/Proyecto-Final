-- Comprueba que la fecha de alquiler de una película no sea anterior a la de su pago (porque se paga cuando se devuelve)

SELECT *
FROM {{ ref('base_dbt_proyecto_final__rental') }}
LEFT JOIN {{ ref('base_dbt_proyecto_final__payment') }}
USING(rental_id)
WHERE  rental_date > payment_date