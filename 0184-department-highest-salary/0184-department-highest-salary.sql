# Write your MySQL query statement below
WITH max_sal AS (
    SELECT
        departmentId,
        MAX(salary)
    FROM Employee
    GROUP BY 1
)

SELECT
    DISTINCT d.name AS Department,
    e.name AS Employee,
    e.salary AS Salary
FROM Employee e JOIN Department d 
    ON e.departmentId = d.id 
WHERE (d.id, e.salary) IN (SELECT * FROM max_sal);