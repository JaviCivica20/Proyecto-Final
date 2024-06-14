with
    fct_rental as (
        select * 
        from {{ ref("fct_rental") }}),

    int_actors_films as (
        select *
        from {{ ref("int_actors_films") }}
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
            SUM(CASE WHEN returned = false THEN 1 ELSE 0 END) as total_delays,
            max(rental_date) as last_time_rented,
            max(payment_date) as last_payment
        from fct_rental
        group by customer_id
    )

    select 
        ra.customer_id, 
        ra.actor_full_name as favourite_actor, 
        ra.movie_apperances, 
        tf.total_films_rented,
        tf.total_spent,
        tf.total_delays,
        tf.last_time_rented,
        tf.last_payment
    from ranked_actors ra
    join total_films tf on ra.customer_id = tf.customer_id
    where ra.rank = 1
    order by 1

