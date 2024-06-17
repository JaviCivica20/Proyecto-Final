

with rentals as (
        select
            r.rental_id,
            r.customer_id,
            r.film_id,
            rental_staff_id,
            r.rental_date,
            r.rental_time,
            r.target_return_date,
            {{add_returned_column('payment_date')}}, ---- Llama a una macro que devuelve true o false según una película haya sido devuelta o no
            p.payment_id,
            payment_staff_id,
            p.payment_date,
            p.amount,
            {{ calculate_return_delay_days('returned', 'target_return_date', 'payment_date') }} as return_delay_days, ---- Llama a una macro que calcula el retraso que ha habido al devolver una película

            greatest(r.date_load, coalesce(p.date_load, '1970-01-01')) as date_load ---- Gestiona los date_load que vienen desde las 2 fuentes para asegurarse de que siempre se inserta el más reciente 
            
        from {{ ref('base_dbt_proyecto_final__rental') }} r
        left join {{ ref('base_dbt_proyecto_final__payment') }} p
        on r.rental_id = p.rental_id

    
    )

    select * from rentals 

