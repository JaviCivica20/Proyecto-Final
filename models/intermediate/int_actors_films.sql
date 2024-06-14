with stg_actor as (
    select *
    from {{ref('stg_dbt_proyecto_final__actor')}}
),

stg_film_actor as (
    select *
    from {{ref('stg_dbt_proyecto_final__film_actor')}}
),

stg_film as (
    select *
    from {{ref('stg_dbt_proyecto_final__film')}}
),

final as (
    select
        f.film_id,
        f.title,
        concat(a.first_name,' ',a.last_name) as full_name
        a.first_name,
        a.last_name,
    from stg_actor a 
    join stg_film_actor fa on a.actor_id = fa.actor_id
    join stg_film f on f.film_id = fa.film_id
    order by 1
)

select * from final