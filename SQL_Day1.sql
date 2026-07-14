-- SQL Tutorial 

-- SQL (Structured Query Language) is a language used to communicate with databases

-- A database stores information in an organized way

-- Create Database

CREATE DATABASE database1;

-- Create a Table 

CREATE TABLE Students(
    StudentID INT,
    Name VARCHAR(50),
    Age INT
);

-- Retrieve Data

SELECT * FROM students;

-- This displays all records from the Students table

-- Insert Data

INSERT INTO students
VALUES (4, 'Alisha', 22);

-- Update Data

UPDATE students
SET age = 23
WHERE id = 4

-- Delete Data

DELETE FROM Students
WHERE id = 4;


-- A table stores data in rows and columns

-- A row represents one complete record
-- A column represents one type of information -- Each column stores similar data


-- SQL Statement

-- An SQL statement is a command that tells the database what to do
-- SELECT * FROM Customers; -> This retrieves all data from the Customers table


-- SQL is Not Case Sensitive

SELECT * FROM Students;

Select * from students;

SeLecT * FrOm stUdents;

-- Semicolon (;) 
-- A semicolon marks the end of an SQL statement

SELECT * FROM Customers;

-- If multiple statements are written together: -- -- The semicolon separates them

SELECT * FROM Customers;
SELECT * FROM Orders;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT Statement

-- Syntax
SELECT column1, column2
FROM table_name;

SELECT name, department 
FROM employees;

-- SELECT *
-- The asterisk (*) means all columns

SELECT * FROM students;

-- Select DISTINCT

-- Sometimes a column contains duplicate values

-- Without DISTINCT

SELECT department FROM employees;  -- Duplicates are included

-- WITH DISTINCT

SELECT DISTINCT department FROM employees; --Only unique values are returned

-- COUNT(DISTINCT) -- Counts the number of unique values

SELECT COUNT(DISTINCT department) FROM employees; -- Unique Number of departments count

-- Count Without DISTINCT

SELECT COUNT(department) FROM employees; -- Number of departments count

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE Clause -- The WHERE clause filters records based on a condition

-- Syntax
SELECT *
FROM Customers
WHERE condition;

-- Example

SELECT *
From employees
Where department = 'IT';

-- Text vs Numeric Values

-- Text Values -- Text must be enclosed in single quotes

WHERE department = 'IT'

-- Numeric Values -- Numbers are not enclosed in quotes

WHERE id = 2

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SQL Operators 

-- 1. Equal(=)
SELECT *
From employees
Where id = 1;
-- return employees whose Id is 1

-- 2. Greater Than (>)
SELECT *
From employees
Where id > 2;
-- Returns all employees with IDs greater than 2

-- 3. Less Than (<)
SELECT *
From employees
Where id < 3;
-- Returns employees with IDs less than 3

-- 4. Greater Than or Equal (>=)
SELECT *
From students
Where age >= 19;
-- Returns students aged 19 or older

-- 5. Less Than or Equal (<=)
SELECT *
From students
Where age <= 19;
-- Returns students aged 19 or younger


-- 6. Not Equal (<>)
SELECT *
From students
Where department <> 'CS';
-- Returns students from departments other than CS


-- 7. BETWEEN  -- Used to select values within a range
SELECT *
From students
Where age BETWEEN 18 AND 25
-- Returns students whose age is between 18 and 25 (inclusive)


-- 8. LIKE -- Used to search for patterns
SELECT *
From students
Where Name LIKE 'A%';
-- A% means starts with the letter A


-- 9. IN  --  Used to match multiple values
SELECT *
From students
Where department IN ('IT', 'CS');
-- Returns students whose department is either CS or IT

-- Some of The Most Important SQL Commands

-- SELECT - extracts data from a database
-- UPDATE - updates data in a database
-- DELETE - deletes data from a database
-- INSERT INTO - inserts new data into a database
-- CREATE DATABASE - creates a new database
-- ALTER DATABASE - modifies a database
-- CREATE TABLE - creates a new table
-- ALTER TABLE - modifies a table
-- DROP TABLE - deletes a table
-- CREATE INDEX - creates an index (search key)
-- DROP INDEX - deletes an index

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--- Note: The COUNT(DISTINCT column_name) is not supported in Microsoft Access databases

