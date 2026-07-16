-----------------------------------------------

-- SQL Tutorial Day 3 

-----------------------------------------------

-- SQL GROUP BY

-- GROUP BY is used to group rows that have the same value into one group

-- It is mostly used with aggregate functions like

COUNT()
SUM()
AVG()
MIN()
MAX()

-- Syntax

SELECT column_name, aggregate_function(column_name)
FROM table_name
GROUP BY column_name;

-- Example

SELECT Country, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country;

-- GROUP BY makes groups
-- Then COUNT() counts customers inside each group

------------------------------------------------------------

-- GROUP BY with SUM()

SELECT Category, SUM(Price)
FROM Products
GROUP BY Category;

-----------------------------------------------------------

-- GROUP BY with ORDER BY

SELECT Country, COUNT(*) AS Total
FROM Customers
GROUP BY Country
ORDER BY TOTAL DESC;

-- Countries are sorted from highest count to lowest

------------------------------------------------------------------------------------




-- SQL HAVING

-- HAVING filters groups after GROUP BY

-- WHERE → filters rows
-- HAVING → filters groups

-- Example

SELECT Country, COUNT(*) AS Total
FROM Customers
GROUP BY Country
HAVING COUNT(*) > 5;

-- Show only countries that have more than 5 customers

-- WHERE vs HAVING

--WHERE	                                  HAVING
-- Filters rows	                    Filters groups
-- Used before GROUP BY	            Used after GROUP BY
-- Cannot use aggregate functions	Can use aggregate functions


-- Example -- WhERE

SELECT * 
FROM Customers
WHERE Country = 'Pakistan';

-- Returns only Pakistani customers

-- Example -- HAVING

SELECT Country, COUNT(*)
FROM Customers
GROUP BY Country
HAVING COUNT(*) > 5;

-- Returns only countries having more than 5 customers


-------------------------------------------------------------------------------------------------


-- SQL EXISTS

-- EXISTS checks whether a subquery returns at least one row

-- If yes → TRUE
-- If no → FALSE

-- Syntax
SELECT column
FROM table
WHERE EXISTS
(
    subquery
);

-- Example

-- Suppliers

-- SupplierID	Name
--         1	ABC
--         2	XYZ

-- Products

-- SupplierID	Price
--    1         	5
--    2	           20

SELECT SupplierName 
FROM Suppliers
WHERE EXISTS
(
SELECT * 
FROM Products
WHERE Products.SupplierId = Suppliers.SupplierId
AND Price < 10
);

-- Output : ABC
-- Because only supplier ABC has a product cheaper than 10

-- EXISTS = Does at least one record exist?

--------------------------------------------------------------------------------------------------------------

-- SQL ANY

-- ANY returns TRUE if at least one value from the subquery satisfies the condition

-- ANY = At least one

-- Example

SELECT ProductName
FROM Products
WHERE ProductID = ANY
(
SELECT ProductID
FROM OrderDetails
WHERE Quantity = 10
);

-- Show products whose ProductID matches any ProductID returned by the subquery

-- Subquery Return : 2,5,9
-- Main Query : WHERE ProductID = ANY (2,5,9)

-- Equivalent to:
---WHERE ProductID=2
---OR ProductID=5
---OR ProductID=9

----------------------------------------------------------------------------------------------------------------------


-- SQL ALL

-- ALL returns TRUE only if every value from the subquery satisfies the condition

-- ALL = Every value

-- Example

SELECT ProductName
FROM Products
WHERE ProductID > ALL
(
SELECT ProductID
FROM OrderDetails
WHERE Quantity = 10
);

-- WHERE ProductID > ALL ( 2,5,9 )
-- ProductID >2 AND ProductID >5 AND ProductID >9

-- So only ProductIDs greater than 9 will be selected

--   ANY	               ALL
-- At least one value	 Every value
-- Similar to OR	     Similar to AND

------------------------------------------------------------------------------------------------------------------------------

-- SQL SELECT INTO

-- SELECT INTO creates a new table and copies data from an existing table

-- Syntax

SELECT *
INTO NewTable
FROM OldTable;

-- Example 

SELECT *
INTO CustomersBackup
FROM Customers;

-- This creates a new table: CustomersBackup
-- and copies all customer records into it

--- ------------------------------------------------------

-- Copy only selected columns

SELECT CustomerName, ContactName
INTO Customer2
FROM Customers;

