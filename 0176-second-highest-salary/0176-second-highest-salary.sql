# Write your MySQL query statement below
WITH tab_a AS (
    SELECT
        id,
        salary,
        DENSE_RANK() OVER(ORDER BY salary DESC) AS d_rank
    FROM Employee
)
SELECT
    MAX(salary) AS SecondHighestSalary
FROM tab_a 
WHERE d_rank = 2;