WITH source AS (

    SELECT * FROM {{ source('northwind', 'purchase_orders') }}
)

SELECT
    *,
    DATETIME(CURRENT_TIMESTAMP(), 'Asia/Bangkok') AS ingestion_timestamp
FROM   
    source