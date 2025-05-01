{{ config   
    (
        partition_by = {
            "field": "transaction_created_date",
            "data_type": "date"
        }
    ) 
}}

WITH source AS (
    SELECT
          id AS inventory_id
        , transaction_type
        , DATE(transaction_created_date) AS transaction_created_date
        , transaction_modified_date
        , product_id
        , quantity
        , purchase_order_id
        , customer_order_id
        , comments
        , DATETIME(CURRENT_TIMESTAMP(), 'Asia/Bangkok') AS ingestion_timestamp 

    FROM
        {{ ref('dev_inventory_transactions') }} 
)
, unique_source AS (
    SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY inventory_id) AS row_nums
    
    FROM
        source
)

SELECT
    * EXCEPT(row_nums)

FROM
    unique_source

WHERE
    row_nums = 1