
-- SQL Assignment 01

-- Objective:
-- Understand and apply basic SQL operations including database creation, data retrieval, data manipulation, and aggregation.


-- 1. Create a database named EcommerceOrders.
CREATE DATABASE EcommerceOrders;

-- 2. Select / use the database.
USE EcommerceOrders;

-- 3. Create a table named Orders with the following columns:
	-- OrderID (Primary Key, Auto Increment)
	-- CustomerName
	-- Email
	-- Product
	-- Category
	-- Quantity
	-- Price
	-- OrderDate
CREATE TABLE Orders (
	OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(30),
	Email VARCHAR(30),
	Product VARCHAR(20),
	Category VARCHAR(20),
	Quantity INT,
	Price DOUBLE,
	OrderDate DATE
);
    
-- 4. Insert the given rows into table
	-- complete the given code by writing the table name
    
INSERT INTO Orders (CustomerName, Email, Product, Category, Quantity, Price, OrderDate) 
VALUES
	('Ali Khan', 'ali.khan@example.com', 'Laptop', 'Electronics', 1, 1200, '2023-01-15'),
	('Fatima Ahmed', 'fatima.ahmed@example.com', 'Smartphone', 'Electronics', 2, 800, '2023-01-17'),
	('Bilal Shah', 'bilal.shah@example.com', 'Office Chair', 'Furniture', 3, 150, '2023-01-20'),
	('Ayesha Malik', 'ayesha.malik@example.com', 'Desk Lamp', 'Furniture', 5, 25, '2023-01-22'),
    ('Omar Farooq', 'omar.farooq@example.com', 'Mixer', 'Kitchen', 1, 60, '2023-02-01'),
	('Mehreen Akhtar', 'mehreen.akhtar@example.com', 'Air Conditioner', 'Home Appliances', 1, 1000, '2023-02-03'),
	('Asad Mirza', 'asad.mirza@example.com', 'Toaster', 'Kitchen', 1, 25, '2023-02-07'),
	('Usman Sheikh', 'usman.sheikh@example.com', 'Coffee Maker', 'Kitchen', 1, 80, '2023-01-25'),
	('Sara Yousaf', 'sara.yousaf@example.com', 'Blender', 'Kitchen', 1, 50, '2023-01-28'),
	('Hassan Iqbal', 'hassan.iqbal@example.com', 'Book', 'Books', 10, 15, '2023-01-30'),
	('Rabia Karim', 'rabia.karim@example.com', 'Microwave', 'Kitchen', 1, 100, '2023-02-01'),
    ('Mehreen Akhtar', 'mehreen.akhtar@example.com', 'Coffee Maker', 'Kitchen', 1, 80, '2023-02-08'),
	('Arif Ali', 'arif.ali@example.com', 'Headphones', 'Electronics', 2, 200, '2023-02-03'),
	('Nida Khan', 'nida.khan@example.com', 'Monitor', 'Electronics', 1, 300, '2023-02-05'),
	('Zainab Javed', 'zainab.javed@example.com', 'Tablet', 'Electronics', 1, 150, '2023-02-07'),
	('Omar Farooq', 'omar.farooq@example.com', 'Vacuum Cleaner', 'Home Appliances', 1, 250, '2023-02-10'),
	('Mehreen Akhtar', 'mehreen.akhtar@example.com', 'Washing Machine', 'Home Appliances', 1, 500, '2023-02-12'),
	('Asad Mirza', 'asad.mirza@example.com', 'Refrigerator', 'Home Appliances', 1, 800, '2023-02-14'),
	('Sana Tariq', 'sana.tariq@example.com', 'Air Conditioner', 'Home Appliances', 1, 1000, '2023-02-16'),
	('Ahmad Raza', 'ahmad.raza@example.com', 'Electric Kettle', 'Kitchen', 1, 30, '2023-02-18'),
	('Hiba Anwar', 'hiba.anwar@example.com', 'Toaster', 'Kitchen', 1, 25, '2023-02-20'),
	('Faisal Nawaz', 'faisal.nawaz@example.com', 'Blender', 'Kitchen', 1, 40, '2023-02-22'),
	('Mariam Saeed', 'mariam.saeed@example.com', 'Cooker', 'Kitchen', 1, 70, '2023-02-24'),
	('Imran Siddiqui', 'imran.siddiqui@example.com', 'Mixer', 'Kitchen', 1, 60, '2023-02-26'),
    ('Omar Farooq', 'omar.farooq@example.com', 'Mixer', 'Kitchen', 1, 60, '2023-02-27'),
	('Mehreen Akhtar', 'mehreen.akhtar@example.com', 'Air Conditioner', 'Home Appliances', 1, 1000, '2023-02-21'),
	('Asad Mirza', 'asad.mirza@example.com', 'Toaster', 'Kitchen', 1, 25, '2023-02-17'),
	('Sana Tariq', 'sana.tariq@example.com', 'Cooker', 'Kitchen', 1, 70,  '2023-02-20');


-- 4. Retrieve all records from the table.
SELECT *
FROM Orders;


-- 5. Retrieve orders where the category is 'Electronics'.
SELECT *
FROM Orders
WHERE Category = 'Electronics';


-- 6. Retrieve orders where the price is above 100.
SELECT *
FROM Orders
WHERE Price > 100;


-- 7. Add the Sales/Revenue Column to the Table: (choose one name. either sales or revenue)
ALTER TABLE Orders
ADD COLUMN Revenue DOUBLE;


-- 8. Update the Sales/Revenue Column with price * Quantity. 
SET SQL_SAFE_UPDATES = 0;

UPDATE Orders
SET Revenue = Price * Quantity;


-- 9. Find the total sales generated from the 'Electronics' category.
SELECT SUM(Revenue) AS "Total Sales generated from the Electronics category"
FROM Orders
WHERE Category = 'Electronics';


-- 10. List the top 5 customers by the total amount spent.
SELECT Email, SUM(Revenue) AS "Total Amount spent"
FROM Orders
GROUP BY Email
ORDER BY SUM(Revenue) DESC
LIMIT 5;


-- 11. Find the average price of products in each category.
SELECT Category, AVG(Price)
FROM Orders
GROUP BY Category;


-- 12. List all products that have been ordered more than 5 times.
SELECT Product, COUNT(*)
FROM Orders
GROUP BY Product
HAVING COUNT(Product) > 5;


-- 13. Calculate the total number of products sold in the 'Kitchen' category.
SELECT Category, COUNT(Product) AS "Total number of Products"
FROM Orders
WHERE Category = 'Kitchen';


-- 14. Use the IF or CASE statement to create a temporary new column PriceCategory where:
	-- Orders with a price above 200 are 'High'
	-- Orders with a price between 100 and 200 are 'Medium'
	-- Orders with a price below 100 are 'Low'
SELECT *,
	CASE
		WHEN Price > 200 THEN "High"
		WHEN Price BETWEEN 100 AND 200 THEN "Medium"
		ElSE "Low"
		END 'PriceCategory'
FROM Orders;


-- 15. Identify customers who have placed 2 or more orders.
SELECT Email, COUNT(OrderID) AS "Number of Orders"
FROM Orders
GROUP BY Email
HAVING COUNT(OrderID) >= 2;


-- Good Luck :)

