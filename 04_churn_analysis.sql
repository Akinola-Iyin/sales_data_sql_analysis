-- Churn Analysis
-- This query was used to segment customers as 'Active' or 'Churned' based on the time since their last purchase

WITH most_recent_order AS (
  SELECT MAX(order_date) AS recent_order_date FROM sales_data
),
recency AS (
  SELECT
    customer_id,
    MAX(order_date) AS last_order
  FROM sales_data
  GROUP BY customer_id
)
SELECT
  r.customer_id,
  r.last_order,
  CASE
    WHEN TIMESTAMPDIFF(MONTH, r.last_order, m.recent_order_date) > 3 THEN 'Churned'
    ELSE 'Active'
  END AS status
FROM recency r
CROSS JOIN most_recent_order m;
