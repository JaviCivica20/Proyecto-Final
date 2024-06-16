SELECT *
FROM {{ ref('int_returned_and_delays') }}
WHERE  returned = false and payment_date IS NOT NULL