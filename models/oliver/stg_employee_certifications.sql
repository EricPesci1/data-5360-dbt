{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

select
    certification_completion_ID as certification_ID,
    first_name,
    last_name,
    email,
    employee_ID,
    PARSE_JSON(certification_json)['certification_name']::VARCHAR        AS certification_name,
    PARSE_JSON(certification_json)['certification_cost']::INT            AS certification_cost,
    PARSE_JSON(certification_json)['certification_awarded_date']::DATE   AS certification_awarded_date
FROM {{ source('oliver_landing', 'employee_certifications') }}