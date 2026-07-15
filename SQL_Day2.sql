--------------------------------------------------------------------------------------------------------------------------

-- SQL - DAY 2

---------------------------------------------------------------------------------------------------------------------------

-- SQL MIN() Function

-- The MIN() function returns the smallest value from a column

-- IT WORKS with -> Numbers, DATES, Text (alphabetically)

-- Syntax
SELECT MIN(Column_name)
FROM table_name;

-- Example
SELECT MIN(Price)
FROM Products;

-- Return Smallest price from Products Table

-- Using Where

SELECT MIN(Price)
FROM Products
WHERE CategoryID = 1;

-- Returns the lowest price only in Category 1

-- Using Alias (AS)

-- Return changed Column name -- AS gives a meaningful column name

SELECT MIN(price) AS LowestPrice
FROM Products;

-- MIN() with Dates
SELECT MIN(BirthDate)
FROM Employees;

-- Return earliest birth date

---------------------------------------------------------------------------------------------------------------------------

-- SQL MAX() Function

-- Returns the largest value in a column

-- Syntax
SELECT MAX(Column_name)
FROM Table_name;

-- Example
SELECT MAX(Price)
FROM Products;

-- Using Alias(AS)

SELECT MAX(Price) As HighestPrice
FROM Products;

-- MAX() with Dates

SELECT Max(BirthDate)
FROM Employees;

-- Returns the latest birth date (youngest employee)

------------------------------------------------------------------------------------------------------------------------------------------

-- SQL COUNT() Function

-- COUNT() counts rows

-- COUNT(*) -- -- Counts all rows

SELECT COUNT(*)
FROM Students;

-- COUNT(column)

-- Suppose name column have a NUll Value

SELECT COUNT(Name)
FROM Students;

-- NULL is ignored


-- COUNT(DISTINCT)

SELECT COUNT(DISTINCT CITY)
FROM Employees;

-- Only unique values are counted

-- COUNT with WHERE 
SELECT COUNT(*)
FROM Products
WHERE Price > 20;

-- Counts products with a price greater than 20

-- Alias -- Column Name TotalProducts -> 77 (products count)

SELECT COUNT(*) AS TotalProducts
FROM Products;

-------------------------------------------------------------------------------------------------------------------------------------------------------

-- SQL SUM() Function

-- SUM() adds all numeric values

SELECT SUM(Quantity)
FROM Orders;

--Calculation :  10 + 20 + 15 + 5

-- Output -> 50

-- SUM with WHERE 

SELECT SUM(Quantity)
FROM Orders
WHERE ProductId = 11;

-- Adds quantities only for Product 11

-- Alias -- Column Name -> TotalQuantity

SELECT SUM(Quantity) AS TotalQuantity
FROM Orders;

-- SUM() with Expression

SELECT SUM(Quantity * 10)
FROM Orders;

-- Calculation -> (10×10)+(5×10)+(20×10)
-- Output ->  350

-- SQL can calculate expressions inside SUM()

---------------------------------------------------------------------------------------------------------------------------------------------------------

-- SQL AVG() Function

-- Returns the average of numeric values

SELECT AVG(Price)
FROM Products;

--- AVG with WHERE

SELECT AVG(Price)
FROM Products
WHERE CategoryId = 1;

-- Average price only for Category 1

-- Alias -> Column Name 

SELECT AVG(Price) AS AveragePrice
FROM Products;

-- Higher Than Average

SELECT * FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

-- SQL calculates average

-- Suppose -> Average = 50

-- SQL returns all products where -> Price > 50

-- This is called a Subquery because one query is written inside another query


--------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SQL LIKE Operator

-- LIKE searches text using patterns

-- WildCards -> SQL mainly uses two wildcards.

-- 1.  %  -> Means ->  Zero, one, or many characters

-- 2.  _  -> Means  ->  Exactly one character


-- Starts With

SELECT * FROM Students
WHERE Name LIKE 'A%';

-- Anything that starts with A

-- Ends With

SELECT * FROM Students
WHERE Name LIKE '%x';

-- Anything that ends with x


-- Contains 

SELECT * FROM Students
Where Name Like '%sh%';

-- COntains sh anywhere

-- Starts with A and End With D

SELECT * FROM Students
WHERE Name Like 'A%D';




--- Second Character is L

SELECT * FROM Students
WHERE Name Like '_L%';

-- The first character can be anything, but the second must be L




-- At Least Three Characters

SELECT * 
FROM Students
WHERE Name Like 'A_%';

-- Starts with A
-- Has at least two more characters
-- Can have more characters after that


