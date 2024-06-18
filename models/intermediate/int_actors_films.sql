with stg_actor as (
    select *
    from {{ref('stg_dbt_proyecto_final__actor')}}
),

stg_film_actor as (
    select *
    from {{ref('stg_dbt_proyecto_final__film_actor')}}
),

stg_film as (
    select 
        f.film_id,
        f.title,
        f.description,
        f.release_year,
        f.language_id,
        f.max_rental_days,
        f.rental_rate_price,
        f.length_minutes,
        f.replacement_cost,
        f.age_rating,
        f.trailers,
        f.commentaries,
        f.behind_the_scenes,
        f.deleted_scenes,
        c.name as category,
        f.date_load
    from {{ref('stg_dbt_proyecto_final__film')}} f
    full join {{ref('stg_dbt_proyecto_final__film_category')}} fc on f.film_id = fc.film_id
    full join {{ref('stg_dbt_proyecto_final__category')}} c on fc.category_id = c.category_id
),

stg_language as (
    select
        f.film_id,
        f.language_id,
        l.language
    from {{ref('stg_dbt_proyecto_final__film')}} f
    full join {{ref('stg_dbt_proyecto_final__language')}} l on f.language_id = l.language_id
),

final as (
    select
        f.film_id,
        f.title,
        f.category,
        f.description,
        f.release_year,
        l.language as original_language,
        f.max_rental_days,
        f.rental_rate_price,
        f.length_minutes,
        f.replacement_cost,
        f.age_rating,
        f.trailers,
        f.commentaries,
        f.behind_the_scenes,
        f.deleted_scenes,
        a.actor_id,
        concat(a.first_name,' ',a.last_name) as actor_full_name,
        a.first_name as actor_first_name,
        a.last_name as actor_last_name,
        f.date_load
    from stg_actor a 
    full join stg_film_actor fa on a.actor_id = fa.actor_id
    full join stg_film f on f.film_id = fa.film_id
    full join stg_language l on f.film_id = l.film_id
    order by 1
)

select * from final