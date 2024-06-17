with src_film_actor as (
    select * from {{ source('dbt_proyecto_final', 'film_actor') }}
),

renamed_casted as (
    select
        actor_id::number(10) as actor_id,
        film_id::number(10) as film_id,
        _fivetran_synced as date_load
    from src_film_actor
)

select * from renamed_casted
