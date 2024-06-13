with src_store as (
    select * from {{ source('dbt_proyecto_final', 'store') }}
),

renamed_casted as (
    select
        store_id::number(10) as store_id,
        manager_staff_id::number(10) as manager_staff_id,
        address_id::number(10) as address_id,
        DATE(last_update) as last_update_date,
        TIME(last_update) as last_update_time
    from src_store
)

select * from renamed_casted
