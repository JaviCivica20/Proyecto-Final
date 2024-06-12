with src_customer as (
    select * from {{ source('dbt_proyecto_final', 'customer') }}
),

renamed_casted as (
    select
        customer_id,
        first_name,
        last_name,
        email,
        address_id,
        active,
        create_date,
        last_update
    from src_customer
)

select * from renamed_casted
