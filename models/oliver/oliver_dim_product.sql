{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}


select
product_id as product_key,
product_id,
unit_price,
description,
product_name,
FROM {{ source('oliver_landing', 'product') }}