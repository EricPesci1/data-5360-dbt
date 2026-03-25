{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
    )
}}

WITH customers AS (
    SELECT * FROM {{ source('ecoessentials_landing', 'customer') }}
),

marketing_emails AS (
    SELECT DISTINCT customerid
    FROM {{ source('ecoessentials_landing_emails', 'marketingemails') }}
)

select
{{ dbt_utils.generate_surrogate_key(['column1', 'column2']) }} as cust_key,
    c.*,
    CASE
        WHEN m.customerid IS NOT NULL THEN TRUE
        ELSE FALSE
    END AS is_subscriber
FROM customers c
LEFT JOIN marketing_emails m
    ON c.customerid = m.customerid