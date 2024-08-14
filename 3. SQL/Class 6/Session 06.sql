/* DS 7 
● CTE
● Window Functions
● Combine Result Query ( union, intersect, except)
*/


select Employee_ID from employee_dataset;



-- Common Table Expressions (CTEs) 
/*
● A Common Table Expression (CTE) is like a named subquery. It functions as a virtual table that only its main query can access. 
● CTEs can help simplify, shorten, and organize your code.
● Temporary result Table that can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement, 
*/

-- Common Table Expressions (CTEs)
-- WITH keyword
/*
WITH cte_name as (
	select column1, column2
		from  table_name
        )
select * from cte_name;



with data_science_data as (

	select * from univeristy
    where department = "Data Science"

)
select grade, count(*) from data_science_data group by grade;
*/

select * from employee_dataset;

-- Exercise: Idenitfy top three job roles among PHD holders.

with PHD_Holders as (
	select * from employee_dataset
    where Education = "PHD"
)
select JobRole,count(*) as Number_of_employees from PHD_holders
group by JobRole
order by Number_of_employees desc
limit 3;





-- Exercise: Identify the average monthly income by job role for employees who have left the company.
with Previous_employees as
(
select * from employee_dataset
where Attrition = "yes" 
)
select jobrole, avg(MonthlyIncome) as AverageMonthlyIncome 
from Previous_employees
group by jobrole;



-- Exercise: Identify the percentage of employees who work overtime in each department.

with OverTimeCounts as
(
select 
	Department, count(*) as OverTimeCount
    from employee_dataset
    where OverTime ="Yes"
    Group by Department
),
TotalCounts as
(
select 
	Department, count(*) as TotalCount
    from employee_dataset
    Group by Department
)
select o.Department, o.OverTimeCount, t.TotalCount, 
(o.OverTimeCount / t.TotalCount) * 100 as OverTimePercentage
from OverTimeCounts o
Join TotalCounts t
on o.Department = t.Department;

-- task
-- 1. What are the top 3 jobRoles with highest average JobSatisfaction for employees who travel frequently.
-- (hint: check who travels frequently and then find out top three on the basis of average job satisfaction.)


select * from customer;
select customer_id,first_name,last_name,gender, count(*) 
from customer
group by customer_id,first_name,last_name,gender;

select city, count(*)
from customer
group by city;

-- using window function
select customer_id,first_name,last_name,gender, city,
count(*) over (partition by city) as city_count
from customer;



-- Window Functions
-- It operates on a subset of rows, known as a window, within the result set of a query, allowing for calculations and analysis across data.
-- Over(): Syntax used to define the window frame for window functions, specifying the partitioning and ordering of rows.
-- PARTITION BY: Divides the result set into partitions to perform calculations separately within each partition or group.
-- Key Window Functions:
	-- RANK(): Assigns a rank to each row based on specified criteria.
	-- DENSE_RANK(): Similar to RANK() but assigns consecutive ranks without gaps.
	-- LEAD(): Accesses data from subsequent rows in the result set.
	-- LAG(): Accesses data from previous rows in the result set.
    

-- PARTITION BY

-- Exercise: Find average salary of employees for each department and order employees within a department by age. 
select Employee_ID, Age,Department, MonthlyIncome, 
avg(MonthlyIncome) over ( partition by department order by age)
as AVg_Salary
from employee_dataset;



-- Exercise:  Find the average performance rating within each department.
select employee_ID,Age,Department,Education,
avg(PerformanceRating) over (partition by Department) 
from employee_dataset;





-- Exercise: What is the running total of sales (RunningTotal_Sales) 
-- for each product (product_id) ordered by the purchase date.
select * ,
sum(total_amount) over ( partition by product_id order by purchase_date) as RunningTotalSales
from purchase_history;







/*
Ranking Window Functions : 
Ranking functions are, RANK(), DENSE_RANK(), ROW_NUMBER() 

RANK() – 
As the name suggests, the rank function assigns rank to all the rows within every partition. Rank is assigned such that rank 1 given to the first row and rows having same value are assigned same rank. For the next rank after two same rank values, one rank value will be skipped. For instance, if two rows share­ rank 1, the next row gets rank 3, not 2.
 
DENSE_RANK() – 
It assigns rank to each row within partition. Just like rank function first row is assigned rank 1 and rows having same value have same rank. The difference between RANK() and DENSE_RANK() is that in DENSE_RANK(), for the next rank after two same rank, consecutive integer is used, no rank is skipped. 
 
ROW_NUMBER() – 
ROW_NUMBER() gives e­ach row a unique number. It numbers rows from one­ to the total rows. The rows are put into groups base­d on their values. Each group is called a partition. In e­ach partition, rows get numbers one afte­r another. No two rows have the same­ number in a partition. This makes ROW_NUMBER() differe­nt from RANK() and DENSE_RANK(). ROW_NUMBER() uniquely identifies e­very row with a sequential inte­ger number. This helps with diffe­rent kinds of data analysis.
*/

