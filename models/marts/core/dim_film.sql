with int_actors_films as (
    select *
    from {{ref('int_actors_films')}}
),

final as (
    Select distinct
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
        date_load
    from int_actors_films
)


select * from final