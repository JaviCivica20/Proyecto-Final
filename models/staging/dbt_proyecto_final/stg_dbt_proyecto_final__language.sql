with src_language as (
    select * from {{ source('dbt_proyecto_final', 'language') }}
),

renamed_casted as (
    select
        language_id::number(10) as language_id,
        name::varchar(50) as language,
        _fivetran_synced as data_load
    from src_language
)

select * from renamed_casted
