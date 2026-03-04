
  {{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}


SELECT
c.first_name as customer_first_name,
c.last_name as customer_last_name,
d.date_day,
s.store_name,
e.first_name as employee_first_name,
e.last_name as employee_last_name,
f.quantity,
f.unit_price,
f.dollars_sold,
FROM {{ ref('fact_sales') }} f

LEFT JOIN {{ ref('oliver_dim_customer') }} c
    ON f.customer_key = c.customer_key

LEFT JOIN {{ ref('oliver_dim_employee') }} e
    ON f.employee_key = e.employee_key

LEFT JOIN {{ ref('oliver_dim_store') }} s
    ON f.store_key = s.store_key

LEFT JOIN {{ ref('oliver_dim_date') }} d
    ON f.date_key = d.date_key
