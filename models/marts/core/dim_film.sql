with int_actors_films as (
    select distinct
        film_id,
        title,
        description,
        length_minutes,
        release_year,
        original_language,
        max_rental_days,
        rental_rate_price,
        replacement_cost,
        age_rating,
        trailers,
        commentaries,
        behind_the_scenes,
        deleted_scenes,
        category,
        coalesce(date_load, current_time) as date_load
    from {{ref('int_actors_films')}}
)


select * from int_actors_films where date_load is null