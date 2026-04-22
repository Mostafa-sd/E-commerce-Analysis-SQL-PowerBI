
-- 2- conversion rates through  the funnel
WITH funnel_stage AS (
  SELECT 
    COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS views,
    COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS cart,
    COUNT(DISTINCT CASE WHEN event_type = 'checkout_start' THEN user_id END) AS checkout,
    COUNT(DISTINCT CASE WHEN event_type = 'payment_info' THEN user_id END) AS payment,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS purchase
  FROM `project-a33c5b81-2d90-4055-94c.sql_practice.user_events`
  WHERE event_date >= TIMESTAMP(DATE_SUB(CURRENT_DATE(), INTERVAL 100 DAY))
)
SELECT
  views,
  cart,
  ROUND(SAFE_DIVIDE(cart * 100, views), 2) AS view_to_cart_rate,
  checkout,
  ROUND(SAFE_DIVIDE(checkout * 100, cart), 2) AS cart_to_checkout_rate,
  payment,
  ROUND(SAFE_DIVIDE(payment * 100, checkout), 2) AS checkout_to_payment_rate,
  purchase,
  ROUND(SAFE_DIVIDE(purchase * 100, payment), 2) AS payment_to_purchase_rate,
  ROUND(SAFE_DIVIDE(purchase * 100, views), 2) AS overall_conversion_rate
FROM funnel_stage
