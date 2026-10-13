# Write your MySQL query statement below
WITH tab_a AS(
    SELECT
        user_id,
        plan_name,
        monthly_amount,
        event_type,
        ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY event_date DESC, event_id DESC) AS rn
    FROM subscription_events
), final_base AS(
    SELECT
        user_id,
        SUM(event_type = 'downgrade') AS downgrade_count,
        MAX(monthly_amount) AS max_historical_amount,
        DATEDIFF( MAX(event_date) ,MIN(event_date) ) AS days_as_subscriber
    FROM subscription_events
    WHERE event_type <> 'cancel'
    GROUP BY user_id
)
SELECT
    t.user_id,
    t.plan_name AS current_plan,
    t.monthly_amount AS current_monthly_amount,
    f.max_historical_amount,
    f.days_as_subscriber
FROM tab_a t JOIN final_base f ON t.user_id = f.user_id
WHERE t.rn = 1 
    AND t.event_type <> 'cancel'
    AND f.downgrade_count >= 1 
    AND f.days_as_subscriber >= 60
    AND t.monthly_amount < 0.5 * f.max_historical_amount
ORDER BY 5 DESC, 1 ASC;