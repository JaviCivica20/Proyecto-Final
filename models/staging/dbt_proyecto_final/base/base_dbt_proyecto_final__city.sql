with src_city as (

    select * from {{ source('dbt_proyecto_final', 'city') }}

),

casted_renamed as (

    select
        city_id::number(10) as city_id,
        city::varchar(50) as city,
        country_id::number(10) as country_id,
        _fivetran_synced as date_load
    from src_city

)

select * from casted_renamed
