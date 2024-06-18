-- Comprueba que el usuario que alquila la película y el que devuelve la película y realiza el pago son el mismo

SELECT 
    r.customer_id,
    p.customer_id
FROM {{ ref('base_dbt_proyecto_final__rental') }} r
LEFT JOIN {{ ref('base_dbt_proyecto_final__payment') }} p
USING(rental_id)
WHERE  r.customer_id != p.customer_id