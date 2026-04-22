-- Define sales funnel and extract raw counts for different user stages
SELECT 
  COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS views,
  COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS cart,
  COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS checkout,
  COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) AS payment,
  COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS purchase
FROM `project-a33c5b81-2d90-4055-94c.sql_practice.user_events`
WHERE event_date >= TIMESTAMP(DATE_SUB(CURRENT_DATE(), INTERVAL 100 DAY));