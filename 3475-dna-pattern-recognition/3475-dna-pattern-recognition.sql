# Write your MySQL query statement below
SELECT
    *,
    CASE
        WHEN LOWER(dna_sequence) LIKE 'atg%' 
        THEN 1 ELSE 0
    END AS has_start,
    CASE
        WHEN LOWER(dna_sequence) LIKE '%taa' 
        OR LOWER(dna_sequence) LIKE '%tag'
        OR LOWER(dna_sequence) LIKE '%tga'  
        THEN 1 ELSE 0
    END AS has_stop,
    CASE
        WHEN LOWER(dna_sequence) LIKE '%atat%' 
        THEN 1 ELSE 0
    END AS has_atat,
    CASE
        WHEN LOWER(dna_sequence) LIKE '%ggg%'
        OR LOWER(dna_sequence) LIKE '%gggg%' 
        THEN 1 ELSE 0
    END AS has_ggg
FROM Samples
ORDER BY sample_id;