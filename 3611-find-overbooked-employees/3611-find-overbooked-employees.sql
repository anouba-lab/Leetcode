# Write your MySQL query statement below
WITH tab_a AS(
    SELECT
        e.employee_id,
        e.employee_name,
        e.department,
        YEARWEEK(m.meeting_date, 3) AS week_num,
        SUM(m.duration_hours) AS total_hours
    FROM employees e
    JOIN meetings m ON e.employee_id = m.employee_id
    GROUP BY e.employee_id, e.employee_name, YEARWEEK(m.meeting_date, 3)
), final_base AS(
    SELECT
        employee_id,
        employee_name,
        department,
        CASE WHEN total_hours > 20 THEN 1 ELSE 0 END AS is_heavy
    FROM tab_a
)
SELECT
    employee_id,
    employee_name,
    department,
    SUM(is_heavy) AS meeting_heavy_weeks
FROM final_base
GROUP BY employee_id
HAVING SUM(is_heavy) >= 2
ORDER BY 4 DESC, 2 ASC;