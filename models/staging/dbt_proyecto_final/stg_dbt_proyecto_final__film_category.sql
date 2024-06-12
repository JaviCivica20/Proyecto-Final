with src_film_category as (
    select * from {{ source('dbt_proyecto_final', 'film_category') }}
),

renamed_casted as (
    select
        film_id,
        category_id,
        last_update
    from src_film_category
)

select * from renamed_casted
