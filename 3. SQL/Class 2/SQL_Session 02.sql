-- Sql language is case -insensitive

-- Select Database
USE users_record;

-- Show all the data
SELECT 
    *
FROM
    books_data;

-- WHERE 
-- refers to conditional statements. 
SELECT * FROM books_data;



-- Fetch the record of book "alchemist"
SELECT * FROM books_data
WHERE Book_name = "alchemist";

--  Exercise: Find books in the `books_data` table with  real price greater than 900.
SELECT * FROM books_data
WHERE product_real_price > 900;

--  Exercise: Show books that are in hindi Language
SELECT * FROM books_data
WHERE language = "hindi";

-- WHERE with (IN, OR, AND, NOT EQUAL TO, NOT IN)


-- And
-- Exercise: Show the books with discount_offered_prcnt is in range of 30 - 40. ( 30>=  and <=40 )
SELECT * FROM books_data
WHERE discount_offered_prcnt >= 30 AND discount_offered_prcnt <=40;


-- OR
-- Exercise: Identify books that are either in english or Hindi or bengali
SELECT * FROM books_data
WHERE language = "English" OR language = "Hindi" OR language = "bengali"; 

-- IN
SELECT * FROM books_data
WHERE language IN ("English","Hindi", "Bengali");

-- Not IN
-- Exercise: Identify books that are NOT in english or Hindi or bengali
SELECT * FROM books_data
WHERE language NOT IN ("English","Hindi", "Bengali");


-- Like
-- Exercise: List down the books details with Author Name starts with either A or B;
SELECT * FROM books_data
WHERE author LIKE "A%" OR author LIKE "B%";

SELECT * FROM books_data
WHERE author LIKE "%A";

SELECT * FROM books_data
WHERE author LIKE "%A%";


SELECT * FROM books_data
WHERE type LIKE "%back";

SELECT * FROM books_data
WHERE type LIKE "%oo%";


-- Not Equal ( != , <>)
-- Exercise: Display the books with properly defined type, NOT other.
SELECT * FROM books_data
WHERE type != "paperback";

SELECT * FROM books_data
WHERE type <> "paperback";

-- Order BY
-- Exercise: Order authors by their names in ascending order
SELECT * FROM books_data
ORDER BY author;


-- LIMIT
-- Exercise: List the top 5 highest rating books from the table.
SELECT * FROM books_data
ORDER BY product_rating DESC
LIMIT 5;

SELECT * FROM books_data ORDER BY author;


-- Modifying and Updating Tables
-- Add a new column to the dataset
ALTER TABLE books_data
add record_date date;

-- alter table table_name 
-- add column_name datatype;


-- SQL safe updates off/ disable
set sql_safe_updates = 0;

-- Update the date to today's date 
select * from books_data;
update books_data
set record_date = "2024-07-02";

select * from books_data;


-- Update the author name of "his divine grace a.c. bhaktivedanta swami prabhupada""" to 'a.c. bhaktivedanta swami prabhupada'
select * from books_data
order by author;

update books_data
set author = "a.c. bhaktivedanta swami prabhupada"
where author = '"his divine grace a.c. bhaktivedanta swami prabhupada"""';

select * from books_data
order by author;


-- Rename column name
alter table books_data
rename column Book_name to Book_Title;

-- alter table table_name
-- rename column old_column_name to new_column_name


-- change the datatype from date to datetime
alter table books_data
modify record_date datetime;


-- update the record_date value for book "Atomic habits"
select * from books_data;

select * from books_data
where Book_Title="atomic habits";

update books_data
set record_date = "2020-06-30 12:59:25"
where Book_Title="atomic habits";

select * from books_data
where Book_Title="atomic habits";

select * from books_data;

select * from books_data
where Book_Title = "Think and Grow Rich";


update books_data
set language = "URDU"
where Book_Title = "Think and Grow Rich";

select * from books_data
where  sr_no=0;

-- DELETE Statements:
-- Delete the first record with sr_no = 0 
Delete from books_data
where sr_no=0;
select * from books_data;

-- Add a primary key to existing table
ALTER table books_data 
add primary key (sr_no );

-- Auto increment
alter table books_data
modify sr_no int auto_increment;



-- insert a record without sr_no to check how it works
select * from books_data;
insert into books_data (Book_Title, author, language, type, product_real_price, product_disc_price, product_rating, product_raters, discount_offered_prcnt, on_promotion, record_date)
values 
('abc', 'def', 'English', 'Paperback', '175', '97', '4.3', '7786', '44', 'No', '2024-07-02 00:00:00');
select * from books_data;



-- Convert Author names to uppercase:
update books_data 
set author = upper(author);

select lower(author) from books_data;

-- Remove leading/trailing whitespaces from the name field
-- TRIM

update books_data
set author = trim(author);



-- Concatenation
-- Show the column with values as "This __book__ is in ___this__ language "
select concat("This ",book_title, " is in ", language, " language") from books_data;

-- alias 
-- nickname / short name
select concat("This ",book_title, " is in ", language, " language")  as Book_details;

select product_real_price real_price
from books_data;


-- drop column 
alter table books_data
 drop column record_date;




-- Drop the table
drop table books_data;
drop database database_name;