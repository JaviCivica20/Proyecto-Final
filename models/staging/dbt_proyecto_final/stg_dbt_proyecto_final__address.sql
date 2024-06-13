with src_address as (
    select * from {{ source('dbt_proyecto_final', 'address') }}
),

renamed_casted as (
    select
        address_id::number(10) as address_id,
        address::varchar(100) as address,
        country::varchar(50) as country,
        city::varchar(50) as city,
        IFF(postal_code = '', NULL, postal_code::number(10)) as postal_code,
        last_update
    from src_address
)

select * from renamed_casted
