WITH source AS (

    SELECT * FROM {{ source('northwind', 'employee_privileges') }}
)

SELECT
    *,
    DATETIME(CURRENT_TIMESTAMP(), 'Asia/Bangkok') AS ingestion_timestamp
FROM   
    source