---- Single Character Wildcard (_)

SELECT * 
FROM Students
WHERE Name Like 'A_I__A';

-- Each _ represents one character only



-- LIKE Without Wildcards

SELECT * 
FROM Students
WHERE City Like 'Lahore';

-- This behaves exactly like:

SELECT * 
FROM Students
WHERE City = 'Lahore';

------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- SQL Wildcards

-- Wildcards are special symbols used with the LIKE operator to search text patterns

-- Wildcard %

-- % means zero, one, or many characters

SELECT * FROM Students
WHERE City Like 'M%';

-- Cities Starting with M

-- END with

SELECT * FROM Students
WHERE City Like '%R';

-- -- Cities Ending with R

-- Contains

SELECT * FROM Students
WHERE City Like '%ma%';

-- Contains ma anywhere





--  Wildcard _

-- _ means exactly one character

SELECT * FROM Students
WHERE City LIKE '_ahore';

-- Example

SELECT * FROM Students
WHERE Name LIKE 'A___';
-- Start with A and total Length = 4

-------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Wildcard []

-- One character from list
-- (Works mainly in SQL Server)

SELECT *
FROM Students
WHERE Name Like '[ABC]%';

--  [ABC]% ----> Means Start with A or B or C


-- Wildcard [a-f]

-- One character from range

SELECT *
FROM Students
WHERE Name Like '[A-F]%';

-- [A-F]% -> Means Starts wih A or B or C or D or E or F

----------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- SQL IN Operator

-- Instead of writing many OR conditions, use IN

-- Without IN

SELECT *
FROM Students
WHERE City = 'Lahore'
OR City = 'Sahiwal'
OR City = 'Multan';

-- Same Query Using IN

SELECT * 
FROM Students
WHERE City IN ('Lahore', 'Sahiwal', 'Multan');

-- Much shorter


-- NOT IN

SELECT *
FROM Students
WHERE City NOT IN ('Lahore', 'Multan');

-- Means -> Show everyone except Lahore and Multan


-- IN With SubQuery

SELECT * 
FROM Students
WHERE StudentId IN (
SELECT StudentId
FROM FYPReports
);

-- Means -> Only STudents Who have submit FYP Reports

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SQL BETWEEN

-- Used to find values inside a range

-- Numbers

SELECT *
FROM Products
WHERE Price BETWEEN 100 AND 500;

-- Both 100 and 500 are included


-- NOT BETWEEN

SELECT *
FROM Products
WHERE Price NOT BETWEEN 100 AND 500;

-- Products -> Less then 100 and Greater then 500



-- BETWEEN + IN

SELECT * 
FROM Products
WHERE Price BETWEEN 100 AND 1000
AND CategoryId IN (1,2,3);

-- Conditions :Price between 100 and 1000 AND Category is 1,2 or 3


-- BETWEEN Text

SELECT *
FROM Products
WHERE Name BETWEEN 'A' AND 'M';

-- Returns names alphabetically between A and M

-- BETWEEN Dates

SELECT * 
FROM Admission
WHERE Student_Admission_Date BETWEEN '2026-01-01' AND '2026-01-31';

-- Returns all January Admissions


-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

--  SQL Aliases (AS)

-- Alias means temporary nickname

-- Original
SELECT Student_Name
FROM Students;

-- Alias
SELECT Student_Name AS Name
FROM Students;

-- Output : Name ->  Instead of | Student_Name |

-- Alias WIth Spaces

SELECT Student_Name AS "Student Name"
FROM Students;


-- Alias for Tables

-- Instead of writing ->  Students.StudentName
-- Use Alias

SELECT s.studentName
FROM Students AS s;

-- Now s = Students


-- Alias in JOIN

-- Instead of :

SELECT Students.StudentName,
Reports.ReportId
FROM Students
JOIN Reports
ON Students.StudentId = Reports.StudentId;

-- Use

SELECT s.StudentName, r.ReportId
FROM Students AS s
JOIN Reports AS r
ON s.StudentId = r.StudentId;

-- Much easier to read


-- Concatenate Columns

--Suppose:
-- Address = Street 5
-- City = Lahore
-- Country = Pakistan

SELECT CONCAT(Address, ', ', City, ', ', Country)
AS FULL_Address
FROM Students;

-- Output -> Street 5, Lahore, Pakistan

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


----- SQL JOIN ------ 

-- A JOIN is used to combine data from two or more tables using a common column


-- General JOIN Syntax

SELECT columns
FROM Table1
JOIN Table2
ON Table1.CommonColumn = Table2.CommonColumn;

