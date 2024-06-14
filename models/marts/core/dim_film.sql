with stg_film as (
    select *
    from {{ref('stg_dbt_proyecto_final__film')}}
),

stg_language as (
    select * 
    from {{ref('stg_dbt_proyecto_final__language')}}
),

stg_film_category as (
    select 
        fc.film_id,
        fc.category_id,
        c.name
    from {{ref('stg_dbt_proyecto_final__film_category')}} fc 
    join {{ref('stg_dbt_proyecto_final__category')}} c
    on fc.category_id = c.category_id
),

final as (
    select 
        f.film_id,
        f.title,
        f.description,
        f.length_minutes,
        f.release_year,
        l.language,
        f.max_rental_days,
        f.rental_rate_price,
        f.replacement_cost,
        f.age_rating,
        f.special_features,
        fc.name as category,
        f._fivetran_synced
    from stg_film_category fc 
    join stg_film f on f.film_id = fc.film_id
    join stg_language l on f.language_id = l.language_id
)

select * from final 