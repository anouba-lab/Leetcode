WITH tab_a AS (
    SELECT
        id,
        name,
        salary,
        departmentId,
        DENSE_RANK() OVER(PARTITION BY departmentId ORDER BY salary DESC) AS d_rank
    FROM Employee
)
SELECT
    d.name AS Department,
    t.name AS Employee,
    t.salary AS Salary
FROM Department d JOIN tab_a t ON d.id = t.departmentId
WHERE t.d_rank = 1