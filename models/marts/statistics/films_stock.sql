with int_film_stock as (
    select *
    from {{ref('int_film_stock')}}
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
        fs.store_id,
        fs.film_id,
        af.title,
        af.release_year,
        af.original_language,
        fs.film_stock

    from int_film_stock fs
    join int_actors_films af 
    on fs.film_id = af.film_id
)

select * from final order by store_id, film_id