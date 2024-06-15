{{ config(
    materialized='incremental',
    unique_key='rental_id',
    incremental_strategy='merge'
) }}

WITH new_rental_data AS (
    SELECT
        rental_id,
        rental_date,
        rental_time,
        customer_id,
        film_id,
        return_date,
        staff_id,
        _fivetran_synced AS rental_synced_at
    FROM {{ ref('base_dbt_proyecto_final__rental') }}
    {% if is_incremental() %}
    WHERE _fivetran_synced > (SELECT MAX(rental_synced_at) FROM {{ this }})
    {% endif %}
),

new_payment_data AS (
    SELECT
        payment_id,
        rental_id,
        customer_id,
        staff_id,
        amount,
        payment_date,
        _fivetran_synced AS payment_synced_at     
    FROM {{ ref('base_dbt_proyecto_final__payment') }}
    {% if is_incremental() %}
    WHERE _fivetran_synced > (SELECT MAX(payment_synced_at) FROM {{ this }})
    {% endif %}
),

combined_data AS (
    SELECT
        r.rental_id,
        r.rental_date,
        r.rental_time,
        r.staff_id a as rental_staff_id,
        r.customer_id,
        r.film_id,
        r.return_date as target_return_date,
        p.staff_id as payment_staff_id,
        p.payment_date,
        p.amount,
        GREATEST(r.rental_synced_at, p.payment_synced_at) AS last_synced_at,
        r.rental_synced_at,
        p.payment_synced_at
    FROM new_rental_data r
    LEFT JOIN new_payment_data p
    ON r.rental_id = p.rental_id
    
)

SELECT * FROM combined_data
