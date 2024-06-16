with src_actor as (
    select * from {{source('dbt_proyecto_final', 'actor')}}
),

renamed_casted as (
    select
        actor_id::number(10) as actor_id,
        first_name::varchar(50) as first_name,
        last_name::varchar(50) as last_name,
        _fivetran_synced as data_load
    from src_actor
)

select * from renamed_casted