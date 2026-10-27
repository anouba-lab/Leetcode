# Write your MySQL query statement below
DELETE
    p.*
FROM Person p JOIN Person p1
    ON p.email = p1.email AND p.id > p1.id;