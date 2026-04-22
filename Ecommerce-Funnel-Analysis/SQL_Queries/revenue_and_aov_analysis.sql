
-- revenue funnel analysis

WITH funnel_stage AS (
  SELECT 
    COUNT(DISTINCT CASE WHEN event_type = 'page_view' THEN user_id END) AS total_visitors ,
    COUNT(DISTINCT CASE WHEN event_type = 'purchase' THEN user_id END) AS total_buyers ,
    SUM( CASE WHEN event_type = 'purchase' THEN amount END) AS total_revenue ,
     COUNT( CASE WHEN event_type = 'purchase' THEN 1  END) AS total_orders ,

  FROM `project-a33c5b81-2d90-4055-94c.sql_practice.user_events`
  WHERE event_date >= TIMESTAMP(DATE_SUB(CURRENT_DATE(), INTERVAL 100 DAY))
)

select 
total_visitors , total_buyers  , total_orders ,round(total_revenue,2) ,
round(total_revenue / total_orders) as avg_order_value,
round(total_revenue / total_buyers) as revenue_per_buyer,
round(total_revenue / total_visitors) as revenue_per_visitor

from funnel_stage

  