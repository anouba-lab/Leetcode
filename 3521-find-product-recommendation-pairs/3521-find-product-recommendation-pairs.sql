# Write your MySQL query statement below
SELECT 
    p1.product_id AS product1_id,
    p2.product_id AS product2_id,
    i1.category AS product1_category,
    i2.category AS product2_category,
    COUNT(DISTINCT p1.user_id) AS customer_count
FROM ProductPurchases p1 INNER JOIN ProductPurchases p2 
    ON p1.user_id = p2.user_id AND p1.product_id < p2.product_id
    LEFT JOIN ProductInfo i1 ON p1.product_id = i1.product_id
    LEFT JOIN ProductInfo i2 ON p2.product_id = i2.product_id 
GROUP BY 1, 2
HAVING COUNT(DISTINCT p1.user_id) >=3
ORDER BY 5 DESC, 1 ASC, 2 ASC;