-- Only these two columns are copied

-------------------------------------------------------------

-- Copy with condition

SELECT *
INTO Pakistan_Customers
FROM Customers
WHERE Country = 'Pakistan';

-- Only Pakistan Customers are Copied

----------------------------------------------------------------------------

-- Create an Empty Table

SELECT *
INTO NewTable
FROM Customers
WHERE 1 = 0;

-- Since 1=0 is always false:
--Table is created
--No data is copied

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--- SQL INSERT INTO SELECT

-- INSERT INTO SELECT copies data from one existing table into another existing table

-- Source table = where data comes from
-- Target table = where data is inserted

-- Unlike SELECT INTO, this does not create a new table

-- Syntax

INSERT INTO target_table
SELECT * FROM source_table;

-- Example

INSERT INTO Customers(CustomerName, City, Country)
SELECT SupplierName, City, Country
FROM suppliers;

-- Condition

INSERT INTO Customers(CustomerName, City, Country)
SELECT SupplierName, City, Country
FROM suppliers
WHERE Country = 'Pakistan';

-- Only Pakistan Records will be copied


-- Examples

-- SELECT INTO : Creates a new table

SELECT * INTO BackupCustomers
FROM Customers;


-- INSERT INTO SELECT : Copies data into an existing table

INSERT INTO BackupCustomers
SELECT *
FROM Customers;


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SQL CASE 

-- CASE works like if-else

-- Syntax

CASE 
WHEN condition THEN result
WHEN condition THEN result
ELSE result
END

-- Query

SELECT ProductName, Price,
CASE 
    WHEN Price < 20 THEN 'Cheap'
    WHEN Price <=100 THEN 'Medium'  
    ELSE  'Expensive'
END AS Category
FROM Products;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SQL NULL Functions

---NULL means : Missing value
-- Not 0
-- Not empty string
-- Unknown

---Example

-- Product	Stock	Ordered
--     Milk	  20	NULL

-- Stock + Ordered -> becomes -> 20 + NULL = NULL
-- Not 20

--------------------------------------------------

-- COALESCE() 
-- Most Common Function

COALESCE(value,replacement)

-- Example

SELECT 
Price*(Stock+COALESCE(Ordered,0))
FROM Products;

-- If Ordered is NULL -> replace it with 0

-------------------------------------------------------

-- MySQL -- Syntax
IFNULL(Ordered,0)

-- SQL Server -- Syntax
ISNULL(Ordered,0)

-- Oracle -- Syntax
NVL(Ordered,0)

-- All do the same thing

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Stored Procedure

-- A Stored Procedure is a saved SQL query
-- Instead of writing the same query repeatedly, save it once

-- Example 

--- Without procedure
SELECT *
FROM Customers
WHERE City = 'Lahore';

-- Write again...
---Again...
---Again...

--- With Procedure

CREATE PROCEDURE GetCustomers
AS
BEGIN
SELECT *
FROM Customers;
END;

-- Run Anytime

EXEC GetCustomers;

--------------------------------------------------------

-- Procedure with parameter
CREATE PROCEDURE GetCustomer
@City nvarchar(50)
AS
BEGIN

SELECT *
FROM Customers
WHERE City = @City;

END;


-- Execute

EXEC GetCustomers @City = 'Lahore';

-- Return Only Lahore Customers

---- Benefits : Faster, Reusable, More secure, Easier maintenance

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SQL Comments

-- Comments are ignored by SQL
-- Used for explanation

-- Single Line Comment (--)

-- Multiple Lines -> (/* Comments   */)

/* 
Line 1 
Line 2
Line 3
*/

-- Useful while debugging

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SQL Operators

-- Operators perform calculations or comparisons

-- Arithmetic Operators

---Operator	   Meaning
--      +	   Addition
--      -	   Subtraction
--      *	   Multiply
--      /	   Divide
--      %	   Remainder

-- Example

SELECT Price*Quantity
FROM Orders;

--------------------------------

-- Comparison Operators

-- Operator	  Meaning
--     =	   Equal
--     >	   Greater
--     <	   Less
--     >=	   Greater or equal
--     <=	   Less or equal
--     <>	   Not equal


SELECT * 
FROM Products
WHERE Price > 100;

---------------------------------------

-- Logical Operators

-- AND --- Both conditions must be true

SELECT *
FROM Customers
WHERE Country = 'Pakistan'
AND City = 'Lahore';

