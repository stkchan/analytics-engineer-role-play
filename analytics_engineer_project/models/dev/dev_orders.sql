WITH source AS (

    SELECT * FROM {{ source('northwind', 'orders') }}
)

SELECT
    *,
    DATETIME(CURRENT_TIMESTAMP(), 'Asia/Bangkok') AS ingestion_timestamp
FROM   
    source