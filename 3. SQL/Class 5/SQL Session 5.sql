-- TO DO task
-- Exercise 1: Fetch those customer's first name and last name who have made puchases.

-- Exercise 2: Display how much amount have been spent by each and every customer.

-- Exercise 3: What is the the total amount spent (SUM(ph.total_amount)) for each category?

CREATE DATABASE atomcamp;

USE atomcamp;

DROP TABLE purchase_history;

set sql_safe_updates = 0;
select * from customer;
update customer
set date_of_birth = str_to_date(date_of_birth,"%m/%d/%Y");

alter table customer 
modify date_of_birth DATE;



-- customer => signup_date
select * from customer;
update customer
set signup_date = str_to_date(signup_date,"%m/%d/%Y");

alter table customer 
modify signup_date DATE;

-- purchase_history => purchase_date
select * from purchase_history;
update purchase_history
set purchase_date = str_to_date(purchase_date,"%m/%d/%Y %H:%i");

alter table purchase_history 
modify purchase_date DATETIME;

-- Table: customer
ALTER TABLE customer
ADD PRIMARY KEY (customer_id);

-- Table: products
ALTER TABLE products
ADD PRIMARY KEY (product_id);

-- Table: purchase_history
ALTER TABLE purchase_history
ADD PRIMARY KEY (purchase_id);

-- Full join
-- Include all data from customers and purchase history
SELECT *
FROM customer c
LEFT JOIN purchase_history ph ON c.customer_id=ph.customer_id

UNION

SELECT *
FROM customer c
RIGHT JOIN purchase_history ph ON c.customer_id=ph.customer_id;

-- Self Join
-- Find products within the same category
SELECT p1.product_name as "Product 1 Name", p2.product_name as "Product 2 Name", p1.category as "Category"
FROM products p1
JOIN products p2 ON p1.category=p2.category
WHERE "Product 1 Name" <> "Product 2 Name";

-- Which customers live in the same city
SELECT c1.first_name AS "Customer 1 Name", c2.first_name AS "Customer 2 Name", c1.city as "City"
FROM customer c1
JOIN customer c2 ON c1.city=c2.city
WHERE c1.customer_id=c2.customer_id;

-- Which products have similar prices
SELECT p1.product_name AS "Product 1 Name", p2.product_name AS "Product 2 Name", ABS(p1.price_per_unit - p2.price_per_unit) AS "Difference in Price"
FROM products p1
JOIN products p2 ON p1.product_id < p2.product_id
WHERE ABS(p1.price_per_unit - p2.price_per_unit) < 4;

-- Cross Join
-- Pair each category with Brand
SELECT DISTINCT p1.category, p2.brand
FROM products p1
CROSS JOIN products p2;

-- Sub-Query
-- list down product with price greater than average
SELECT *
FROM products
WHERE price_per_unit > (
	SELECT AVG(price_per_unit)
    FROM products
);

-- Single-Row Subquery
-- Returns only one row and one column, typically used with single-value comparisons
-- Display details of product which has the highest price
SELECT *
FROM products
ORDER BY price_per_unit DESC
LIMIT 1;

SELECT *
FROM products
WHERE price_per_unit = (
	SELECT MAX(price_per_unit)
    FROM products
);


-- Multi-Row Subquery
-- Returns multiple rows and single column
-- Find the product details for products that have been purchased.
SELECT DISTINCT p.*
FROM products p
INNER JOIN purchase_history ph ON p.product_id = ph.product_id;

SELECT *
FROM products
WHERE product_id IN (
	SELECT DISTINCT product_id
    FROM purchase_history
);

-- List the name of cutomers who have purchased a product with a specific product id
SELECT *
FROM customer
WHERE customer_id IN (
	SELECT DISTINCT customer_id
    FROM purchase_history
    WHERE product_id = 1
);

-- Subqueries in SELECT
-- How many products are there in the databases, and what is the total sales amount
SELECT COUNT(*) AS "Total Producs", (SELECT SUM(total_amount) FROM purchase_history) AS "Total Sales"
FROM products;

-- Subqueries in CASE statement
-- Label products as "Expensive" if price per unit is above average, "Not Expensive" otherwise.
SELECT *,
	CASE
		WHEN price_per_unit > (SELECT AVG(price_per_unit) FROM products) THEN "Expensive"
        ELSE "Not Expensive"
        END "Price Label"
FROM products;