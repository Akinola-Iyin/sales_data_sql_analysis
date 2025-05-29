-- RFM Analysis: Recency Calculation
-- In this query, I calculated how recently each customer made a purchase relative to the most recent order in the dataset.
WITH most_recent_order AS (
  SELECT MAX(order_date) AS recent_order_date FROM sales_data
),
recency AS (
  SELECT
    customer_id,
    MAX(order_date) AS last_order,
    (SELECT recent_order_date FROM most_recent_order) AS recent_order_date
  FROM sales_data
  GROUP BY customer_id
),
recency_final AS (
  SELECT
    customer_id,
    last_order,
    TIMESTAMPDIFF(DAY, last_order, recent_order_date) AS recency
  FROM recency
)
SELECT * FROM recency_final;


-- RFM Analysis: Frequency Calculation
-- Counts the number of unique orders made by each customer
SELECT
  customer_id,
  COUNT(order_id) AS frequency
FROM sales_data
GROUP BY customer_id;


-- RFM Analysis: Monetary Calculation
-- Sums total amount spent by each customer
SELECT
  customer_id,
  SUM(sales_amount) AS monetary
FROM sales_data
GROUP BY customer_id;


-- RFM Segmentation
-- Combines recency, frequency, and monetary into quartiles using NTILE for scoring
WITH
recency_ranked AS (
  SELECT
    customer_id,
    TIMESTAMPDIFF(DAY, MAX(order_date), (SELECT MAX(order_date) FROM sales_data)) AS recency
  FROM sales_data
  GROUP BY customer_id
),
frequency_ranked AS (
  SELECT
    customer_id,
    COUNT(order_id) AS frequency
  FROM sales_data
  GROUP BY customer_id
),
monetary_ranked AS (
  SELECT
    customer_id,
    SUM(sales_amount) AS monetary
  FROM sales_data
  GROUP BY customer_id
),
combined AS (
  SELECT
    r.customer_id,
    r.recency,
    f.frequency,
    m.monetary,
    NTILE(4) OVER (ORDER BY r.recency DESC) AS recency_score,
    NTILE(4) OVER (ORDER BY f.frequency) AS frequency_score,
    NTILE(4) OVER (ORDER BY m.monetary) AS monetary_score
  FROM recency_ranked r
  JOIN frequency_ranked f ON r.customer_id = f.customer_id
  JOIN monetary_ranked m ON r.customer_id = m.customer_id
)
SELECT
  customer_id,
  recency,
  frequency,
  monetary,
  recency_score,
  frequency_score,
  monetary_score,
  CONCAT(recency_score, frequency_score, monetary_score) AS rfm_segment
FROM combined
ORDER BY rfm_segment;

