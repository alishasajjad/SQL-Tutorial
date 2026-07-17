---------------------------------------------------

-- SQL Tutorial - Day 4

----------------------------------------------------

-- PRIMARY KEY

-- A PRIMARY KEY is a column (or group of columns) that uniquely identifies each row in a table

-- Think of it as a person's CNIC, Every citizen has a unique CNIC
--Similarly, every row should have a unique ID

-- Example

Students Table

StudentID	Name	Age
1	        Ali     20
2	        Alisha	21
3	        Ahmed	19

-- StudentID is the PRIMARY KEY
-- No two students can have the same StudentID

-- Rules of PRIMARY KEY

--A Primary Key:
---- Must be unique
---- Cannot be NULL
---- Only ONE Primary Key per table
---- Automatically behaves like UNIQUE + NOT NULL

-- PRIMARY KEY = UNIQUE + NOT NULL

---------------------------------------------------------

-- Creating a PRIMARY KEY

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);


---------------------------------------------------------

-- Valid Inserts

INSERT INTO Students
VALUES(1, "ali", 23);

INSERT INTO Students
VALUES(2, "alisha" ,21);


---------------------------------------------------------

-- Invalid (Duplicate)

INSERT INTO Students
VALUES (1,'Ahmed',19);

-- Because StudentID = 1 already exists


-- Invalid (NULL)

INSERT INTO Students
VALUES (NULL,'Ali',20);

-- Error -> Primary Key cannot be NUL


------------------------------------------------------------

-- Composite PRIMARY KEY

-- Sometimes one column isn't enough

-- Example

StudentID	CourseID
    1	       CS101
    1	       CS102
    2	       CS101

-- Here StudentID repeats
-- CourseID repeats

-- But together
(StudentID, CourseID)  -- is always unique


PRIMARY KEY(StudentID, CourseID)

-- This is called a Composite Primary Key

------------------------------------------------------------

-- FOREIGN KEY

-- This is probably the most important concept in relational databases

-- A FOREIGN KEY creates a relationship between two tables

-- It tells SQL: "This value must already exist in another table


-- Example

-- Students Table (Parent)

StudentID	Name
    1	    Ali
    2	    Alisha

-- StudentID is PRIMARY KEY

-- Orders Table (Child)

OrderID	StudentID
    101     1
    102	    2

-- StudentID here is a FOREIGN KEY

--- The Foreign Key always points to a Primary Key

--------------------------------------------------------------

-- Creating a FOREIGN KEY

CREATE TABLE Orders(
    OrderID INT PRIMARY KEY,
    StudentID INT,

    FOREIGN KEY(StudentID) REFERENCES Students(StudentID)
);

---------------------------------------------------------

-- Valid Insert

INSERT INTO Orders
VALUES(101,2);

-- Works -> Because StudentID 2 exists

-----------------------------------------------------------

-- Invalid Insert

INSERT INTO Orders
VALUES (101, 8);

-- Error -> Student 8 doesn't exist

----------------------------------------------------------

-- Prevents Deleting Parent Data

DELETE FROM Students
WHERE StudentID = 1;

-- Error -> Because Orders still refers to StudentID = 1

-- This prevents broken relationships


--------------------------------------------------------

-- PRIMARY KEY	                 FOREIGN KEY
-- Uniquely identifies a row	Refers to another table's Primary Key
-- Only one per table	        Many Foreign Keys allowed
-- Cannot be NULL	            Can be NULL (unless specified NOT NULL)
-- Must be unique	            Duplicates are allowed

--------------------------------------------------------------


-- CHECK Constraint

-- Restricts values using a condition

-- Example
-- Age should never be less than 18

--Instead of trusting users,
--SQL checks it automatically

-- Example Query
CREATE TABLE Students(
    ID INT PRIMARY KEY,
    Age INT CHECK(Age>=18)
);

-----------------------------------------------------------

-- Valid

INSERT INTO Students
VALUES(1,20);

-------------------------------------------------------------

-- Invalid

INSERT INTO Students
VALUES(3,15);

-- ERROR -> 15 >= 18 -> False

-------------------------------------------------------------

-- Example

CREATE TABLE Students(
    ID INT PRIMARY KEY,
    Age INT CHECK(Age>=18),
    Marks INT CHECK(Marks BETWEEN 0 AND 100)
);


-----------------------------------------------------------

