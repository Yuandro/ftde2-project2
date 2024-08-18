{{ config(
    materialized="table",
    schema="mart"
) }}

SELECT
    f.title,
    COUNT(fp.payment_id) AS rental_amount
FROM 
    {{ ref('dim_film') }} AS f
JOIN 
    {{ ref('dim_inventory') }} AS i 
    ON f.film_id = i.film_id
JOIN 
    {{ ref('dim_rental') }} AS r 
    ON r.inventory_id = i.inventory_id
JOIN 
    {{ ref('fact_payment') }} AS fp 
    ON fp.rental_id = r.rental_id
GROUP BY 
    f.title
ORDER BY 
    rental_amount DESC
