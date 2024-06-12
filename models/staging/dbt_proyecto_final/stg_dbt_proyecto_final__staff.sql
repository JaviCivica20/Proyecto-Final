with src_staff as (
    select * from {{ source('dbt_proyecto_final', 'staff') }}
),

renamed_casted as (
    select
        staff_id,
        first_name,
        last_name,
        address_id,
        email,
        active,
        username,
        password,
        last_update
    from src_staff
)

select * from renamed_casted
