{{
  config(
    materialized='incremental',
    unique_key='rental_id',
  )
}}

with rentals as (
        select
            r.rental_id,
            r.customer_id,
            c.store_id,
            r.film_id,
            rental_staff_id,
            r.rental_date,
            r.rental_time,
            r.target_return_date,
            {{add_returned_column('payment_date')}}, ---- Llama a una macro que devuelve true o false según una película haya sido devuelta o no
            p.payment_id,
            payment_staff_id,
            p.payment_date,

            case when datediff(day, rental_date, payment_date) < 1 then rental_rate_price ----- Cambiamos las cantidades de pago en relación a los días de alquiler por el precio diario
            else datediff(day, rental_date, payment_date) * rental_rate_price 
            end as correct_amount,

            {{ calculate_return_delay_days('returned', 'target_return_date', 'payment_date') }} as return_delay_days, ---- Llama a una macro que calcula el retraso que ha habido al devolver una película
            greatest(r.date_load, coalesce(p.date_load, '1970-01-01')) as date_load ---- Gestiona los date_load que vienen desde las 2 fuentes para asegurarse de que siempre se inserta el más reciente 
        
        from {{ ref('stg_dbt_proyecto_final__customer')}} c 
        join {{ ref('stg_dbt_proyecto_final__payment') }} p
        on c.customer_id = p.customer_id
        right join {{ ref('stg_dbt_proyecto_final__rental') }} r 
        on r.rental_id = p.rental_id
        join {{ref('stg_dbt_proyecto_final__film')}} f on r.film_id = f.film_id

    {% if is_incremental() %}

	    where greatest(r.date_load, coalesce(p.date_load, '1970-01-01')) > (select max(date_load) from {{ this }})

    {% endif %}
    
    )

    select * from rentals order by rental_id desc

