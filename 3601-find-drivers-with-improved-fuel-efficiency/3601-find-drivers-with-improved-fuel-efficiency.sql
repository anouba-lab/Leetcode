# Write your MySQL query statement below
WITH tab_a AS ( 
    SELECT
        *,
        distance_km/fuel_consumed AS fuel_efficiency,
        CASE 
            WHEN MONTH(trip_date) < 7 THEN "first_half"
            WHEN MONTH(trip_date) > 6 THEN "second_half"
        END AS term
    FROM trips
)
SELECT
    t.driver_id,
    d.driver_name,
    ROUND( AVG(CASE 
            WHEN t.term = "first_half" THEN t.fuel_efficiency
            END), 2) AS first_half_avg,
    ROUND( AVG(CASE 
            WHEN t.term = "second_half" THEN t.fuel_efficiency
            END), 2) AS second_half_avg,
    ROUND( AVG(CASE 
            WHEN t.term = "second_half" THEN t.fuel_efficiency
            END) -  AVG(CASE 
            WHEN t.term = "first_half" THEN t.fuel_efficiency
            END), 2) AS efficiency_improvement      
FROM tab_a t JOIN drivers d
    ON t.driver_id = d.driver_id
GROUP BY t.driver_id
HAVING second_half_avg > first_half_avg
ORDER BY 5 DESC, 2 ASC;