# Write your MySQL query statement below
WITH recent_3 AS (
    SELECT
        employee_id,
        review_date,
        rating,
        ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY review_date DESC) AS r_num
    FROM performance_reviews
), final_base AS(
    SELECT
        *,
        rating - LEAD(rating) OVER(PARTITION BY employee_id ORDER BY review_date DESC) AS rating_improvement
    FROM recent_3
    WHERE r_num <= 3
)
SELECT
    e.employee_id,
    e.name,
    MAX(rating) - MIN(rating) AS improvement_score
FROM final_base f JOIN employees e
    ON f.employee_id = e.employee_id
WHERE f.rating_improvement > 0 OR f.rating_improvement IS NULL
GROUP BY e.employee_id
HAVING COUNT(*) = 3
ORDER BY 3 DESC, 2 ASC;