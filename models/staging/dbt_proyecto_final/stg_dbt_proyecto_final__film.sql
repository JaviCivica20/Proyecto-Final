with src_film as (
    select * from {{ source('dbt_proyecto_final', 'film') }}
),

renamed_casted as (
    select
        film_id,
        title,
        description,
        release_year,
        language_id,
        rental_duration,
        rental_rate,
        length,
        replacement_cost,
        rating,
        special_features,
        last_update
    from src_film
)

select * from renamed_casted
