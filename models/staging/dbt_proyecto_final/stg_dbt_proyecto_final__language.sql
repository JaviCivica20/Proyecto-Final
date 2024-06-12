with src_language as (
    select * from {{ source('dbt_proyecto_final', 'language') }}
),

renamed_casted as (
    select
        language_id,
        name,
        last_update
    from src_language
)

select * from renamed_casted
