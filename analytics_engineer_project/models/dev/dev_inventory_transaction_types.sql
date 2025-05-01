WITH source AS (

    SELECT * FROM {{ source('northwind', 'inventory_transaction_types') }}
)

SELECT
    *,
    DATETIME(CURRENT_TIMESTAMP(), 'Asia/Bangkok') AS ingestion_timestamp
FROM   
    source