-- The ON keyword tells SQL how the tables are related

-- Types of SQL JOINs

-- There are 5 important joins.

-- 1. INNER JOIN
-- 2. LEFT JOIN
-- 3. RIGHT JOIN
-- 4. FULL JOIN
-- 5. SELF JOIN

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Customers Table
-- CustomerID	CustomerName
-- 1	            Alisha
-- 2	            Ahmed
-- 3	            Ali


-- Orders Table
-- OrderID	CustomerID	Product
-- 101	       1	     Laptop
-- 102	       2	     Mouse
-- 103	       2	     Keyboard
-- 104	       5	     Mobile


-- 1. INNER JOIN 
-- Returns only matching rows from both tables

SELECT Customers.CustomerName, Orders.Product
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;


-- Result 
-- Customer	Product
-- Alisha	    Laptop
-- Ahmed	Mouse
-- Ahmed	Keyboard

-- Ali is not returned because he has no order
-- Order 104 is also ignored because CustomerID = 5 doesn't exist

-- Only matching rows appear

-- Think like this : Customers ∩  Orders
-- Only the intersection


-- JOIN and INNER JOIN

--- These are exactly the same


SELECT *
FROM Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;

-- Same as

SELECT *
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;


-- Joining Multiple Tables

SELECT Orders.OrderID, Customers.CustomerName, Shippers.ShipperName
FROM Orders
INNER JOIN Customers
ON Orders.CustomerID = Customers.CustomerID
INNER JOIN Shippers
On Orders.ShipperID = Shippers.ShipperID;

-- Result -> Order  Customer  Shipper

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--- 2. LEFT JOIN

-- Returns
---Everything from the LEFT table
---Matching rows from RIGHT table

-- If no match exists → NULL


-- Customers

-- ID	Name
-- 1	Alisha
-- 2	Ahmed
-- 3	Ali

-- Orders

-- OrderID	CustomerID
-- 101	           1
-- 102	           2

-- Query

SELECT Customers.CustomersName, Orders.OrderID
FROM Customers
LEFT JOIN Orders
ON Customer.CustomerID = Orders.CustomerID

-- Result 

-- Customer	  Order
-- Alisha	    101
-- Ahmed	    102
-- Ali 	       NULL

-- Ali appears because LEFT JOIN always keeps every row from the left table



-- Find Customers Without Orders

SELECT Customers.CustomerName 
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.CustomerID IS NULL;

-- Output -> Ali

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- 3. RIGHT JOIN

-- Opposite of LEFT JOIN.

-- Returns
---Everything from RIGHT table
---Matching rows from LEFT table

-- Orders

-- OrderID	EmployeeId
--   101	    1
--   102	    2

-- Employees

-- EmployeesId	Name
--  1	        John
--  2	        Alisha
--  3	        Ali

-- Query

SELECT Orders.OrderID, Employees.Name
FROM Orders
RIGHT JOIN Employees
ON Orders.EmployeeId = Employees.EmployeeId;

-- Result

-- Order	Employee
--  101	     John
--  102	     Alisha
-- NULL	     Ali

-- Ali appears because RIGHT JOIN returns every employee

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 4. FULL JOIN

-- Returns everything

-- LEFT table  +  RIGHT table
-- Matching rows combine
-- Unmatched rows also appear

-- Customers

--  ID	Name
--  1	Alisha
--  2	Ahmed
--  3	Ali

-- Orders

-- Order	CustomerID
--  101	         1
--  102	         2
--  103	         5

-- Query

SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
FULL JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;

-- Result
--  Customer	Order
--  Alisha   	101
--  Ahmed	    102
--  Ali      	NULL
--  NULL     	103

-- Ali has no order
-- Order 103 has no customer

-- Both still appear

-- Note: MySQL does not support FULL JOIN directly. It is available in SQL Server and PostgreSQL. In MySQL, you usually simulate it with LEFT JOIN UNION RIGHT JOIN

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- 5. SELF JOIN

-- A table joins with itself

-- Why? ->  To compare rows inside the same table


-- Customers

-- ID	Name	  City
-- 1	Ali	     Lahore
-- 2	Ahmed	 Lahore
-- 3	Ali1	 Karachi

-- Query 

SELECT A.CustomerName, B.CustomerName, A.City
FROM Customers A,
Customers B
WHERE A.CustomerID <> B.CustomerID
AND A.City = B.City;

-- Result

-- Customer1	Customer2	City
--     Ali	       Ahmed	Lahore

-- Both customers live in the same city

