{{
  config(
    materialized='incremental',
    unique_key='rental_id',
  )
}}

with stg_payment as (
    select * from {{ ref('stg_dbt_proyecto_final__payment') }}
),

stg_rentals as (
    select * from {{ ref('stg_dbt_proyecto_final__rental') }}
),

stg_film as (
    select 
        film_id,
        rental_rate_price
    from {{ ref('stg_dbt_proyecto_final__film') }}
),

rentals as (
        select
            r.rental_id,
            r.customer_id,
            r.store_id,
            r.film_id,
            rental_staff_id,
            r.rental_date,
            r.rental_time,
            r.target_return_date,
            --- Llama a una macro que devuelve true o false según una película haya sido devuelta o no
            {{add_returned_column('payment_date')}}, 
            p.payment_id,
            payment_staff_id,
            p.payment_date,
            --- Cambiamos las cantidades de pago por las correctas  
            case when datediff(day, rental_date, payment_date) < 1 then rental_rate_price                                                                    
            else datediff(day, rental_date, payment_date) * rental_rate_price 
            end as correct_amount,
            --- Llama a una macro que calcula los días de retraso que ha habido al devolver una película
            {{ calculate_return_delay_days('returned', 'target_return_date', 'payment_date') }} as return_delay_days, 
            --- Gestiona los date_load que vienen desde las 2 fuentes para asegurarse de que siempre se inserta el más reciente                                                                        
            greatest(r.date_load, coalesce(p.date_load, '1970-01-01')) as date_load                                                                     
        from stg_payment p
        right join stg_rentals r 
        on r.rental_id = p.rental_id
        join stg_film f on r.film_id = f.film_id

    {% if is_incremental() %}

	    where greatest(r.date_load, coalesce(p.date_load, '1970-01-01')) > (select max(date_load) from {{ this }})

    {% endif %}
    
    )

    select * from rentals order by rental_id desc

