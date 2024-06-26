with src_address as (
    select * from {{ source('dbt_proyecto_final', 'address') }}
),

renamed_casted as (
    select
        address_id::number(10) as address_id,
        address::varchar(100) as address,
        city_id::number(10) as city_id,
        IFF(postal_code = '', NULL, postal_code::number(10)) as postal_code,
        _fivetran_synced as date_load
    from src_address
)

select * from renamed_casted
