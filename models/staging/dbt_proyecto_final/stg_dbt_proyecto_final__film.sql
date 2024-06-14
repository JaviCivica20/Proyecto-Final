with src_film as (
    select * from {{ source('dbt_proyecto_final', 'film') }}
),

renamed_casted as (
    select
        film_id::number(10) as film_id,
        title::varchar(50) as title,
        description::varchar(250) as description,
        release_year::number(4) as release_year,
        language_id::number(10) as language_id,
        rental_duration::number(2) as max_rental_days,
        rental_rate::number(5,2) as rental_rate_price,
        length::number(3) as length_minutes,
        replacement_cost::number(5,2) as replacement_cost,
        rating::varchar(10) as age_rating,
        special_features::varchar(100) as special_features,
        _fivetran_synced
    from src_film
)

select * from renamed_casted



