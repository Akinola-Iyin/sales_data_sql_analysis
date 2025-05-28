-- Cohort Analysis: The task was to assign cohort month to Each Customer
-- Find the first month each customer made a purchase
WITH cohort AS ( 
  SELECT 
    customer_id,
    MIN(order_date) AS cohort_date
  FROM sales_data
  GROUP BY customer_id
),

-- Append Cohort Month to Each Order
full_details AS (
  SELECT
    sd.customer_id,
    sd.order_id,
    sd.order_date,
    c.cohort_date
  FROM sales_data sd
  JOIN cohort c ON sd.customer_id = c.customer_id
),

-- Calculate Months Since First Purchase
joined_details AS (
  SELECT
    customer_id,
    order_id,
    order_date,
    cohort_date,
    TIMESTAMPDIFF(MONTH, cohort_date, order_date) AS months_since_first_purchase
  FROM full_details
)
-- Cohort Table: Group by Cohort Month and Age
SELECT
  DATE_FORMAT(cohort_date, '%Y-%m') AS cohort_month,
  months_since_first_purchase,
  COUNT(DISTINCT customer_id) AS no_of_customers
FROM joined_details
GROUP BY
  cohort_month,
  months_since_first_purchase
ORDER BY
  cohort_month,
  months_since_first_purchase;

