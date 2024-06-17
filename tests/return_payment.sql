-- Comprueba que no haya fecha de pago con una película sin devolver

SELECT *
FROM {{ ref('stg_rental_payment_combined') }}
WHERE  returned = false and payment_date IS NOT NULL