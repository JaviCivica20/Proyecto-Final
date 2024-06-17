    with int_actors_films as (
        select *
        from {{ ref("int_actors_films") }}
    ),

    int_returned_and_delays as (
        select *
        from {{ ref("fct_rentals_returns")}}
    ),

    --- Se hace un count de los actores que ha visto un cliente
    actor_counts as (
        select
            r.customer_id,
            f.actor_full_name,
            count(f.actor_full_name) as movie_apperances,
        from int_actors_films f
        join int_returned_and_delays r on f.film_id = r.film_id
        group by r.customer_id, f.actor_full_name
    ),

    --- Se hace un rank de los actores
    ranked_actors as (
        select
            customer_id,
            actor_full_name,
            movie_apperances,
            row_number() over (partition by customer_id order by movie_apperances desc) as rank
        from actor_counts
    ),

    --- Se realizan diferentes funciones de agregación agrupadas por cliente
    total_films as (
        select 
            customer_id, 
            count(film_id) as total_films_rented,
            sum(amount) as total_spent,
            sum(CASE WHEN returned = false THEN 1 ELSE 0 END) as total_no_returns,
            max(rental_date) as last_time_rented,
            max(payment_date) as last_payment
        from int_returned_and_delays
        group by customer_id
    ),

    --- Se hace un count de las categorías vistas por el cliente
    category_counts as (
        select
            r.customer_id,
            f.category,
            count(f.category) AS count_category
        from int_actors_films f
        join int_returned_and_delays r on f.film_id = r.film_id
        group by r.customer_id, f.category
    ),

    --- Se hace un ranking de las categorías 
    ranked_categories as (
        select
            customer_id,
            category,
            count_category,
            row_number() over (partition by customer_id order by count_category desc) as rank
        from category_counts
    )

    --- Se unen los datos y con un 'where rank = 1' se consiguen el actor más visto y la categoría más vista por cada cliente 
    select 
        ra.customer_id, 
        ra.actor_full_name as most_viewed_actor, 
        rc.category as favourite_category,
        tf.total_films_rented,
        tf.total_spent,
        coalesce(tf.total_no_returns, 0) as total_no_returns,
        {{add_warning_column('tf.total_no_returns')}}, --- Llama a una macro que construye una columna y pone un aviso a los clientes que tienen más de 5 películas sin devolver
        tf.last_time_rented,
        tf.last_payment
    from ranked_actors ra
    join total_films tf on ra.customer_id = tf.customer_id
    join ranked_categories rc on tf.customer_id = rc.customer_id
    where ra.rank = 1 and rc.rank = 1
    order by 1
