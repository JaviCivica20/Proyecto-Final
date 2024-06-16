/*{{
  config(
    materialized='incremental',
    unique_key='customer_id',
  )
}}*/

with fct_rental as (
        select * 
        from {{ ref("fct_rental") }}
    ),

    int_actors_films as (
        select *
        from {{ ref("int_actors_films") }}
    ),

    int_returned_and_delays as (
        select *
        from {{ ref("int_returned_and_delays")}}
    ),

    actor_counts as (
        select
            r.customer_id,
            f.actor_full_name,
            count(f.actor_full_name) as movie_apperances,
        from int_actors_films f
        join fct_rental r on f.film_id = r.film_id
        group by r.customer_id, f.actor_full_name
    ),

    ranked_actors as (
        select
            customer_id,
            actor_full_name,
            movie_apperances,
            row_number() over (partition by customer_id order by movie_apperances desc) as rank
        from actor_counts
    ),

    total_films as (
        select 
            customer_id, 
            count(film_id) as total_films_rented,
            sum(amount) as total_spent,
            sum(CASE WHEN returned = false THEN 1 ELSE 0 END) as total_delays,
            max(rental_date) as last_time_rented,
            max(payment_date) as last_payment
        from int_returned_and_delays
        group by customer_id
    ),

    category_counts as (
        select
            r.customer_id,
            f.category,
            count(f.category) AS count_category
        from int_actors_films f
        join int_returned_and_delays r on f.film_id = r.film_id
        group by r.customer_id, f.category
    ),

    ranked_categories as (
        select
            customer_id,
            category,
            count_category,
            row_number() over (partition by customer_id order by count_category desc) as rank
        from category_counts
    )

    select 
        ra.customer_id, 
        ra.actor_full_name as favourite_actor, 
        rc.category as favourite_category,
        tf.total_films_rented,
        tf.total_spent,
        tf.total_delays,
        tf.last_time_rented,
        tf.last_payment
    from ranked_actors ra
    join total_films tf on ra.customer_id = tf.customer_id
    join ranked_categories rc on tf.customer_id = rc.customer_id
    where ra.rank = 1 and rc.rank = 1
    order by 1

/*{% if is_incremental() %}

	where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}*/