-- Why use aliases (A and B)?

-- Since you're joining the same table twice, SQL needs two names to distinguish them

-- Customers
--    ↓
--    A

-- Customers
--    ↓
--    B

-- Without aliases, SQL cannot tell which copy of the table you mean

-- Why do we use table aliases?

-- Instead of writing -> Customers.CustomerName
-- write -> c.CustomerName

-- Example

SELECT c.CustomerName,
o.OrderID
FROM Customers c
JOIN Orders o
ON c.CustomerID=o.CustomerID;

-- Much shorter and easier to read

-------------------------------------------------------------------------------------------------------------------------------------------------

-- INNER JOIN → Common records only
-- LEFT JOIN → Keep everything from the left table
-- RIGHT JOIN → Keep everything from the right table
-- FULL JOIN → Keep everything from both tables
-- SELF JOIN → Compare rows within the same table


-----------------------------------------------------------------------------------------------------------------------------------------------------

-- SQL UNION Operator

-- The UNION operator is used to combine the results of two or more SELECT statements into a single result set

-- It removes duplicate rows automatically
-- It returns only unique records

-- Syntax 
SELECT Column_name(s)
FROM table1

UNION

SELECT Column_name(s)
FROM table2;

-- Example

--Customers Table

-- Country
---Pakistan
---India
---China

--Suppliers Table

-- Country
---India
---USA
---China

SELECT Country
FROM Customers

UNION

SELECT Country
FROM Suppliers;

-- Output
---Country
---Pakistan
---India
---China
---USA

-- Notice that India and China appear in both tables, but they are returned only once because UNION removes duplicates


-- UNION = Combine + Remove Duplicates

-- Conditions for UNION

-- To use UNION, the following conditions must be met:

-- 1. Same Number of Columns

SELECT Name, City
FROM Customers

UNION

SELECT SupplierName, City
FROM Suppliers;

-- Both queries return 2 columns

-----------------------------------------

-- Incorrect Way

SELECT Name
FROM Customers

UNION

SELECT SupplierName, City
FROM Suppliers;

-- This will produce an error because the first query returns 1 column, while the second returns 2 columns.


-----------------------------------------------


-- 2. Similar Data Types

SELECT Name
FROM Customers

UNION

SELECT SupplierName
FROM Suppliers;

-- Both columns contain text

---------------------------------------------------

-- Incorrect Way

SELECT Name
FROM Customers

UNION

SELECT Price
FROM Products;

-- One column contains text and the other contains numbers, which may cause an error depending on the database system

--------------------------------------------------------------------------------------------------------------------------------------------


-- UNION with WHERE

-- filter records before combining them

-- Return only Pakistan cities from both tables

SELECT City
FROM Customers
WHERE Country = 'Pakistan'

UNION

SELECT City
FROM Suppliers
WHERE Country = 'Pakistan';

--The database:
-- Filters Pakistan cities from both tables
-- Combines the results
-- Removes duplicate cities

-------------------------------------------------------------------------------------------------------------------------------------------------

-- Union with Alias

SELECT 'Customer' AS Type, ContactName
FROM Customers

UNION

SELECT 'Supplier', ContactName
FROM Suppliers;

-- Type	     ContactName
-- Customer	   Ali
-- Customer	   Ahmed
-- Supplier	   Alisha
-- Supplier	   Alis

-- Type is a temporary column created using the AS keyword

-----------------------------------------------------------------------------------------------------------------------------------------------------

-- SQL UNION ALL

--  UNION ALL also combines the results of multiple SELECT statements

-- The difference is:
----It does not remove duplicates
----It returns all rows, including repeated values


-- Country
---Pakistan
---India
---China

--Suppliers Table

-- Country
---India
---USA
---China

-- Query

SELECT Country
FROM Customers

UNION ALL

SELECT Country
FROM Suppliers;

-- Output

-- Country
---Pakistan
---India
---China
---India
---USA
---China

-- UNION ALL keeps duplicate records

-- UNION	                UNION ALL
-- Removes duplicate rows	Keeps duplicate rows
-- Returns unique records	Returns all records
-- Slightly slower	        Faster

--- Example 

SELECT Name
FROM Customers

UNION 

SELECT Name
FROM Suppliers;

-- Duplicates are removed

-------------------------------------------------------

-- Example

-- Using UNION ALL

SELECT Name
FROM Customers

UNION ALL

SELECT Name
FROM Suppliers;

-- Duplicates are preserved

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

UNION = Unique (duplicates removed)
UNION ALL = All (duplicates included)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




