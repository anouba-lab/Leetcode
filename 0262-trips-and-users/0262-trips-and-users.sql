# Write your MySQL query statement below
WITH valid_trips AS (
    SELECT
        t.*
    FROM Trips t JOIN Users uc
        ON t.client_id = uc.users_id 
        JOIN Users ud ON t.driver_id = ud.users_id 
    WHERE uc.banned = 'No' AND ud.banned = 'No'
        AND t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
)
SELECT 
    request_at AS 'Day',
    ROUND((
        COUNT(CASE 
                WHEN LOWER(TRIM(status)) <> 'completed' THEN id
              END)/ COUNT(*)), 2) AS 'Cancellation Rate'
FROM valid_trips
GROUP BY request_at;


