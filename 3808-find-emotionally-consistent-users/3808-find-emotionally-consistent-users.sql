# Write your MySQL query statement below
WITH tab_a AS(
    SELECT
        user_id,
        COUNT(content_id) AS total_content,
        COUNT(reaction) AS total_reaction
    FROM reactions
    GROUP BY user_id
), final_base AS (
    SELECT
        user_id,
        reaction,
        COUNT(reaction) AS reaction_count 
    FROM reactions
    GROUP BY user_id, reaction
)
SELECT
    t.user_id,
    f.reaction AS dominant_reaction,
    ROUND((f.reaction_count/t.total_reaction), 2) AS reaction_ratio
FROM tab_a t JOIN final_base f ON t.user_id = f.user_id
WHERE t.total_content >= 5
HAVING reaction_ratio >= 0.6
ORDER BY 3 DESC, 1 ASC;
