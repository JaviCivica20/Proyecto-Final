with src_customer as (
    select * from {{ source('dbt_proyecto_final', 'customer') }}
),

renamed_casted as (
    select
        customer_id::number(10) as customer_id,
        store_id::number(10) as store_id,
        first_name::varchar(50) as first_name,
        last_name::varchar(50) as last_name,
        email::varchar(100) as email,
        address_id::number(10) as address_id,
        active::number(1) as active,
        DATE(create_date::timestamp_ntz(9)) as create_date,
        TIME(create_date::timestamp_ntz(9)) as create_time,
        _fivetran_synced
    from src_customer
)

select * from renamed_casted
