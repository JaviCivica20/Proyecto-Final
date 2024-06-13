with stg_address as (
    select *
    from {{ref('stg_dbt_proyecto_final__address')}}
)

select * from stg_address