# Write your MySQL query statement below
WITH tab_a AS (
    SELECT
        c.patient_id,
        MIN(c.test_date) AS sick_date,
        MIN(ct.test_date) AS recover_date
    FROM covid_tests c JOIN covid_tests ct
        ON c.patient_id = ct.patient_id
    WHERE ct.test_date > c.test_date AND c.result = "Positive" AND ct.result = "Negative"
    GROUP BY patient_id
)
SELECT
    t.patient_id,
    p.patient_name,
    p.age,
    DATEDIFF(t.recover_date, t.sick_date) AS recovery_time 
FROM tab_a t JOIN patients p
    ON t.patient_id = p.patient_id
WHERE t.sick_date IS NOT NULL AND t.recover_date IS NOT NULL
GROUP BY t.patient_id
HAVING recovery_time > 0
ORDER BY 4 ASC, 2 ASC;