
-- funnel by source

with funnel_stage as(
  SELECT
    traffic_source, 
    COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS views,
    COUNT(DISTINCT CASE WHEN event_type = 'add_to_cart' THEN user_id END) AS cart,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS purchase
  FROM `project-a33c5b81-2d90-4055-94c.sql_practice.user_events`
  WHERE event_date >= TIMESTAMP(DATE_SUB(CURRENT_DATE(), INTERVAL 100 DAY))
  group by traffic_source
)
select  
  traffic_source,
  views,cart,purchase,
  round(cart*100/views) as cart_conversion_rate,
  round(purchase*100/cart)as cart_to_purchase_conversion_rate,
  round(purchase*100/views)as purchase_conversion_rate,
from funnel_stage
