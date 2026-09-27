# Write your MySQL query statement below
SELECT
    b.book_id,
    b.title,
    b.author,
    b.genre,
    b.publication_year,
    COUNT(r.record_id) AS current_borrowers
FROM library_books b JOIN borrowing_records r
    ON b.book_id = r.book_id
WHERE r.return_date IS NULL
GROUP BY b.book_id
HAVING COUNT(r.record_id) = MAX(b.total_copies)
ORDER BY 6 DESC, 2 ASC;