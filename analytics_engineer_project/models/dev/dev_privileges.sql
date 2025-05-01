WITH source AS (

    SELECT * FROM {{ source('northwind', 'privileges') }}
)

SELECT
    *,
    DATETIME(CURRENT_TIMESTAMP(), 'Asia/Bangkok') AS ingestion_timestamp
FROM   
    source