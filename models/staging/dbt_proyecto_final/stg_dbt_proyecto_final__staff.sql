with src_staff as (
    select * from {{ source('dbt_proyecto_final', 'staff') }}
),

renamed_casted as (
    select
        staff_id::number(10) as staff_id,
        first_name::varchar(50) as first_name,
        last_name::varchar(50) as last_name,
        address_id::number(10) as address_id,
        email::varchar(100) as email,
        store_id::number(10) as store_id,
        active::number(1) as active,
        username::varchar(50) as username,
        password::varchar(50) as password,
        DATE(last_update) as last_update_date,
        TIME(last_update) as last_update_time
    from src_staff
)

select * from renamed_casted