-- Example

CREATE TABLE Employees(
    ID INT PRIMARY KEY,
    Age INT CHECK(Age>=18),
    Name VARCHAR(100) NOT NULL,
    Salary FLOAT CHECK(Salary > 0)
);

----------------------------------------------------------

-- Example

CREATE TABLE Orders(
    ID INT PRIMARY KEY,
    Quantity INT CHECK(Quantity >= 1)
);

------------------------------------------------------------

-- DEFAULT Constraint

-- Provides a default value when the user doesn't supply one

------------------------------------------------------------

-- Without DEFAULT Example

-- Create Table

CREATE TABLE Students(
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    City VARCHAR(20)
);

-- INSERT VALUES

INSERT INTO Students(Name)
VALUES ('Ali');

-- City becomes -> NULL

-----------------------------------------------------------

-- With DEFAULT Example

CREATE TABLE Students(
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    City VARCHAR(20)
    DEFAULT 'Lahore'
);

-- Insert Values

INSERT INTO Students(Name)
VALUES ('Ali');

-- SQL inserted Lahore automatically


------------------------------------------------------------

-- Example

-- Automatically store today's date

CREATE TABLE Orders(
    ID INT PRIMARY KEY,
    OrderDate DATE
    DEFAULT CURRENT_DATE
);

-- Now every new order automatically gets today's date

-------------------------------------------------------------------

-- CREATE INDEX

-- Why do we need Indexes?

--Imagine a book -> Without index -> search page by page -> Very slow

-- With index -> Go directly to the page -> Much faster

-- Database indexes work exactly the same


-- Without Index Search a Student FRom Database -> Database checks all rows(all students) -> slow

-- With Index -> Database jumps directly to Search student -> Very fast



-- Create Index

CREATE INDEX idx_name
ON Students(Name);

-- Now searching by Name becomes faster



-- Unique Index
CREATE UNION INDEX idx_email
ON Students(Email);

-- Now Email must also be unique

------------------------------------------------------------------

-- Drawback

-- Indexes improve SELECT performance

-- But
INSERT
UPDATE
DELETE
-- become slightly slower because SQL must update the index too

-- So only create indexes on columns that are searched frequently


-----------------------------------------------------------------------------

--- AUTO_INCREMENT

-- Normally 

INSERT INTO Students
VALUES(?,?,?)

--must manually write -> id's
1
2
3
4
-- Very annoying 

----------------------------------------------------------------------------

-- AUTO_INCREMENT solves this

-- Example

CREATE TABLE Students(
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(30)
);

---------------------------

INSERT INTO Students(Name)
VALUES('Ali');

--Database stores

-- StudentID	Name
    1	        Ali


INSERT INTO Students(Name)
VALUES('Alisha');

--Database stores

-- StudentID	Name
    2	        Alisha

-- SQL automatically generates IDs

-------------------------------------------------------------------------

-- SQL Server

--- Instead of AUTO_INCREMENT

IDENTITY(1,1)
-- means -> Start from 1, Increase by 1

--- Example

CREATE TABLE Students(
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(30)
);


-------------------------------------------------------------------------------

-- Example 

CREATE TABLE Students(
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Age INT CHECK(Age >= 18),
    City VARCHAR(100) DEFAULT 'Lahore'
);

--
---AUTO_INCREMENT → StudentID is generated automatically
---PRIMARY KEY → StudentID is unique and cannot be NULL
---NOT NULL → Name is required
---UNIQUE → No two students can have the same Email
---CHECK → Age must be at least 18
---DEFAULT → If City isn't provided, it becomes "Lahore" automatically


-------------------------------------------------------------------------------------

--- SQL Working With Dates

-- A date stores calendar information such as:
Year
Month
Day

-- Example:

2025-11-11
-- Some data types also store time

--Example:

2025-11-11 13:23:44

-- Common Date Data Types

--  Data Type	   Stores
--  DATE	     Only date
--  TIME	     Only time
--  DATETIME	 Date + Time
--  TIMESTAMP	 Date + Time
--  YEAR	      Only year


-- Example:

2025-07-17
14:30:45
2025-07-17 14:30:45


-- Selecting a Date

-- Orders Table

-- OrderID	Product	    OrderDate
    1	     Laptop	    2025-11-11
    2	      Mouse	    2025-11-09

-- Query

