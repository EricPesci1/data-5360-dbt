{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    cu.customer_key,
    s.store_key,
    d.date_key,
    p.product_key,
    e.employee_key,
    ol.quantity,
    ol.unit_price,
    ol.unit_price * ol.quantity AS dollars_sold
FROM {{ source('oliver_landing', 'orders') }} o
INNER JOIN {{ source('oliver_landing', 'orderline') }} ol ON o.Order_ID = ol.Order_ID
INNER JOIN {{ ref('oliver_dim_product') }} p ON p.Product_ID = ol.product_id 
INNER JOIN {{ ref('oliver_dim_customer') }} cu ON cu.Customer_ID = o.customer_id 
INNER JOIN {{ ref('oliver_dim_employee') }} e ON e.Employee_ID = o.employee_id
INNER JOIN {{ ref('oliver_dim_store') }} s ON s.Store_ID = o.store_id
INNER JOIN {{ ref('oliver_dim_date') }} d ON d.date_day = o.Order_Date
