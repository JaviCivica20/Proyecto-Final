with src_payment as (
    select * from {{ source('dbt_proyecto_final', 'payment') }}
),

renamed_casted as (
    select
        payment_id::number(10) as payment_id,
        customer_id::number(10) as customer_id,
        staff_id::number(10) as staff_id,
        rental_id::number(10) as rental_id,
        amount::number(10,2) as amount,
        payment_date,
        last_update
    from src_payment
)

select * from renamed_casted
