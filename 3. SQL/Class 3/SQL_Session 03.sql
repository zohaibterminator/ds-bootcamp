/* 
- Aggregation
- GROUP BY
- HAVING 
- Conditional Statements
- CASE


1. Aggregation: Aggregation is about combining multiple rows of data to return a single result or Summarize the data.
Example: Using functions like SUM, AVG, MIN, MAX to calculate totals, averages.

2. GROUP BY: Organize rows with similar values in one or more columns into summary rows. It group rows together based on common attributes.
Example: If you want to find the total sales for each product category, you'd use GROUP BY on the "category" column.

3. HAVING : It is like WHERE but for groups; it filters grouped data based on conditions.
Example: If you want to see only product categories with total sales greater than 1000, you'd use HAVING.
-- Where:  is to apply filter on the whole dataset.
-- Having: Applying filter on Groups 


4. Conditional Statements: These are used to perform different actions based on whether a condition is true or false.
Example: Using IF or CASE statements to make decisions in SQL based on specific conditions.

5. CASE: CASE is a conditional statement used to create different outputs based on different conditions.
Example: Assigning different labels based on sales figures: "High," "Medium," "Low" using CASE.


In simple terms, imagine you have a class of students (rows in a table) with columns like "Name," "Gender," and "Score." 
Aggregation would be finding the average score for the entire class. 
GROUP BY would be organizing students based on their Gender. or counting the ditribution gender wise
HAVING would be filtering out the gender wise distribution below a certain value. 
Conditional statements and CASE would be used to Grade students based on their scores, like "A","B", etc.

*/

-- Select database
use users_record;

-- Show the table
select * from university_students_dataset;

-- check the data types 
alter table university_students_dataset
modify column EnrollmentDate date;


-- Aggregation
-- Exercise 1: How many students are listed in this dataset.
select count(StudentID) as "Total number of students" from university_students_dataset;

-- Exercise 2: what is the average age of student
select avg(age) as "Average Age" from university_students_dataset;

-- round off 
select round(avg(age)) as "Average Age" from university_students_dataset;


-- Exercise 3: What is the highest GPA and minimum gpa
select max(gpa) as "Highest GPA" from university_students_dataset;
select min(gpa) as "Lowest GPA" from university_students_dataset;

select max(gpa) as "Highest GPA", min(gpa) as "Lowest GPA"  from university_students_dataset;

-- Exercise 4: How many majors are there?

-- unique majors
select * from university_students_dataset;
select distinct major from university_students_dataset;

select count(distinct major) as Total_Majors from university_students_dataset;

-- Exercise 5: what is the highest gpa in major mathematics
select max(gpa) from university_students_dataset
where Major = "mathematics";


-- Exercise 6: Identify the student with the lowest GPA in the Computer Science major.
select * from university_students_dataset
where major = "computer science"
order by gpa asc
limit 1;





-- Group by
select distinct major from university_students_dataset;
select * from university_students_dataset;

-- Exercise 1: How many students are enrolled in each major?
select * from university_students_dataset;

select major, count(*) from university_students_dataset
group by major;

-- select  column_for_grouping, aggregated_function  
-- from table_name
-- group by column_for_grouping;


-- Exercise 2: Analyze the gender distribution
select gender, count(*) 
from university_students_dataset
group by gender;

-- columns specified after select and before aggregated function => MUST be written after group by
-- columns specified in group by => optional to write it in select



-- Exercise 3: Check the age distribution or How many students are there for each age?
select age, count(*)
from university_students_dataset
group by age;

-- Exercise 4: Identify the age with the highest number of students.
select age, count(*) as Total_Students
from university_students_dataset
group by age
order by Total_Students desc
limit 1;

-- Exercise 5: How many students are there in each major, grouped by gender.
select major, gender, count(*)
from university_students_dataset
group by major, gender;

-- Exercise 6: Calculate the average age, average gpa per major
select major, avg(age), avg(gpa)
from university_students_dataset
group by major;


-- Exercise 7: List down number of enrollments in each year
select YEAR(EnrollmentDate) from university_students_dataset;

select YEAR(EnrollmentDate), count(*) 
from university_students_dataset
group by YEAR(EnrollmentDate);



-- Exercise 8: Identify the Major with the lowest number of female students who enrolled after 2018.
-- major identify
-- where female and enrollment > 2018


select * from university_students_dataset
where gender = "Female" and EnrollmentDate > "2018-12-31";


select major, count(*)
from university_students_dataset
where gender = "Female" and EnrollmentDate > "2018-12-31"
group by major
order by count(*)
limit 1;