-- OR --- At least one condition must be true

SELECT *
FROM Customers
WHERE Country = 'Pakistan'
OR Country = 'USA';

-- NOT --- Reverse the condition

SELECT *
FROM Customers
WHERE NOT Country = 'USA';
-- Returns every country except USA

--------------------------------------

-- IN 
SELECT *
FROM Customers
WHERE Country IN ('Pakistan', 'UK', 'USA');

-- Same as 

SELECT *
FROM Customers
WHERE Country = 'USA'
OR Country = 'UK'
OR Country = 'Pakistan';

-------------------------------------------

-- BETWEEN

SELECT *
FROM Products
WHERE Price BETWEEN 20 AND 100;

------------------------------------------------

-- LIKE -- Pattern Matching

SELECT CustomerName
FROM Customers
WHERE CustomerName LIKE 'A%';


------------------------------------------------

-- EXISTS -- > Checks whether a subquery returns at least one row

SELECT * 
FROM Customers
WHERE EXISTS
(
SELECT * 
FROM Orders
WHERE Orders.CustomerId = Customers.CustomerId
);

-- Returns customers who have at least one order


--------------------------------------------------------

-- ANY --> True if at least one value satisfies the condition

SELECT * 
FROM Products
WHERE ProductID = ANY
(
SELECT ProductId 
FROM OrdersDetails
WHERE Quantity = 10
);

-- If even one ProductID matches, it returns the row

-----------------------------------------------------------------

-- ALL ---> True only if every value satisfies the condition

SELECT * 
FROM Products
WHERE ProductID > ALL
(
SELECT ProductId 
FROM OrdersDetails
WHERE Quantity = 10
);

-- All returned values must satisfy the condition

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------
-- SQL DATABASE
----------------------------------------------


-- SQL CREATE DATABASE

-- CREATE DATABASE is used to create a new database
-- Think of a database as a folder that stores tables

-- Syntax 

CREATE DATABASE database_name;

-- Example

CREATE DATABASE SchoolDB;

--------------------------------------------------

-- CHECK DATABASES

-- MYSQL 

SHOW DATABASES;

-- SQL Server

SELECT name
FROM sys.databases;

-------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SQL DROP DATABASE

--Deletes an entire database permanently

---Everything inside it is deleted: Tables, Data, Views, Stored Procedures


-- Syntax

DROP DATABASE database_name;

-- Example

DROP DATABASE UniDB;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SQL BACKUP DATABASE

-- Creates a backup (copy) of your database
-- If your database crashes, you can restore it from the backup

-- Syntax 

BACKUP DATABASE database_name
TO DISK = 'filepath';

-- Example

BACKUP DATABASE UniDB
TO DISK = 'D:\Backups\UniDB.bak';

--------------------------------------

-- Differential Backup

-- Instead of copying the entire database again, SQL copies only the changes made since the last full backup

-- Example
BACKUP DATABASE UniDB
TO DISK = 'D:\Backups\UniDB.bak'
WITH DIFFERENTIAL;


-- Full Backup	                  Differential Backup
-- Copies the whole database	 Copies only changed data
-- Takes more time	             Faster
-- Larger file                 	 Smaller file

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SQL CREATE TABLE

-- Creates a new table inside a database
-- Think of a table like an Excel spreadsheet

-- Syntax

CREATE TABLE table_name(
    column datatype constraint
);

-- Example

CREATE TABLE Customers(
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    City VARCHAR(50)
);

-- Table Created --> Initially, it is empty

-----------------------------------------------------

-- Understanding the Data Types

StudentID INT -> Stores integers

VARCHAR(100) -> Stores text up to 100 characters

-----------------------------------------------

-- Constraints Used

-- PRIMARY KEY
--- Every row must have a unique ID


--------------------------------------------------

-- NOT NULL

-- The value cannot be empty

Name VARCHAR(100) NOT NULL 


-----------------------------------------------------


-- Create Table from Existing Table

-- Instead of creating an empty table, copy data from another table

CREATE TABLE PakistanCustomers AS
SELECT *
FROM Customers
Where Country = 'Pakistan';


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SQL DROP TABLE

-- Deletes an entire table permanently

-- Everything is removed : Structure, Rows, Columns, Data

-- Syntax

DROP TABLE table_name;

-- Example

DROP Table Customers;

----- Safer Version --> If the table doesn't exist, SQL won't throw an error

