WITH source AS (
  SELECT
        id AS customer_id
      , company
      , last_name
      , first_name
      , email_address
      , job_title
      , business_phone
      , home_phone
      , mobile_phone
      , fax_number
      , address
      , city
      , state_province
      , zip_postal_code
      , country_region
      , web_page
      , notes
      , attachments
      , DATETIME(CURRENT_TIMESTAMP(), 'Asia/Bangkok') AS ingestion_timestamp 

  FROM
      {{ ref('dev_customer') }}

)
, unique_source AS (
    SELECT
       *,
       ROW_NUMBER() OVER (PARTITION BY customer_id) AS row_nums
       
    FROM
      source
)

SELECT
  * EXCEPT (row_nums)

FROM
  unique_source

WHERE
  row_nums = 1