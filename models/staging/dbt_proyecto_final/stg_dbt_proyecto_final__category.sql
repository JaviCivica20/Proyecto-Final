with src_category as (
    select * from {{ source('dbt_proyecto_final', 'category') }}
),

renamed_casted as (
    select
        category_id,
        name,
        last_update
    from src_category
)

select * from renamed_casted
