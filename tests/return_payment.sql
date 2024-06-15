SELECT *
FROM {{ ref('stg_dbt_proyecto_final__rental') }}
WHERE  returned = false and payment_date IS NOT NULL