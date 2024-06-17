with src_store as (
    select * from {{ source('dbt_proyecto_final', 'store') }}
),

renamed_casted as (
    select
        store_id::number(10) as store_id,
        manager_staff_id::number(10) as manager_staff_id,
        address_id::number(10) as address_id,
        _fivetran_synced as date_load
    from src_store
)

select * from renamed_casted
