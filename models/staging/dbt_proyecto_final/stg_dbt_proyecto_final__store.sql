with src_store as (
    select * from {{ source('dbt_proyecto_final', 'store') }}
),

renamed_casted as (
    select
        store_id,
        manager_staff_id,
        address_id,
        last_update
    from src_store
)

select * from renamed_casted
