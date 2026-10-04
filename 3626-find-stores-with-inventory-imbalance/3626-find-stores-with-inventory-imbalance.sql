# Write your MySQL query statement below
WITH tab_a AS(
    SELECT
        store_id,
        MAX(price) AS max_price,
        MIN(price) AS min_price
    FROM Inventory
    GROUP BY store_id
), final_base AS(
    SELECT
        t.store_id,
        MAX(CASE 
            WHEN i.price = t.max_price THEN i.product_name 
        END) AS most_exp_product,
        MAX(CASE 
            WHEN i.price = t.max_price THEN i.quantity
        END) AS exp_quantity,
        MAX(CASE 
            WHEN i.price = t.min_price THEN i.product_name
        END) AS cheapest_product,
        MAX(CASE
            WHEN i.price = t.min_price THEN i.quantity
        END) AS cheap_quantity
    FROM tab_a t JOIN Inventory i ON t.store_id = i.store_id 
    GROUP BY t.store_id
    HAVING COUNT(i.product_name) > 2
)
SELECT
    f.store_id,
    s.store_name,
    s.location,
    f.most_exp_product,
    f.cheapest_product,
    ROUND((f.cheap_quantity/f.exp_quantity), 2) AS imbalance_ratio
FROM final_base f JOIN Stores s ON f.store_id = s.store_id
WHERE f.cheap_quantity > f.exp_quantity
ORDER BY 6 DESC, 2 ASC;