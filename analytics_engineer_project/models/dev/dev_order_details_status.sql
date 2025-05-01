WITH source AS (

    SELECT * FROM {{ source('northwind', 'order_details_status') }}
)

SELECT
    *,
    DATETIME(CURRENT_TIMESTAMP(), 'Asia/Bangkok') AS ingestion_timestamp
FROM   
    source