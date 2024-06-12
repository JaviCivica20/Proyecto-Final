with src_actor as (
    select * from {{source('dbt_proyecto_final', 'actor')}}
),

renamed_casted as (
    select
        actor_id,
        first_name,
        last_name,
        last_update
    from src_actor
)

select * from renamed_casted