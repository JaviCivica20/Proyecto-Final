-- Comprueba que las cantidades cobradas son las correctas

SELECT 
    amount,
    rental_rate_price,
    rental_date,
    payment_date,
    case when datediff(day, rental_date, payment_date) < 1 then rental_rate_price
    else datediff(day, rental_date, payment_date) * rental_rate_price 
    end as correct_amount
FROM {{ ref('base_dbt_proyecto_final__payment') }} p
JOIN {{ ref('base_dbt_proyecto_final__rental') }} r using(rental_id)
JOIN {{ ref('stg_dbt_proyecto_final__film')}} f USING(film_id)
WHERE  amount != correct_amount