-- Exercise: Rank products by their price_per unit (Exepensive -> less))
select  * ,
RANK() over (order by price_per_unit desc )as Price_rank,
DENSE_RANK() over (order by price_per_unit desc)as Price_Dense_rank
from products;


-- Exercise: Rank products by their price_per unit in each brand (Exepensive -> less)
select  * ,
RANK() over (partition by brand order by price_per_unit desc )as Price_rank,
DENSE_RANK() over (partition by brand  order by price_per_unit desc)as Price_Dense_rank
from products;


-- Exercise: Rank employees by their monthly income within each department.

-- Exercise: Rank employees by years at the company within each job role.



-- Row_number
-- Exercise: In each department, who are the employees with the highest salaries, and how do they rank compared to others in their department?
select 
row_number() over ( partition by department order by MonthlyIncome desc) as row_number_column,
employee_id, department, MonthlyIncome,
rank() over ( partition by department order by MonthlyIncome desc) as rank_MonthlyIncome,
DENSE_rank() over ( partition by department order by MonthlyIncome desc) as Dense_rank_MonthlyIncome
from employee_dataset;





-- LEAD() and LAG():

select * from products;



-- Exercise: How can you retrieve each product's name along with the name of the next product within the same category from the products table?
select product_name,
lead(product_name) over( partition by category) as next_product_name,
category
from products;

-- Exercise: Interval Between Purchases in terms of days
select * from purchase_history;
select customer_ID, purchase_date,
lead(purchase_date) over ( partition by customer_id order by purchase_date) as next_date,
datediff(lead(purchase_date) over ( partition by customer_id order by purchase_date), purchase_date) asdays_since_last_purchase
from purchase_history;


-- LAG():

-- Exercise: calculate the monthly increase or decrease in quantity sold from the purchase_history table.

with monthlySales as
( select 
Year(purchase_date) as sales_year, Month(purchase_date), 
sum(quantity) as total_quantity_sold, 
lag( sum(quantity), 1) over (order by Year(purchase_date), Month(purchase_date) )  as previous_month_quantity
from purchase_history
group by Year(purchase_date), Month(purchase_date) 

)
select  *,
case 
when total_quantity_sold > previous_month_quantity Then "Increase"
when total_quantity_sold < previous_month_quantity Then "Decrease"
Else NULL
END as quantity_change
from monthlySales;



-- Combine Result Query (UNION, INTERSECT, EXCEPT)

-- Create Students_Data table
CREATE TABLE Students_Data (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    student_department VARCHAR(50)
);

-- Create Event_organizers table
CREATE TABLE Event_organizers (
    organizer_id INT PRIMARY KEY,
    organizer_name VARCHAR(100),
    organizer_department VARCHAR(50)
);
-- Insert data into Students_Data table
INSERT INTO Students_Data (student_id, student_name, student_department)
VALUES
    (1, 'Ahmad', 'Software Engineering'),
    (2, 'Bilal', 'Data Science'),
    (3, 'Daniyal', 'Social Sciences'),
    (4 , 'Haris', 'Data Science'),
    (5, 'Imad', 'Computer Science');

-- Insert data into Event_organizers table
INSERT INTO Event_organizers (organizer_id, organizer_name, organizer_department)
VALUES
    (1, 'Aliyan', 'BBA'),
    (2, 'Ali', 'English'),
    (3, 'Daniyal', 'Social Sciences');
    

select * from Students_Data;
select * from Event_organizers;




-- Union
-- Combine all members whether they are Students or Event organizers
select student_name, student_department
from students_data
union
select organizer_name, organizer_department
from event_organizers;

-- Intersect
-- Find the common participants between the Students_Data and Event_organizers tables based on their names.
select student_name, student_department
from students_data
intersect
select organizer_name, organizer_department
from event_organizers;



-- Except 
-- Create a query that identifies students from the Students_Data table who are not organizers in the Event_organizers table.

select student_name, student_department
from students_data
Except
select organizer_name, organizer_department
from event_organizers;

