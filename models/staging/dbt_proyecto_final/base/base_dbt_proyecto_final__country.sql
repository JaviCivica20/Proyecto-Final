with src_country as (

    select * from {{ source('dbt_proyecto_final', 'country') }}

),

casted_renamed as (

    select
        country_id::number(10) as country_id,
        country::varchar(50) as country,
        _fivetran_synced as date_load
    from src_country

)

select * from casted_renamed
