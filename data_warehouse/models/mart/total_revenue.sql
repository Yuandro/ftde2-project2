{{ config(
    materialized="table",
    schema="mart"
) }}

SELECT
    sum(amount) AS total_revenue,
    TO_CHAR(DATE_TRUNC('month', payment_date), 'YYYY-MM') AS months
FROM
    {{ ref('fact_payment') }}
GROUP BY
    months
ORDER BY
    months