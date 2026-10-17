# Write your MySQL query statement below
SELECT
    DISTINCT A.num AS ConsecutiveNums
FROM Logs A JOIN Logs B 
    ON B.id = A.id + 1 JOIN Logs C
    ON C.id = A.id + 2
WHERE A.num = B.num AND
      B.num = C.num AND 
      C.num = A.num;