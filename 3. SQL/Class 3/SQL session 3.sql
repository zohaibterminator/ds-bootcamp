USE users_record;

SELECT *
FROM university_students;

-- Convert the data type of enrollment date
ALTER TABLE university_students
MODIFY COLUMN EnrollmentDate DATE;

-- How many students are listed in this dataset
SELECT COUNT(StudentID) AS "Total Number of Students"
FROM university_students;

-- What is the average age of the students
SELECT ROUND(AVG(Age), 2) AS 'Average Age of Students'
FROM university_students;

-- What is the highest and minimum GPA
SELECT MAX(GPA) AS "Highest GPA", MIN(GPA) AS "Minimum GPA"
FROM university_students;

-- How many Majors are there
SELECT COUNT(DISTINCT Major) AS "Total Majors"
FROM university_students;

-- What is the highest GPA in the mathematics major
SELECT MAX(GPA) AS "Highest GPA in Mathematics Major"
FROM university_students
WHERE Major = 'Mathematics';

-- Identify the student with the lowest GPA in the Computer Science
SELECT StudentID
FROM university_students
WHERE Major = 'Computer Science'
ORDER BY GPA ASC
LIMIT 1;

-- Average GPA in all the majors
SELECT Major, ROUND(AVG(GPA), 2)
FROM university_students
GROUP BY Major;

-- Top 10 Female students in major Mathematics
SELECT StudentID, GPA
FROM university_students
WHERE Gender = 'Female' AND Major = "Mathematics"
ORDER BY GPA DESC
LIMIT 10;

-- Number of students in Physics major
SELECT COUNT(*) AS "Total Students in Physics major"
FROM university_students
WHERE Major = "Physics";

-- GROUP BY

-- How many students are enrolled in each major
SELECT Major, COUNT(*)
FROM university_students
GROUP BY Major;

-- Analyze the gender distribution
SELECT Gender, Count(*)
FROM university_students
GROUP BY Gender;

-- Check the age distribution
SELECT Age, COUNT(*)
FROM university_students
GROUP BY Age;

-- Identify the age with the higest number of students
SELECT Age, COUNT(*) AS "Total Students"
FROM university_students
GROUP BY Age
ORDER BY "Total Students" ASC
LIMIT 1;

-- How many students are there in each major grouped by gender
SELECT Major, Gender, COUNT(*)
FROM university_students
GROUP BY Major, Gender;

-- Calculate the average GPA and average age for each major
SELECT Major, ROUND(AVG(Age), 2), ROUND(AVG(GPA), 2)
FROM university_students
GROUP BY Major;

-- List down the number of enrollments in each year
SELECT YEAR(EnrollmentDate), COUNT(*)
FROM university_students
GROUP BY YEAR(EnrollmentDate);

-- Identify the major with the lowest number of female students who enrolled after 2018
SELECT Major, COUNT(*)
FROM university_students
WHERE Gender = 'Female' AND EnrollmentDate > "2018-12-31"
GROUP BY Major
ORDER BY COUNT(*) ASC
LIMIT 1;

-- HAVING
-- Find the majors where average gpa is greater than 3.0

SELECT Major, ROUND(AVG(GPA), 2)
FROM university_students
GROUP BY Major
HAVING ROUND(AVG(GPA), 2) > 3.00;

-- Find the avg GPA by major with more than 100 enrollments
SELECT Major, ROUND(AVG(GPA), 2) AS "Average GPA", COUNT(*) AS "Total Enrollments"
FROM university_students
GROUP BY Major
HAVING COUNT(*) > 100;

-- List the top 3 major with the highest average GPA among students aged 25 and above
SELECT Major, ROUND(AVG(GPA), 2)
FROM university_students
WHERE Age >= 25
GROUP BY Major
ORDER BY ROUND(AVG(GPA), 2) DESC
LIMIT 3;

-- Consider a scenario where you want to find Majors where the average GPA is higher than 3 and there are at least 50 students enrolled:

-- Conditional Statements
-- IF
-- Assign grades to students based on their GPA using the following guide
-- 'A+' for GPA > 3.5
-- 'A' for GPA > 3
-- 'B' for GPA > 2.5
-- 'C' for GPA > 2
-- 'F' for other GPAs
SELECT *, IF (GPA >= 3.5, "A+", 
				IF (GPA >= 3, 'A',
					IF (GPA >= 2.5, 'B', 'F'))) as GRADES
FROM university_students;

-- Calculate the total number of students whp are older than 25 and younger or equal to 25
SELECT SUM(IF(Age > 25, 1, 0)) AS OLDER_THAN_25, SUM(IF(Age <= 25, 1, 0)) AS YOUNGER_THAN_25
FROM university_students;

-- CASE
-- Same exercise as 1
SELECT *,
 CASE
	WHEN GPA >= 3.5 THEN 'A+',
    WHEN GPA >= 3 THEN'A',
    WHEN GPA >= 2.5 THEN'B',
    WHEN GPA >= 2 THEN 'C',
    ELSE 'F'
 END AS "Grades"
FROM university_students;

-- Write SQL query to categorize students based on there age and gender into the following categories
-- 'Adult Male' for males aged 21 and above
-- 'Young Male' for males younger than 21
-- 'Adult Female' for females aged 21 and above
-- 'Young Female' for females younger than 21

SELECT *,
 CASE
	WHEN Age >= 21 AND Gender = 'Male' THEN 'Adult Male'
    WHEN Age < 21 AND Gender = 'Male' THEN 'Young Male'
    WHEN Age >= 21 AND Gender = 'Female' THEN 'Adult Female'
    ELSE 'Young Female'
 END 'Age-Gender Group'
FROM university_students;

-- Group students by their majors and categorize their GPA into 'High' (>= 3.5), 'Medium' (2.5 - 3.49), and 'Low' (< 2.5).
SELECT 
    Major,
    COUNT(CASE
        WHEN GPA >= 3.5 THEN 1
    END) AS 'high',
	COUNT(CASE
        WHEN GPA between 2.5 and 3.49 THEN 1
    END) AS 'Medium',
    COUNT(CASE
        WHEN GPA < 2.5 THEN 1
    END) AS 'Low'
FROM university_students
GROUP BY Major;

-- Permanently add conditional column
-- 1. Add student_category column to the table
ALTER TABLE university_students
ADD COLUMN student_category VARCHAR(20);

UPDATE university_students
SET student_category = 
CASE
	WHEN GPA >= 3.5 THEN 'High'
	WHEN GPA BETWEEN 2.5 and 3.49 THEN 'Medium'
	ELSE 'Low'
END;

SET SAFE_