-- MS ACCESS
SELECT Count(*) AS DistinctCountries
FROM (SELECT DISTINCT Country FROM Customers);



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SQL ORDER BY

-- The ORDER BY keyword is used to sort the data returned by a query

-- By default, SQL sorts data in Ascending (ASC) order

SELECT * FROM Students
ORDER BY Name;

-- Sorted from A → Z

-- Reverse Alphabetical Order

SELECT * FROM Students
ORDER BY Name DESC;

-- Sorted from Z → A

-- Descending Order (DESC)

SELECT * FROM Products
ORDER BY Price DESC;

-- Highest price → Lowest price



--- ORDER BY Multiple Columns

SELECT * 
FROM students
ORDER BY Name, Department;

--- SQL SORT -> First by name  -> Then, if two students have the same department, by department

-- Combine ASC and DESC
Select *
from students
ORDER BY Name ASC, department DESC;

--- Name is sorted A → Z, but names within each department are sorted Z → A

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--- SQL AND Operator'

-- The AND operator combines multiple conditions.
-- A record is returned only if ALL conditions are true

SELECT *
FROM students
WHERE department = 'IT'
AND city = 'Lahore';


SELECT *
FROM students
Where city = 'Lahore'
AND Name LIKE 'A%';

--Conditions:
--City must be Lahore
--Name must start with A


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SQL OR Operator

--The OR operator returns rows if at least one condition is true

SELECT *
FROM students
WHERE city = 'Lahore'
OR department = 'CS';

SELECT *
FROM students
Where department IN ('CS', 'IT')
OR Name LIKE 'A%';

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- AND -- Both conditions must be true
-- OR --  Only one condition needs to be true

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Combining AND and OR

SELECT *
From Customers
WHERE Country = 'Spain'
AND (Name Like 'A%'
OR Name LIKE 'Z%');

-- SQL first checks: -> Country = Spain
-- Then checks: -> Name starts with A OR Z

-- Parentheses make the logic clear

-- WIthout Parentheses

SELECT *
From Customers
WHERE Country = 'Spain'
AND Name Like 'A%'
OR Name LIKE 'Z%';

-- SQL interprets it differently, so records starting with A from any country may also be returned

-- Always use parentheses when mixing AND and OR

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SQL NOT Operator

-- The NOT operator reverses a condition 
-- Give me everything except...

SELECT *
FRom students
WHERE NOT department = 'IT'

-- Return all students except those from IT department


-- NOT LIKE

SELECT *
From students
where name NOT LIKE 'A%';

-- Returns students whose names do not start with A

--NOT BETWEEN

SELECT *
FROM students
WHERE age NOT BETWEEN 21 AND 34;

-- Returns students whose age are less than 21 or greater than 34

-- NOT IN

SELECT *
FROM students
WHERE department NOT IN ('IT', 'CS');

-- Returns students who are not from CS and IT department

-- NOT Greater Than

SELECT *
FROM students
WHERE NOT Age > 35;

-- Return students whose age less then or equal to 35

-- NOT Less Than

SELECT *
FROM students
WHERE NOT Age < 35;
-- Return students whose age greater then or equal to 35

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SQL INSERT INTO

-- The INSERT INTO statement is used to add new records to a table

-- Insert All Columns

INSERT INTO students
VALUES (3, 'Alisha', 22, 'CS', 'Lahore');
-- id, name, age, department, city


--- Insert Specific Columns

INSERT INTO students(Name, age)
VALUES('ali', 32);
-- The remaining columns will contain NULL or their default values


-- Insert Multiple Rows

INSERT INTO students(name, age)
VALUES
('ali', 23),
('zarmeen', 19),
('unknown', 10);

-- Three records are inserted at once

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--- SQL NULL Values

-- A NULL value means no value or missing data

