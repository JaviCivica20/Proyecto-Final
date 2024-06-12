with src_address as (
    select * from {{ source('dbt_proyecto_final', 'address') }}
),

renamed_casted as (
    select
        address_id,
        address,
        country,
        city,
        postal_code,
        phone,
        last_update
    from src_address
)

select * from renamed_casted
