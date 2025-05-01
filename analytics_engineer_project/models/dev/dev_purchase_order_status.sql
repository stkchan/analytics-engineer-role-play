WITH source AS (

    SELECT * FROM {{ source('northwind', 'purchase_order_status') }}
)

SELECT
    *,
    DATETIME(CURRENT_TIMESTAMP(), 'Asia/Bangkok') AS ingestion_timestamp
FROM   
    source