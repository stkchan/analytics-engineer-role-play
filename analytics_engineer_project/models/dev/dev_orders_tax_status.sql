WITH source AS (

    SELECT * FROM {{ source('northwind', 'orders_tax_status') }}
)

SELECT
    *,
    DATETIME(CURRENT_TIMESTAMP(), 'Asia/Bangkok') AS ingestion_timestamp
FROM   
    source
