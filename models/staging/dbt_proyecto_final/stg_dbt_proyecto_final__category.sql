with src_category as (
    select * from {{ source('dbt_proyecto_final', 'category') }}
),

renamed_casted as (
    select
        category_id::number(10) as category_id,
        name::varchar(50) as name,
        _fivetran_synced as data_load
    from src_category
)

select * from renamed_casted
