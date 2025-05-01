{{ config   
    (
        partition_by = {
            "field": "creation_date",
            "data_type": "date"
        }
    ) 
}}

WITH source AS (
    SELECT
          c.id AS customer_id
        , e.id AS employee_id
        , pod.purchase_order_id
        , pod.product_id
        , pod.quantity
        , pod.unit_cost
        , pod.date_received
        , pod.posted_to_inventory
        , pod.inventory_id
        , po.supplier_id
        , po.created_by
        , po.submitted_date
        , DATE(po.creation_date) AS creation_date
        , po.status_id
        , po.expected_date
        , po.shipping_fee
        , po.taxes
        , po.payment_date
        , po.payment_amount
        , po.payment_method
        , po.notes
        , po.approved_by
        , po.approved_date
        , po.submitted_by
        , DATETIME(CURRENT_TIMESTAMP(), 'Asia/Bangkok') AS ingestion_timestamp 

    FROM
        {{ ref('dev_purchase_orders') }}         AS po
    LEFT JOIN
        {{ ref('dev_purchase_order_details') }}  AS pod
    ON pod.purchase_order_id = po.id
    LEFT JOIN
        {{ ref('dev_products') }}                AS p
    ON p.id = pod.product_id
    LEFT JOIN
        {{ ref('dev_order_details') }}           AS od
    ON od.product_id = p.id
    LEFT JOIN
        {{ ref('dev_orders') }}                  AS o
    ON o.id = od.order_id
    LEFT JOIN
        {{ ref('dev_employees') }}               AS e
    ON e.id = po.created_by
    LEFT JOIN
        {{ ref('dev_customer') }}                AS c
    ON c.id = o.customer_id

    WHERE
        o.customer_id IS NOT NULL

)
, unique_source AS (
    SELECT
        *,
        ROW_NUMBER() OVER(PARTITION BY customer_id, employee_id, purchase_order_id, product_id, inventory_id, supplier_id, creation_date) AS row_nums
    
    FROM
        source
)

SELECT
    * EXCEPT(row_nums)

FROM
    unique_source

WHERE
    row_nums = 1