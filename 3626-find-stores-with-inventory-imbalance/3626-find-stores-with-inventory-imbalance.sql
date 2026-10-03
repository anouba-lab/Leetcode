# Write your MySQL query statement below
WITH raw_base AS(
    SELECT
        *,
        MAX(CASE 
            WHEN price = max_price THEN product_name
        END) AS most_exp_product,
        MAX(CASE 
            WHEN price = max_price THEN quantity
        END) AS exp_quantity,
        MAX(CASE 
            WHEN price = min_price THEN product_name
        END) AS cheapest_product,
        MAX(CASE
            WHEN price = min_price THEN quantity
        END) AS cheap_quantity
    FROM 
        (
        SELECT
            i.*,
            MAX(price) OVER(PARTITION BY store_id) AS max_price,
            MIN(price) OVER(PARTITION BY store_id) AS min_price
        FROM Inventory i
        ) tab_a
    GROUP BY store_id
    HAVING COUNT(DISTINCT product_name) >= 3
)
SELECT
    s.store_id,
    s.store_name,
    s.location,
    r.most_exp_product,
    r.cheapest_product,
    ROUND( (r.cheap_quantity/r.exp_quantity), 2) AS imbalance_ratio
FROM raw_base r JOIN stores s ON r.store_id = s.store_id
WHERE r.cheap_quantity > r.exp_quantity
ORDER BY 6 DESC, 2 ASC;