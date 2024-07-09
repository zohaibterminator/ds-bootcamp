-- Data Definition Language
-- Create database

CREATE DATABASE users_record;

-- Use or Select database

USE users_record;

-- Table Create
CREATE TABLE users (
	user_id int PRIMARY KEY,
    username VARCHAR(100),
    age int
);

-- Data Retrieval
SELECT *
FROM users;

-- Data Insertion
INSERT INTO users (user_id, username, age)
VALUES
(1, "Zohaib", 20),
(2, "Onais", 21),
(3, "Usman", 21),
(4, "Hajar", 4),
(5, "Ali", 21);

-- Task:
-- 1. Create Databse
-- 2. Create table with 3 columns atleast
-- 3. Insert around 15 entries

CREATE DATABASE one_day_international;

USE one_day_international;

CREATE TABLE pakistan_team (
	player_id int PRIMARY KEY,
	player_name VARCHAR(100),
    player_description VARCHAR(200)
);

INSERT INTO pakistan_team (player_id, player_name, player_description)
VALUES
(1, "Babar Azam", "Right-handed, top-order batsman. Captain of the Pakistan team and among the best players of the world"),
(2, "Muhammad Rizwan", "Right-handed, wicket keeper batsman. Best T20 player of Pakistan" ),
(3, "Azam Khan", "Right-handed, wicket keeper batsman. Known for his performances in the PSL and CPL tournaments"),
(4, "Fakhar Zaman", "Left-handed, top-order batsman."),
(5, "Misbah-ul-Haq", "Right-handed, middle-order batsman"),
(6, "Shahid Afridi", "Right-handed, middle-order batsman"),
(7, "Mohammad Amir", "Left-handed, fast-medium bowler"),
(8, "Rumman Raees", "Left-handed, fast-medium bowler"),
(9, "Naseem Shah", "Right-handed, fast bowler"),
(10, "Wasim Akram", "Left-handed, fast bowler")
;

-- Loading data from books_data table
SELECT *
FROM books_data;

-- Fetch all unique languages
SELECT DISTINCT language
FROM books_data;

-- query optimization: only select those columns whose data you desire to see

-- Fetch all books that are > Rs 950
SELECT *
FROM books_data
WHERE product_real_price > 950;

-- Show those books whose language is English
SELECT *
FROM books_data
WHERE language = "English";

-- Sort the dataset by product_real_price
SELECT *
FROM books_data
ORDER BY product_real_price DESC; # by default it is in ascending order

-- Limit = to show specific number of rows
SELECT *
FROM books_data
LIMIT 2;

SHOW DATABASES; --  to show the names of all existing databases
SHOW TABLES; -- to show the names of all existing tables