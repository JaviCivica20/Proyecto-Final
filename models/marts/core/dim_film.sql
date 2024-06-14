with int_actors_films as (
    select *
    from {{ref('int_actors_films')}}
),

final as (
    select distinct
        film_id,
        title,
        description,
        length_minutes,
        release_year,
        language,
        max_rental_days,
        rental_rate_price,
        replacement_cost,
        age_rating,
        special_features,
        category,
        _fivetran_synced
    from int_actors_films
)

select * from final 