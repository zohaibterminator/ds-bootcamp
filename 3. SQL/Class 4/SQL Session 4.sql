CREATE DATABASE ATOMCAMP;
USE ATOMCAMP;
SET SQL_SAFE_UPDATES = 0;

-- There is a problem with the data type of columns with dates.
-- But we can't modify the data type directly as the format is not right.

-- Updating date_of_birth column
UPDATE customer
SET date_of_birth = str_to_date(date_of_birth, "%m/%d/%Y");

ALTER TABLE customer
MODIFY COLUMN date_of_birth DATE;

-- Updating signup column
UPDATE customer
SET signup_date = str_to_date(signup_date, "%m/%d/%Y");

ALTER TABLE customer
MODIFY COLUMN signup_date DATE;

-- Updating purchase_date column
UPDATE purchase_history
SET purchase_date = str_to_date(purchase_date, "%m/%d/%Y %H:%i");

ALTER TABLE purchase_history
MODIFY COLUMN purchase_date DATETIME;

-- Checking results
SELECT *
FROM CUSTOMER;

SELECT *
FROM purchase_history;

-- Adding primary key in tables
ALTER TABLE customer
ADD PRIMARY KEY(customer_id);

ALTER TABLE products
ADD PRIMARY KEY(product_id);

ALTER TABLE purchase_history
ADD PRIMARY KEY(purchase_id);

-- Adding foreign key in purchase_history table
ALTER TABLE purchase_history
ADD CONSTRAINT fk_1
FOREIGN KEY(product_id) REFERENCES products(product_id);

ALTER TABLE purchase_history
ADD CONSTRAINT fk_2
FOREIGN KEY(customer_id) REFERENCES customer(customer_id);

-- Inner Join
-- Retrieve customer information with their purchase history
SELECT *
FROM customer as c, purchase_history as p
WHERE c.customer_id=p.customer_id;

SELECT *
FROM customer as c
INNER JOIN purchase_history as ph ON c.customer_id=ph.customer_id;

-- Retrieve products with purchase history
SELECT p.*, ph.purchase_date, ph.quantity, ph.total_amount
FROM products p
INNER JOIN purchase_history ph ON p.product_id=ph.product_id;

-- How many purchases are made by each customer in total (only mention those customer that made payments)
SELECT c.customer_id, COUNT(purchase_id) AS "Total purchases"
FROM customer c
INNER JOIN purchase_history ph ON c.customer_id=ph.customer_id
GROUP BY c.customer_id;

-- How many customer have spent more than 1500 amount
SELECT c.customer_id, SUM(ph.total_amount) AS "Total Amount"
FROM customer c
INNER JOIN purchase_history ph ON c.customer_id=ph.customer_id
GROUP BY c.customer_id
HAVING SUM(ph.total_amount) > 1500;

-- How many purchases were made for each product category?
SELECT p.category, COUNT(ph.purchase_id)
FROM products p
INNER JOIN purchase_history ph ON p.product_id=ph.product_id
GROUP BY p.category;

-- Which products frequenty purchased by female customers
SELECT p.product_name, COUNT(ph.purchase_id) as "Purchase Frequency"
FROM purchase_history ph
INNER JOIN products p ON ph.product_id=p.product_id
INNER JOIN customer c ON ph.customer_id=c.customer_id
WHERE c.Gender='Female'
GROUP BY p.product_name
ORDER BY COUNT(ph.purchase_id) DESC;

-- Left Join
-- Which customer have not made any purchases
SELECT c.*
FROM customer c
LEFT JOIN purchase_history ph ON c.customer_id=ph.customer_id
WHERE ph.purchase_id is NULL;

-- Which product id have not been purchased
SELECT p.*
FROM products p
LEFT JOIN purchase_history ph ON p.product_id=ph.product_id
WHERE ph.purchase_id is NULL;

-- Analyze the sales for all products
SELECT p.product_id, SUM(ph.total_amount) as "Total Sales"
FROM products p
LEFT JOIN purchase_history ph ON p.product_id=ph.product_id
GROUP BY p.product_id;

-- Right Join
-- What is the total number of purchases and the total amount spend for each product brand
SELECT p.product_id, COUNT(ph.purchase_id) as "Number of Purchases", SUM(ph.total_amount) as "Total amount spend"
FROM purchase_history ph
RIGHT JOIN products p ON ph.product_id=p.product_id
GROUP BY p.product_id;

-- How many purchases have each customer made
SELECT c.customer_id, COUNT(ph.purchase_id) as "Total Purchases"
FROM purchase_history ph
RIGHT JOIN customer c ON ph.customer_id=c.customer_id
GROUP BY c.customer_id;