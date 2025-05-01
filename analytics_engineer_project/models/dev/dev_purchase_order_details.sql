WITH source AS (

    SELECT * FROM {{ source('northwind', 'purchase_order_details') }}
)

SELECT
    *,
    DATETIME(CURRENT_TIMESTAMP(), 'Asia/Bangkok') AS ingestion_timestamp
FROM   
    source