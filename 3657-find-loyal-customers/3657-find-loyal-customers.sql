# Write your MySQL query statement below
WITH tab_a AS(
    SELECT
        customer_id,
        DATEDIFF(MAX(transaction_date), MIN(transaction_date)) AS active_days,
        COALESCE( (SUM(CASE 
                WHEN transaction_type = "refund" THEN 1
            END) ) * 100.0/COUNT(transaction_id), 0) AS refund_rate,
        SUM(CASE
                WHEN transaction_type = "purchase" THEN 1
            END) AS total_purchase
    FROM customer_transactions 
    GROUP BY customer_id
    HAVING total_purchase >= 3
)
SELECT 
    customer_id
FROM tab_a
WHERE active_days >= 30 AND refund_rate < 20 AND total_purchase >= 3
ORDER BY customer_id ASC;