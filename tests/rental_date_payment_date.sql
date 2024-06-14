-- Comprueba que la fecha de devolución de una película no sea anterior a la de su pago (porque se paga cuando se devuelve)

SELECT *
FROM {{ ref('stg_dbt_proyecto_final__rental') }}
WHERE  rental_date > payment_date