-- It does not mean: 0 (zero) or '' (empty string)
-- It simply means the value is unknown or not provided

-- Why can't we use "=" with NULL?

-- wrong way:
SELECT *
FROM Students
WHERE Email = NULL;

-- It returns nothing because NULL is not considered a normal value

--- IS NULL 
-- Used to find records where a column has NULL

-- Syntax
SELECT column_name
FROM table_name
where column_name IS NULL;

-- Example
SELECT *
FROM students
WHERE name IS NULL;

--- IS NOT NULL
-- Used to find records that contain a value

SELECT *
FROM students
WHERE email IS NOT NULL;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--- SQL UPDATE Statement

-- The UPDATE statement is used to modify existing data in a table

-- Syntax
UPDATE table_name
SET column1 = value1,
    column2 = value2
WHERE condition;

--- Example

UPDATE students
SET department = 'CS'
WHERE name = 'ali';

-- Update Multiple Columns 

UPDATE students
SET name = 'alisha',
    city = 'Sahiwal'
Where id = 1;
-- Both Name and City are updated -> of id 1 student


-- Update Multiple Rows

UPDATE students
SET department = 'IT'
WHERE city = 'Lahore';

-- Department of All students from Lahore are updated

-- Important Warning 
-- If WHERE clause is forget: -> all records are updated

UPDATE students
SET city = 'Lahore';

-- City of all students -> updated

------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--- SQL DELETE Statement
--  DELETE removes records (rows) from a table

-- Syntax
DELETE FROM table_name
WHERE Condition;

-- Example
DELETE FROM students
WHERE id = 4;

-- Delete Multiple Rows
DELETE FROM students
WHERE department = 'CS';

-- delete every student from CS

--- Delete All Records

DELETE FROM students;
-- The table still exists, but it is empty

---- DELETE vs DROP TABLE

DELETE FROM employees;
-- Removes all rows -> Table remains

DROP TABLE employees;
-- Deletes: Table, Data, Structure -> The table no longer exists

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--- SQL SELECT TOP / LIMIT / FETCH FIRST

-- These keywords limit the number of rows returned.
--Different databases use different keywords

-- Database	     Keyword
    SQL Server	  TOP
    MySQL	     LIMIT
    Oracle	    FETCH FIRST

--- SQL SERVER

SELECT TOP 3 *
FROM students;
-- Returns the first 3 rows


--- MySQL 

SELECT *
FROM students
LIMIT 3;
-- Same Result -> Returns the first 3 rows


--- Oracle 

SELECT * F
FROM students
FETCH FIRST 3 ROWS ONlY;
-- Same Result -> Returns the first 3 rows

--- Limit with WHERE

SELECT *
FROM students
WHERE department = 'CS'
LIMIT 5;
-- Return the first 5 students from CS


--- Limit with ORDER BY

SELECT *
FROM students
ORDER BY Age DESC
LIMIT 6;
-- Return 6 most older students

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--- SQL Aggregate Functions

-- Aggregate functions perform calculations on multiple rows and return one result


-- 1. MIN()
-- Returns the smallest value

SELECT MIN(Age)
FROM students;

-- Return most younger age

-- 2. MAX()
-- Returns the largest value

SELECT MAX(Age)
FROM students

-- Return the most older age


-- 3. COUNT()
-- Count the number of rows

SELECT COUNT(*)
FROM students;
-- return number of all students

-- Count Students FROM CS

SELECT COUNT(*)
FROM students
WHERE department = 'CS';
-- return number of students from CS department

-- 4. SUM()
-- ADD all numeric values

SELECT SUM(Price)
FROM Products;
-- Return the total price of all products

-- 5. AVG()
-- Return the average

SELECT AVG(Price)
FROM Products;

--- Aggregate Functions Ignore NULL

SELECT AVG(Marks)
FROM Students;

-- SQL ignores the NULL value

-- Calculation -> (80 + 90 + 70) / 3 = 80
-- Not ->  (80 + 90 + 0 + 70) / 4

-- Only COUNT(*) counts every row, including rows that contain NULL values in some columns.


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





