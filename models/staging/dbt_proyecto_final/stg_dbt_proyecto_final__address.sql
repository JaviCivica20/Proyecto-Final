with base_address as (
    select *
    from {{ref('base_dbt_proyecto_final__address')}}
),

base_city as (
    select *
    from {{ref('base_dbt_proyecto_final__city')}}
),

base_country as (
    select *
    from {{ref('base_dbt_proyecto_final__country')}}
),

combined as (
    select 
        a.address_id,
        a.address,
        ci.city,
        co.country,
        case 
            when postal_code IS NULL and city = 'Woodridge' then  4114
            when postal_code IS NULL and city = 'Lethbridge' then 403
        else postal_code
        end as postal_code,
        a.date_load
    from base_address a
    join base_city ci on a.city_id = ci.city_id
    join base_country co on ci.country_id = co.country_id 
)

select * from combined