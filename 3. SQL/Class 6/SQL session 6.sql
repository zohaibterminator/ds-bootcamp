USE atomcamp;

SELECT *
FROM employee_dataset;

-- Common Table Expressions (CTE)
/*
WITH data_science AS (
	SELECT *
    FROM University
    WHERE department = "Data Science"
)
*/

-- Identify top three job roles among PhD holders
WITH PHD_HOLDERS AS (
	SELECT *
	FROM Employee_dataset
	WHERE Education = "PHD"
)

SELECT JobRole, COUNT(*) AS "Number of Employees"
FROM PHD_HOLDERS
GROUP BY JobRole
ORDER BY COUNT(*) DESC
LIMIT 3;

-- Identify the average monthly income by job role for employees that have left the company
WITH Prev_Employees AS (
	SELECT *
    FROM employee_dataset
    WHERE Attrition LIKE "yes"
)

SELECT JobRole, ROUND(AVG(MonthlyIncome), 3) AS "Average Monthly Income"
FROM Prev_Employees
GROUP BY JobRole;

-- Identify the percentage of employees who work overtime in each department
WITH OVERTIME_COUNT AS (
	SELECT Department, COUNT(*) AS OvertimeCount
    FROM employee_dataset
    WHERE Overtime = "Yes"
    GROUP BY Department
),

TOTAL_COUNT AS (
	SELECT Department, COUNT(*) AS TotaltimeCount
    FROM employee_dataset
    GROUP BY Department
)

SELECT o.department, o.OvertimeCount, t.TotaltimeCount, (o.OvertimeCount/(t.TotaltimeCount + o.OvertimeCount))*100 AS "Percentage of People Working Overtime"
FROM OVERTIME_COUNT o
JOIN TOTAL_COUNT t ON o.department=t.department;

-- What are the top 3 jobRoles with highest average JobSatisfaction for employees who travel frequently.
-- (hint: check who travels frequently and then find out top three on the basis of average job satisfaction.)
WITH TravelsFrequently AS (
	SELECT *
	FROM Employee_dataset
	WHERE BusinessTravel = "Travel_Frequently"
)

SELECT JobRole, AVG(JobSatisfaction) AS "Average Job Satisfaction"
FROM TravelsFrequently
GROUP BY JobRole
ORDER BY AVG(JobSatisfaction) DESC
LIMIT 3;

-- Window Functions
-- Over and Partition
-- Partition is basically Group By in Window function
SELECT customer_id, first_name, last_name, gender, COUNT(*) OVER (PARTITION BY gender) AS "Gender Count"
FROM customer;

-- Key Window Functions:
-- RANK
-- DENSE_RANK
-- LEAD
-- LAG()

-- Find the average salary of employees for each department and order
SELECT Employee_ID, Age, Department, MonthlyIncome, AVG(MonthlyIncome) OVER (PARTITION BY Department ORDER BY age)
FROM employee_dataset;

-- Find avg performance rating within each department
SELECT Employee_ID, Age, Department, Education, AVG(PerformanceRating) OVER (PARTITION BY Department)
FROM employee_dataset;

-- What is the running total of sales for each product
-- Running total is cumulative total
SELECT *, SUM(total_amount) OVER (PARTITION BY product_id ORDER BY purchase_date) AS "Running Total"
FROM purchase_history;

-- RANK()
-- Rank products by their price_per_unit (Expensive -> less)
SELECT *, RANK() OVER (ORDER BY price_per_unit ASC) AS "Price Rank", DENSE_RANK() OVER (ORDER BY price_per_unit ASC) AS "Dense Price Rank"
FROM products;

-- Rank product by their price_per_unit for each brand
SELECT *, RANK() OVER (PARTITION BY BRAND ORDER BY price_per_unit ASC) AS "Price Rank", DENSE_RANK() OVER (PARTITION BY BRAND ORDER BY price_per_unit ASC) AS "Dense Price Rank"
FROM products;

-- Rank employees by their monthly income

-- Row Number
-- In each department, who are the employees with the highest salaries, and how do they rank compared to others in their department
SELECT ROW_NUMBER() OVER (PARTITION BY department ORDER BY MonthlyIncome DESC), employee_id, department, MonthlyIncome, RANK() OVER (ORDER BY MonthlyIncome DESC)
FROM employee_dataset;

-- LEAD()
-- How can you retrieve each product's name along with the name of the next product within the same category
SELECT product_name, LEAD(product_name) OVER (PARTITION BY category) AS "Next Product Name", category
FROM products;

-- Interval between purchases in terms of days
SELECT customer_id, purchase_date, LEAD(purchase_date) OVER (PARTITION BY customer_id ORDER BY purchase_date ASC) AS "Next Purchase Date", DATEDIFF(LEAD(purchase_date) OVER (PARTITION BY customer_id ORDER BY purchase_date ASC), purchase_date) AS "Interval"
FROM purchase_history;

-- LAG
-- Calculate the monthly increase or decrease in quantity sold from purchase_history table
WITH MonthlySales(
	SELECT YEAR(purchase_date), MONTH(purchase_date), SUM(quantity) AS total_	uantity_sold, LAG(SUM(quantity), 1) OVER (ORDER BY YEAR(purchase_date), MONTH(purchase_date)) AS previous_quantity_sold
	FROM purchase_history
	GROUP BY YEAR(purchase_date), MONTH(purchase_date)
)

SELECT *,
	CASE
    WHEN total_quantity_sold > previous_quantity_sold THEN "Increasing"
    WHEN total_quantity_sold < previous_quantity_sold THEN "Decreasing"
    ELSE "Same"
    END "Quantity"
