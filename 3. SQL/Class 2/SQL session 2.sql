USE users_record;

SELECT *
FROM books_data;

-- Fetch the record of book "alchemist"
SELECT *
FROM books_data
WHERE Book_name = "alchemist";

-- Show books in hindi language
SELECT *
FROM books_data
WHERE language = 'Hindi';

-- AND
-- Show books where discount_offered_prcnt is in range of 30 - 40
SELECT *
FROM books_data
WHERE discount_offered_prcnt >= 30 AND discount_offered_prcnt <= 40;

-- OR
-- Identify books that are either in english, hindi or bengali
SELECT *
FROM books_data
WHERE language = 'Hindi' OR language = 'Bengali' OR language = 'English';

-- IN
SELECT *
FROM books_data
WHERE language IN ('Hindi', 'Bengali', 'English');

-- NOT IN
-- Identify books that are neither in english, hindi or bengali
SELECT *
FROM books_data
WHERE language NOT IN ('Hindi', 'Bengali', 'English');

-- LIKE
-- List down thw books details with author name starts with either A or B
SELECT *
FROM books_data
WHERE author LIKE 'A%' OR author LIKE 'B%';

SELECT *
FROM books_data
WHERE author LIKE '%A';

SELECT *
FROM books_data
WHERE author LIKE '%A%';

SELECT *
FROM books_data
WHERE type LIKE '%back%';

-- <> OR !=
-- Display the books with properly defined type, NOT other
SELECT *
FROM books_data
WHERE type <> "other";

-- ORDER BY
-- List the top 5 highest rating books from the table

SELECT *
FROM books_data
ORDER BY product_rating
LIMIT 5;

-- List the books that are on promotion
SELECT *
FROM books_data
WHERE on_promotion = 'yes';

-- List the 10 least expensive books
SELECT *
FROM books_data
ORDER BY product_real_price ASC
LIMIT 10;

-- List the books that are more than 10 percent off
SELECT *
FROM books_data
WHERE discount_offered_prcnt > 10;

-- ALTER
ALTER TABLE books_data
ADD record_date DATE;

-- UPDATE
UPDATE books_data
SET record_date = "2024-07-02";

-- SQL safe updates off
SET sql_safe_updates = 0;

-- Update is used to modify the inner structure or the data in the table
-- UPDATE the author name of "his divine grace a.c. bhaktivedanta swami prabhupada""" to a.c. bhaktivedanta swami parabhupada
UPDATE books_data
SET author = 'a.c. bhaktivedanta swami parabhupada'
WHERE author = '"his divine grace a.c. bhaktivedanta swami prabhupada"""';

-- Alter is used to modify the outer structure of the table
-- ALTER column name

ALTER TABLE books_data
RENAME COLUMN Book_name TO Book_title;

ALTER TABLE books_data
MODIFY record_date DATETIME;

-- UPDATE the record_date fro book "Atomic habits"
UPDATE books_data
SET record_date = "2020-06-30 12:59:25"
WHERE Book_title = "Atomic habits";

-- DELETE
-- DELETE the first record with sr_no = 0
DELETE
FROM books_data
WHERE sr_no = 0;

-- Add primary key to existing table
ALTER TABLE books_data
ADD PRIMARY KEY (sr_no);
-- Some versions of SQl doesnt allow columns that have 0 or negative values in the column to become primary keys


-- Auto Increment: automatically assigns a new primary key value to a new record by incrementing the last primary and assigning it to the new record
ALTER TABLE books_data
MODIFY sr_no int AUTO_INCREMENT;

INSERT INTO books_data ('Book_title', 'author', 'language', 'type', 'product_real_price', 'product_disc_price', 'product_rating', 'product_raters', 'discount_offered_prcnt', 'on_promotion', 'record_date')
VALUES('Fifty Shades of Black', 'Hajar Bhai', 'Tutul Putul', 'Paperbook', 6969, 420, 4.9, 2, 100, 'yes', '2024-07-02');

-- Changing names of author to upper values
UPDATE books_data
SET author = UPPER(author);

-- Trimmimg the names of author
UPDATE books_data
SET author = TRIM(author);

-- CONCAT
-- Show the column values with values as "This__book__is in__this__language"
SELECT CONCAT("This ", book_title, " is in ", language, " language")
FROM books_data;

-- ALIAS
SELECT Book_title
FROM books_data as b;

-- DROP column
ALTER TABLE books_data
DROP COLUMN record_date;

-- DROP table
DROP TABLE books_data;

-- DROP database
DROP DATABASE one_day_international;
--