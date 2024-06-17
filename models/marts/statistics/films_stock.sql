with stg_purchase as (
    select
        store_id,
        film_id,
        count(film_id) as film_stock 
    from {{ref('stg_dbt_proyecto_final__purchases')}}
    group by 1, 2
    order by 1, 2
),

int_actors_films as (
    select
        film_id,
        title,
        release_year,
        original_language
    from {{ref('int_actors_films')}}
),

final as (
    select distinct
        p.store_id,
        p.film_id,
        af.title,
        af.release_year,
        af.original_language,
        p.film_stock

    from stg_purchase p
    join int_actors_films af 
    on p.film_id = af.film_id
)

select * from final order by store_id, film_id