-- complete dataset => filter using where => group by => ordery by => limit
-- complete dataset => filter using where => group by => having => ordery by => limit


-- HAVING 
-- Exercise 1: Find the majors where the average GPA is greater than 3.0.
select major, avg(gpa) as Average_GPA
from university_students_dataset
group by major
having avg(gpa) > 3.0;

-- Exercise 2: Find the average GPA by Major for students with more than 100 enrollments.
select major,count(*), avg(gpa) as AverageGPA
from university_students_dataset
group by Major
having count(*) > 100;



-- Exercise 3: List the top 3 Majors with the highest average GPA among students aged 25 and above.
-- age >= 25
select major, avg(gpa) as AverageGPA
from university_students_dataset
where age >= 25
group by major
order by AverageGPA desc
limit 3;


-- Exercise 4: Consider a scenario where you want to find Majors where the average GPA is higher than 3 and there are at least 50 students enrolled:




-- Conditional Expressions 
-- IF
-- Exercise 1: Assign grades to students based on their GPA using the following criteria:
-- 'A+' for GPAs greater than 3.5,
-- 'A' for GPAs greater than 3,
-- 'B' for GPAs greater than 2.5,
-- 'C' for GPAs greater than 2,
-- 'F' for Fail or all other GPAs.

SELECT 
    *,
    IF(GPA >= 3.5,
        'A+',
        IF(gpa >= 3,
            'A',
            IF(gpa >= 2.5,
                'B',
                IF(gpa >= 2, 'C', 'F')))) AS grades
FROM
    university_students_dataset;





-- Exercise 2: Calculate the total number of students who are older than 25 and younger or equal to 25.
-- <=25    -- >25
SELECT 
    age,
    IF(age > 25, 1, 0) AS older_than_25,
    IF(age <= 25, 1, 0) AS younger_or_equal_than_25
FROM
    university_students_dataset; 

SELECT 
    IF(age > 25, 1, 0) AS older_than_25,count(*)
FROM
    university_students_dataset
    group by older_than_25; 


SELECT 
    sum(IF(age > 25, 1, 0)) AS older_than_25,
    sum(IF(age <= 25, 1, 0)) AS younger_or_equal_than_25
FROM
    university_students_dataset; 


    
-- CASE
-- Exercise 1: Assign grades to students based on their GPA using the following criteria:
-- 'A+' for GPAs greater than 3.5,
-- 'A' for GPAs greater than 3,
-- 'B' for GPAs greater than 2.5,
-- 'C' for GPAs greater than 2,
-- 'F' for Fail or all other GPAs.

SELECT 
    *,
    CASE
        WHEN gpa > 3.5 THEN 'A+'
        WHEN gpa > 3 THEN 'A'
        WHEN gpa > 2.5 THEN 'B'
        WHEN gpa > 2 THEN 'C'
        ELSE 'F'
    END AS 'Grades'
FROM
    university_students_dataset;



-- Exercise 2: Write a SQL query to categorize students based on their age and gender into the following groups:
-- 'Adult Male' for males aged 21 and above,
-- 'Young Male' for males younger than 21,
-- 'Adult Female' for females aged 21 and above,
-- 'Young Female' for females younger than 21.
select * , 
case
 when gender="Male" and Age >=21 Then 'Adult Male' 
  when gender="Male" and Age <21 Then 'Young Male' 
 when gender="Female" and Age >=21 Then 'Adult Female'
 when gender="Female" and Age <21 Then 'Young Female'
 end as "Age_gender_Group"
 from university_students_dataset;



-- Exercise 3: Group students by their majors and categorize their GPA into 'High' (>= 3.5), 'Medium' (2.5 - 3.49), and 'Low' (< 2.5).
-- Exercise 3: Group students by their majors and categorize their GPA into 'High' (>= 3.5), 'Medium' (2.5 - 3.49), and 'Low' (< 2.5).
SELECT 
    major,
    COUNT(CASE
        WHEN gpa >= 3.5 THEN 1
    END) AS high,
COUNT(CASE
        WHEN gpa between 2.5 and 3.49 THEN 1
    END) AS Medium,
    COUNT(CASE
        WHEN gpa < 2.5 THEN 1
    END) AS Low
from university_students_dataset
group by major;




-- Permanently Add Conditional Column
-- 1. Add student_category column to the table
alter table university_students_dataset
add column student_category varchar(10);

-- 2. update the values using case statements
set sql_Safe_updates = 0; 

update university_students_dataset
set student_category = 
case
	WHEN gpa >= 3.5 THEN "High"
    WHEN gpa between 2.5 and 3.49 THEN "Medium"
    Else "low"
    end;
    
    select * from university_students_dataset;