SELECT * 
FROM Orders
WHERE OrderDate = '2025-11-09';

-------------------------------------------------------------------------------

-- Problem with DateTime

-- Suppose table contains
2025-11-11 10:30:15

-- Query Write

SELECT * 
FROM Orders
WHERE OrderDate = '2025-11-11';

--  Result -> No Rows

-- Because SQL compares
2025-11-11 with 2025-11-11 10:30:15
--They are not exactly equal

-- Remember
-- Use DATE when possible
-- -> Only use DATETIME if time is important

----------------------------------------------------------------------------------------

--- SQL Views

-- A View is a virtual table

-- It does not store data -> Instead, it stores a SELECT query

-- Table
--  ↓
-- SELECT Query
--  ↓
-- View

---- Why use Views?

-- Instead of writing this every day

SELECT Name, City
FROM Customers 
WHERE Country = 'Pakistan';

-- Create a View once

------ Create View

CREATE VIEW PakistanCustomers AS
SELECT Name, ContactName
FROM Customers
WHERE Country = 'Pakistan';

----------- Use View

SELECT * 
FROM PakistanCustomers;

-- Same output every time



----------- Update View

-- SQL Server 
ALTER VIEW PakistanCustomers AS
SELECT Name, ContactName, City
FROM Customer
WHERE Country = 'Pakistan';

------------- Delete View

DROP VIEW PakistanCustomers;

--------------------

-- Remember

--  View:
---     -> Saves SQL queries
---     -> Simplifies complex queries
---     -> Shows latest data automatically

-----------------------------------------------------------------------------------

-- SQL Injection

-- This is one of the most important security topics

-- Suppose website login uses

SELECT * 
FROM Users
WHERE UserName = 'Ali'
AND Password = '123';

-- Looks fine

--------------------------

--- Hacker Input

-- Instead of username : Ali

-- Hacker enters -> ' OR 1=1 -- 

-- SQL Becomes

SELECT *  
FROM Users
WHERE Username = ''
OR 1 = 1

-- Since 1=1 -> is always TRUE,
-- -> SQL returns -> ALL USERS
-- The hacker logs in

------------------------------------------------------- 

-- Example

-- User enters 105 OR 1=1

-- SQL Becomes

SELECT *
FROM Users
WHERE UserId = 105
OR 1 = 1;

-- Again -> Everything is returned

-- Even Worse 
105;
DROP TABLE Users;

-- if allowed,

-- SQL Executes

SELECT *
FROM Users;

DROP TABLE Users;

--The table is deleted

-- SQL Injection Summary

---- Bad user input
--       ↓
----- Changes SQL query
--       ↓
----- Reads or deletes database


--------------------------------------------------------------------------

--- SQL Parameters

-- How do we stop SQL Injection? -> Use Parameters

-- Instead of

SELECT *
FROM Users
WHERE userID =" + userInput


-- " -- ----
-- Use 

SELECT *
FROM Users
WHERE UserID = @userid;

-- Then
@userid
-- gets the value safely

-- Even if user enters -> 1 OR 1=1

----SQL treats it as plain text
----No injection

-- Example 

SELECT *
FROM Users
WHERE Name = @name;

-- Application sends 
@name = "Ali"
-- Safe

----------------------------------------------------------------------------------------------------

-- Prepared Statements

-- Prepared Statements work like Parameters

-- Process

-- Step1 -> Prepare SQL

INSERT INTO Students
VALUES(?,?,?);

-- Question marks are placeholders

-- Step2 -> Later provide values
-- Alisha
-- 22
-- Lahore
-----> Database safely inserts them

-- Advantages: Faster, Reusable, Prevent SQL Injection, Cleaner code

-------------------------------------------

-- Example

INSERT INTO Students
VALUES(?,?,?);

-- Later

-- ?
Ali
-- ?
22
-- ?
Lahore

---------------------------------------------------------------------------------

-- SQL Hosting

--- Hosting means -> Where your database lives

Website
↓
Database Server
↓
MySQL

---- or ----

SQL Server

Oracle

PostgreSQL

--- Popular Databases

-- MySQL: Fast, Free, Very popular
-- SQL Server: Microsoft, Enterprise applications, Strong security
-- Oracle: Very powerful, Large companies, Expensive
-- PostgreSQL: Free, Open Source, Advanced features


------------------------------------------------------------------------------------------------------------------------------------


