with src_rental as (
    select * from {{ source('dbt_proyecto_final', 'rental') }}
),

renamed_casted as (
    select
        rental_id,
        rental_date,
        customer_id,
        return_date,
        staff_id,
        last_update
    from src_rental
)

select * from renamed_casted
