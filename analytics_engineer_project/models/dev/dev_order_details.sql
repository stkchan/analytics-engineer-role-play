WITH source AS (

    SELECT * FROM {{ source('northwind', 'order_details') }}
)

SELECT
    *,
    DATETIME(CURRENT_TIMESTAMP(), 'Asia/Bangkok') AS ingestion_timestamp
FROM   
    source