DROP TABLE IF EXISTS Customers;


----------------------------------------------------------------------------------------

-- SQL TRUNCATE TABLE

-- Deletes all rows from a table, but keeps the table itself

-- Syntax
TRUNCATE TABLE table_name;

-- Example

TRUNCATE Table Students;

-- The table still exists, but it has no rows

----------------------------------------------------------------

-- Example -- DELETE

DELETE FROM Customers
WHERE Age > 20;

-- Only Customers older than 20 are deleted

----------------------------------------------------

-- Example -- TRUNCATE

TRUNCATE TABLE Customers;

-- All rows are deleted, but the table remains

-------------------------------------------------------

-- Example -- DROP

DROP TABLE Customers;

-- The table itself is deleted

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- ALTER TABLE

-- ALTER TABLE is used to change an existing table
-- Insert Column, Remove column, rename column, change data type


-- ADD Column

ALTER TABLE Customers
ADD Email VARCHAR(100);

-- Email column is added

----------------------------------------

-- DROP COLUMN
ALTER TABLE Customers
DROP COLUMN Email;

-- Now Email disappears

------------------------------------------------

-- RENAME COLUMN

ALTER TABLE Customers
RENAME COLUMN Name TO CustomerName;

---------------------------------------------------

-- MODIFY COLUMN 
-- CHange COlumn data type

ALTER TABLE Customers
ALTER COLUMN Age BIGINT;

-- The datatype changes

------------------------------------------------------

-- Rename Table

ALTER TABLE Customers
RENAME TO PakCustomers;

----------------------------------------------------------------------------------------------------------------------------------------------

-- SQL Constraints

-- Constraints are rules -> They make sure users cannot insert invalid data -> Think of them as security guards

-- Example: Without constraints
-- Age = -10 -> Database accepts it 
--  -> Wrong!

-- With constraints : Age must be >=18 
-- ->Database rejects invalid values

-- Types of Constraints

NOT NULL
UNIQUE
PRIMARY KEY
FOREIGN KEY
CHECK
DEFAULT
INDEX

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- NOT NULL

-- Normally a column can contain NULL

-- Sometimes this isn't acceptable

-- Example -> Every student must have a name

-- Use -> Name VARCHAR(50) NOT NULL

INSERT INTO Students(Name)
VALUES(NULL); -- Error -> Because NULL isn't allowed

-- Example

CREATE TABLE Students(
    ID INT,
    Name VARCHAR(50) NOT NULL
);

-- Valid
INSERT INTO Students
VALUES(1,'ali');

-- Invalid
INSERT INTO Students
VALUES(2,NULL);

---------------------------------------------------

-- Adding NOT NULL Later

ALTER TABLE Students
MODIFY Name VARCHAR(50) NOT NULL;

-- Now Name cannot be empty

----------------------------------------------------

-- Removing NOT NULL

ALTER TABLE Students
Modify Name VARCHAR(50) NULL;

-- Now NULL is allowed again

----------------------------------------------------------------------------------------------------------------------------------------

-- UNIQUE Constraint

-- No duplicate values

-- Example -> Email must be unique

-- USE -> EMAIL VARCHAR(50) UNIQUE -> Now duplicates aren't allowed

-- Example

CREATE TABLE Students(
    ID INT,
    Email VARCHAR(100) UNIQUE
);

-- If Duplicate Emails Insert -> Error

----------------------------------------------------

-- Multiple Column UNIQUE

UNIQUE(ID, Name)

-- Now the combination must be unique

------------------------------------------------------

-- Naming Constraints

-- Instead of automatic names

CONSTRAINT UC_Student UNIQUE(Email)

-- Now the constraint has a readable name

---------------------------------------------------------

-- Adding UNIQUE Later

ALTER TABLE Students
ADD UNIQUE(Email);


-- Removing UNIQUE -> (SQL Server)

ALTER TABLE Students
DROP CONSTRAINT UC_Student;

-- Removing UNIQUE -> (MySQL)

ALTER TABLE Students
DROP INDEX UC_Student;

---------------------------------------------------

-- PRIMARY KEY
Only one per table
Cannot be NULL
Must be UNIQUE


-- UNIQUE
Can have multiple UNIQUE constraints in one table
Ensures values are unique
Depending on the database, it may allow NULL values

---------------------------------------------------------------

-- Example

CREATE TABLE Students(
    ID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15) UNIQUE,
    Age INT
);

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------






