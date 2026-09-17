# Write your MySQL query statement below
WITH tab_a AS (
    SELECT
        student_id,
        subject,
        FIRST_VALUE(score) OVER(PARTITION BY student_id, subject ORDER BY exam_date ASC) AS first_score,
        FIRST_VALUE(score) OVER(PARTITION BY student_id, subject ORDER BY exam_date DESC) AS latest_score
    FROM Scores
)
SELECT DISTINCT *
FROM tab_a
WHERE first_score < latest_score
ORDER BY student_id ASC, subject ASC;
