with src_film_actor as (
    select * from {{ source('dbt_proyecto_final', 'film_actor') }}
),

renamed_casted as (
    select
        actor_id,
        film_id,
        last_update
    from src_film_actor
)

select * from renamed_casted
