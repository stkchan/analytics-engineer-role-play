WITH change_type_product AS (
  SELECT
      * EXCEPT (supplier_ids),
      CAST(supplier_ids AS INTEGER) AS supplier_ids
  
  FROM
    {{ ref('dev_products') }}
  
  WHERE
    supplier_ids NOT LIKE "%;%" 
)

, source AS (
    SELECT
          p.id AS product_id
        , p.product_code
        , p.product_name
        , p.description
        , s.company AS supplier_company
        , p.standard_cost
        , p.list_price
        , p.reorder_level
        , p.target_level
        , p.quantity_per_unit
        , p.discontinued
        , p.minimum_reorder_quantity
        , p.category
        , p.attachments
        , DATETIME(CURRENT_TIMESTAMP(), 'Asia/Bangkok') AS ingestion_timestamp

    FROM
      change_type_product         AS p
    LEFT JOIN
      {{ ref('dev_suppliers') }}  AS s
    ON s.id = p.supplier_ids

)
, unique_source AS (
    SELECT
       *,
       ROW_NUMBER() OVER (PARTITION BY product_id) AS row_nums
       
    FROM
      source
)

SELECT
  * EXCEPT (row_nums)

FROM
  unique_source

WHERE
  row_nums = 1