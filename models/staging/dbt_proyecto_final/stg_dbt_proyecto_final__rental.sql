with src_rental as (
    select * from {{ source('dbt_proyecto_final', 'rental') }}
),

renamed_casted as (
    select
        rental_id::number(10),
        DATE(rental_date) as rental_date,
        TIME(rental_date) as rental_time,
        customer_id::number(10) as customer_id,
        return_date,
        staff_id::number(10) as staff_id,
        DATE(last_update) as last_update_date,
        TIME(last_update) as last_update_time
    from src_rental
)

select * from renamed_casted
