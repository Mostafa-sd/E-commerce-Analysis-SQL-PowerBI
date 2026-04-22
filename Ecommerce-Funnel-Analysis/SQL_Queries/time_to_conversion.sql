
-- time to conversion

with funnel_stage as(
  SELECT
    user_id, 
    min(CASE WHEN event_type = 'page_view' THEN event_date END) AS views_time,
    min( CASE WHEN event_type = 'add_to_cart' THEN event_date END) AS cart_time,
    min( CASE WHEN event_type = 'purchase' THEN event_date END) AS purchase_time
  FROM `project-a33c5b81-2d90-4055-94c.sql_practice.user_events`
  WHERE event_date >= TIMESTAMP(DATE_SUB(CURRENT_DATE(), INTERVAL 100 DAY))
  group by user_id
  having min( CASE WHEN event_type = 'purchase' THEN event_date END) is not null
)

select
count(*) as converted_user,
round(avg(timestamp_diff(cart_time, views_time, minute)),2) as avg_view_to_chart_minute,
round(avg(timestamp_diff(purchase_time, cart_time, minute)),2) as avg_purchase_to_cart_minute,
round(avg(timestamp_diff(purchase_time, views_time, minute)),2) as avg_total_journey_minute

from funnel_stage
