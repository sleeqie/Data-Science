SELECT released_year AS year,
    COUNT(*) AS '# of books',
    AVG(pages) AS 'avg pages'
FROM books
    GROUP BY released_year;
    
    
    SELECT pages, CONCAT(author_fname, ' ', author_lname) FROM books
ORDER BY pages DESC;