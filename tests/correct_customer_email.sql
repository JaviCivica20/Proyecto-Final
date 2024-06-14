-- Comprueba que el email tiene el formato correcto

SELECT email 
FROM {{ ref('stg_dbt_proyecto_final__customer') }}
WHERE email NOT LIKE '%@%.%'
