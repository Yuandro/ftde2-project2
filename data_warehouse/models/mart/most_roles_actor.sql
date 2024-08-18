{{ config(
    materialized="table",
    schema="mart"
) }}

SELECT
    CONCAT(da.first_name, ' ', da.last_name) AS actor_name,
    COUNT(df.title) AS role_amount
FROM 
    {{ ref('dim_actor') }} AS da
JOIN 
    {{ ref('dim_film_actor') }} AS dfa 
    ON da.actor_id = dfa.actor_id
JOIN 
    {{ ref('dim_film') }} AS df 
    ON df.film_id = dfa.film_id
GROUP BY 
    actor_name
ORDER BY 
    role_amount DESC