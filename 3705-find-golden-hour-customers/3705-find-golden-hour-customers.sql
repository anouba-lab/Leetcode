# Write your MySQL query statement below
SELECT
    customer_id,
    COUNT(order_id) AS total_orders,
    ROUND(COUNT(
        CASE WHEN TIME_FORMAT(order_timestamp, '%H:%i') BETWEEN '11:00' AND '14:00' 
            OR TIME_FORMAT(order_timestamp, '%H:%i') BETWEEN '18:00' AND '21:00' THEN 1 
            ELSE NULL END) * 100.0/COUNT(order_id)) AS peak_hour_percentage,
    ROUND(AVG(order_rating), 2) AS average_rating
FROM restaurant_orders
GROUP BY customer_id
HAVING total_orders >= 3 AND peak_hour_percentage >= 60 
    AND average_rating >= 4.0 AND COUNT(order_rating)*100.0/COUNT(order_id) >= 50
ORDER BY 4 DESC, 1 DESC;