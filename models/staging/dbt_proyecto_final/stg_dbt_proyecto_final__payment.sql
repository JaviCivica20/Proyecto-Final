with src_payment as (
    select * from {{ source('dbt_proyecto_final', 'payment') }}
),

renamed_casted as (
    select
        payment_id,
        customer_id,
        staff_id,
        rental_id,
        amount,
        payment_date,
        last_update
    from src_payment
)

select * from renamed_casted
