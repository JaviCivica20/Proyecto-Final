with stg_purchase as (
    select
        store_id,
        film_id,
        sum(quantity) as film_stock
    from {{ref('fct_purchases')}}
    group by 1, 2
    order by 1, 2
),

int_actors_films as (
    select
        film_id,
        title
    from {{ref('int_actors_films')}}
),

final as (
    select distinct
        p.store_id,
        p.film_id,
        af.title,
        p.film_stock

    from stg_purchase p
    join int_actors_films af 
    on p.film_id = af.film_id
)

select * from final order by store_id, film_id