/*
====================================================
SQL Tutorial  -Theory + Commands
====================================================

1. What is SQL?

SQL (Structured Query Language) is a language used to communicate with databases.

A database stores information in an organized way.

For example, a school database may contain a table like this:

StudentID | Name  | Age
----------|-------|-----
1         | Ali   | 20
2         | Sara  | 21
3         | Ahmed | 19

Using SQL, we can:

- Retrieve data
- Insert new data
- Update existing data
- Delete data
- Create databases and tables

====================================================
2. What Can SQL Do?
====================================================

SQL can perform many operations on a database.

Retrieve Data

SELECT * FROM Students;

This displays all records from the Students table.

----------------------------------------------------

Insert Data

INSERT INTO Students
VALUES (4, 'Ayesha', 22);

Adds a new student.

----------------------------------------------------

Update Data

UPDATE Students
SET Age = 23
WHERE StudentID = 4;

Updates the age of the student with ID 4.

----------------------------------------------------

Delete Data

DELETE FROM Students
WHERE StudentID = 4;

Deletes the student whose ID is 4.

----------------------------------------------------

Create a Table

CREATE TABLE Students (
    StudentID INT,
    Name VARCHAR(50),
    Age INT
);

Creates a new table called Students.

====================================================
3. What is RDBMS?
====================================================

RDBMS stands for Relational Database Management System.

It is software used to manage relational databases.

Examples:

- MySQL
- SQL Server
- Oracle
- PostgreSQL
- Microsoft Access

All of these support SQL.

====================================================
4. What is a Table?
====================================================

A table stores data in rows and columns.

Example:

CustomerID | CustomerName | City    | Country
-----------|--------------|---------|----------
1          | Ali          | Lahore  | Pakistan
2          | Sara         | Karachi | Pakistan
3          | John         | London  | UK

A database can have many tables.

====================================================
5. Rows and Columns
====================================================

Row (Record)

A row represents one complete record.

Example:

| 1 | Ali | Lahore | Pakistan |

This is one row.

----------------------------------------------------

Column (Field)

A column represents one type of information.

Examples:

- CustomerID
- CustomerName
- City
- Country

Each column stores similar data.

====================================================
6. SQL Statements
====================================================

An SQL statement is a command that tells the database what to do.

Example:

SELECT * FROM Customers;

This retrieves all data from the Customers table.

====================================================
7. SQL Keywords
====================================================

SQL has predefined keywords such as:

SELECT
FROM
WHERE
INSERT
UPDATE
DELETE
CREATE

These keywords have special meanings.

====================================================
8. SQL is Not Case Sensitive
====================================================

These statements are all valid:

SELECT * FROM Customers;
select * from customers;
SeLeCt * FrOm Customers;

However, it is a good practice to write SQL keywords in UPPERCASE.

====================================================
9. Semicolon (;)
====================================================

A semicolon marks the end of an SQL statement.

Example:

SELECT * FROM Customers;

If multiple statements are written together:

SELECT * FROM Customers;
SELECT * FROM Orders;

The semicolon separates them.

====================================================
10. SELECT Statement
====================================================

The SELECT statement retrieves data from a table.

Syntax:

SELECT column1, column2
FROM table_name;

Example:

SELECT CustomerName, City
FROM Customers;

Output:

CustomerName | City
-------------|---------
Ali          | Lahore
Sara         | Karachi

====================================================
11. SELECT *
====================================================

The asterisk (*) means all columns.

SELECT *
FROM Customers;

Output:

CustomerID | CustomerName | City    | Country
-----------|--------------|---------|----------
1          | Ali          | Lahore  | Pakistan
2          | Sara         | Karachi | Pakistan

Every column is displayed.

====================================================
12. SELECT DISTINCT
====================================================

Sometimes a column contains duplicate values.

Example:

Name  | Country
------|----------
Ali   | Pakistan
Sara  | Pakistan
John  | UK
Mike  | USA
Ahmed | Pakistan

Without DISTINCT:

SELECT Country
FROM Customers;

Output:

Pakistan
Pakistan
UK
USA
Pakistan

Duplicates are included.

----------------------------------------------------

With DISTINCT:

SELECT DISTINCT Country
FROM Customers;

Output:

Pakistan
UK
USA

Only unique values are returned.

====================================================
13. COUNT(DISTINCT)
====================================================

Counts the number of unique values.

Example:

SELECT COUNT(DISTINCT Country)
FROM Customers;

Output:

3

Because there are only three unique countries:

- Pakistan
- UK
- USA

====================================================
14. WHERE Clause
====================================================

The WHERE clause filters records based on a condition.

Syntax:

SELECT *
FROM Customers
WHERE condition;

Example:

SELECT *
FROM Customers
WHERE Country = 'Pakistan';

Output:

Name | Country
-----|----------
Ali  | Pakistan
Sara | Pakistan

Only customers from Pakistan are displayed.

====================================================
15. Text vs Numeric Values
====================================================

Text Values:

Text must be enclosed in single quotes.

Example:

WHERE Country = 'Pakistan'

----------------------------------------------------

Numeric Values:

Numbers are not enclosed in quotes.

Example:

WHERE CustomerID = 2

====================================================
16. SQL Operators
====================================================

Equal (=)

SELECT *
FROM Customers
WHERE CustomerID = 1;

Returns the customer whose ID is 1.

----------------------------------------------------

Greater Than (>)

SELECT *
FROM Customers
WHERE CustomerID > 2;

Returns all customers with IDs greater than 2.

----------------------------------------------------

Less Than (<)

SELECT *
FROM Customers
WHERE CustomerID < 5;

Returns customers with IDs less than 5.

----------------------------------------------------

Greater Than or Equal To (>=)

SELECT *
FROM Customers
WHERE Age >= 18;

Returns customers aged 18 or older.

----------------------------------------------------

Less Than or Equal To (<=)

SELECT *
FROM Customers
WHERE Age <= 25;

Returns customers aged 25 or younger.

----------------------------------------------------

Not Equal (<>)

SELECT *
FROM Customers
WHERE Country <> 'Pakistan';

Returns customers from countries other than Pakistan.

----------------------------------------------------

BETWEEN

SELECT *
FROM Customers
WHERE Age BETWEEN 18 AND 25;

Returns customers whose age is between 18 and 25 (inclusive).

----------------------------------------------------

LIKE

SELECT *
FROM Customers
WHERE CustomerName LIKE 'A%';

Output:

Ali
Ahmed
Ayesha

A% means starts with the letter A.

----------------------------------------------------

IN

SELECT *
FROM Customers
WHERE Country IN ('Pakistan', 'UK');

Returns customers whose country is either Pakistan or the UK.

====================================================
Summary
====================================================

SQL Command        Purpose                     Example
-----------------  --------------------------  -----------------------------------------
SELECT             Retrieve data               SELECT * FROM Customers;
SELECT *           Retrieve all columns        SELECT * FROM Customers;
SELECT column      Retrieve specific columns   SELECT Name FROM Customers;
DISTINCT           Return unique values        SELECT DISTINCT Country FROM Customers;
COUNT(DISTINCT)    Count unique values         SELECT COUNT(DISTINCT Country) FROM Customers;
WHERE              Filter records              WHERE Country = 'Pakistan';
=                  Equal to                    WHERE ID = 1;
>                  Greater than                WHERE Age > 18;
<                  Less than                   WHERE Age < 30;
>=                 Greater than or equal to    WHERE Marks >= 50;
<=                 Less than or equal to       WHERE Marks <= 100;
<>                 Not equal to                WHERE Country <> 'Pakistan';
BETWEEN            Range of values             WHERE Age BETWEEN 18 AND 25;
LIKE               Pattern matching            WHERE Name LIKE 'A%';
IN                 Match multiple values       WHERE Country IN ('Pakistan', 'UK');

====================================================

====================================================
*/

/*
====================================================
1. SQL ORDER BY
====================================================

What is ORDER BY?

The ORDER BY keyword is used to sort the data returned by a query.

By default, SQL sorts data in Ascending (ASC) order.

----------------------------------------------------
Example Table: Products
----------------------------------------------------

ProductID | ProductName | Price
----------|-------------|------
1         | Laptop      | 900
2         | Mouse       | 20
3         | Keyboard    | 50
4         | Monitor     | 300

----------------------------------------------------
Ascending Order (Default)
----------------------------------------------------

SELECT *
FROM Products
ORDER BY Price;

Output:

Product   | Price
----------|------
Mouse     | 20
Keyboard  | 50
Monitor   | 300
Laptop    | 900

Lowest price → Highest price

----------------------------------------------------
Descending Order (DESC)
----------------------------------------------------

SELECT *
FROM Products
ORDER BY Price DESC;

Output:

Product   | Price
----------|------
Laptop    | 900
Monitor   | 300
Keyboard  | 50
Mouse     | 20

Highest price → Lowest price

----------------------------------------------------
Alphabetical Order
----------------------------------------------------

SELECT *
FROM Products
ORDER BY ProductName;

Output:

Keyboard
Laptop
Monitor
Mouse

Sorted from A → Z.

----------------------------------------------------
Reverse Alphabetical Order
----------------------------------------------------

SELECT *
FROM Products
ORDER BY ProductName DESC;

Output:

Mouse
Monitor
Laptop
Keyboard

Sorted from Z → A.

----------------------------------------------------
ORDER BY Multiple Columns
----------------------------------------------------

Suppose the Customers table is:

Customer | Country
---------|----------
Ali      | Pakistan
Sara     | Pakistan
John     | UK
Mike     | UK
Ahmed    | Pakistan

Query:

SELECT *
FROM Customers
ORDER BY Country, CustomerName;

How SQL sorts:

1. First by Country
2. Then, if two customers have the same country,
    by CustomerName

Output:

Customer | Country
---------|----------
Ahmed    | Pakistan
Ali      | Pakistan
Sara     | Pakistan
John     | UK
Mike     | UK

----------------------------------------------------
Combine ASC and DESC
----------------------------------------------------

SELECT *
FROM Customers
ORDER BY Country ASC, CustomerName DESC;

Country is sorted A → Z,
but names within each country are sorted Z → A.

====================================================
2. SQL AND Operator
====================================================

What is AND?

The AND operator combines multiple conditions.

A record is returned only if ALL conditions are true.

----------------------------------------------------
Example Table
----------------------------------------------------

Name | Country  | City
-----|----------|---------
Ali  | Pakistan | Lahore
Sara | Pakistan | Karachi
John | UK       | London

Query:

SELECT *
FROM Customers
WHERE Country = 'Pakistan'
AND City = 'Lahore';

Output:

Name | Country  | City
-----|----------|---------
Ali  | Pakistan | Lahore

Only Ali satisfies both conditions.

----------------------------------------------------
Another Example
----------------------------------------------------

SELECT *
FROM Customers
WHERE Country = 'Pakistan'
AND CustomerName LIKE 'A%';

Conditions:

- Country must be Pakistan
- Name must start with A

Result:

Ali
Ahmed

====================================================
3. SQL OR Operator
====================================================

What is OR?

The OR operator returns rows if at least one condition is true.

----------------------------------------------------
Example
----------------------------------------------------

Name | Country
-----|----------
Ali  | Pakistan
Sara | Pakistan
John | UK
Mike | USA

Query:

SELECT *
FROM Customers
WHERE Country = 'Pakistan'
OR Country = 'UK';

Output:

Name | Country
-----|----------
Ali  | Pakistan
Sara | Pakistan
John | UK

USA is excluded.

----------------------------------------------------
Another Example
----------------------------------------------------

SELECT *
FROM Customers
WHERE City = 'Lahore'
OR CustomerName LIKE 'J%';

Returns:

- Everyone from Lahore
- Everyone whose name starts with J

----------------------------------------------------
Difference Between AND and OR
----------------------------------------------------

Suppose:

Name | Country  | City
-----|----------|---------
Ali  | Pakistan | Lahore
Sara | Pakistan | Karachi
John | UK       | London

AND:

WHERE Country = 'Pakistan'
AND City = 'Lahore';

Output:

Ali

Both conditions must be true.

----------------------------------------------------

OR:

WHERE Country = 'Pakistan'
OR City = 'London';

Output:

Ali
Sara
John

Only one condition needs to be true.

====================================================
4. Combining AND and OR
====================================================

Suppose:

Name      | Country
----------|----------
Garcia    | Spain
Rodriguez | Spain
Ali       | Pakistan

Query:

SELECT *
FROM Customers
WHERE Country = 'Spain'
AND (
    CustomerName LIKE 'G%'
    OR CustomerName LIKE 'R%'
);

SQL first checks:

1. Country = Spain

Then checks:

2. Name starts with G OR R

Parentheses make the logic clear.

----------------------------------------------------
Without Parentheses
----------------------------------------------------

WHERE Country = 'Spain'
AND CustomerName LIKE 'G%'
OR CustomerName LIKE 'R%';

SQL interprets it differently.

Records starting with R from any country
may also be returned.

Always use parentheses when mixing
AND and OR.

====================================================
5. SQL NOT Operator
====================================================

What is NOT?

The NOT operator reverses a condition.

It means:

"Give me everything except..."

----------------------------------------------------
Example
----------------------------------------------------

SELECT *
FROM Customers
WHERE NOT Country = 'Pakistan';

Returns all customers except those from Pakistan.

----------------------------------------------------
NOT LIKE
----------------------------------------------------

SELECT *
FROM Customers
WHERE CustomerName NOT LIKE 'A%';

Returns customers whose names
do not start with A.

----------------------------------------------------
NOT BETWEEN
----------------------------------------------------

SELECT *
FROM Customers
WHERE CustomerID NOT BETWEEN 10 AND 20;

Returns customers whose IDs are:

- Less than 10
OR
- Greater than 20

----------------------------------------------------
NOT IN
----------------------------------------------------

SELECT *
FROM Customers
WHERE City NOT IN ('Lahore', 'Karachi');

Returns customers who are not from
Lahore or Karachi.

----------------------------------------------------
NOT Greater Than
----------------------------------------------------

SELECT *
FROM Customers
WHERE NOT CustomerID > 50;

Means:

CustomerID <= 50

----------------------------------------------------
NOT Less Than
----------------------------------------------------

SELECT *
FROM Customers
WHERE NOT CustomerID < 50;

Means:

CustomerID >= 50

====================================================
6. SQL INSERT INTO
====================================================

What is INSERT INTO?

The INSERT INTO statement is used to add
new records to a table.

Suppose the table is:

StudentID | Name | Age
----------|------|-----
1         | Ali  | 20
2         | Sara | 21

----------------------------------------------------
Insert All Columns
----------------------------------------------------

INSERT INTO Students
VALUES (3, 'Ahmed', 22);

New Table:

StudentID | Name  | Age
----------|-------|-----
1         | Ali   | 20
2         | Sara  | 21
3         | Ahmed | 22

----------------------------------------------------
Insert Specific Columns
----------------------------------------------------

Suppose the table also has:

StudentID | Name | Age | City

If you only want to insert the name and city:

INSERT INTO Students (Name, City)
VALUES ('Ayesha', 'Lahore');

The remaining columns will contain:

- NULL
OR
- Their default values

----------------------------------------------------
Insert Multiple Rows
----------------------------------------------------

INSERT INTO Students (Name, Age)
VALUES
('Ali', 20),
('Sara', 21),
('Ahmed', 22);

Three records are inserted at once.

====================================================
Quick Revision Table
====================================================

Keyword       Purpose                           Example
------------  --------------------------------  ---------------------------------------
ORDER BY      Sort data                         ORDER BY Price
ASC           Ascending order                   ORDER BY Price ASC
DESC          Descending order                  ORDER BY Price DESC
AND           All conditions must be true       WHERE Age > 18 AND City='Lahore'
OR            Any one condition can be true     WHERE City='Lahore' OR City='Karachi'
NOT           Opposite of a condition           WHERE NOT Country='Pakistan'
INSERT INTO   Add new rows                      INSERT INTO Students VALUES (...)

====================================================

====================================================
*/


/*
====================================================
1. SQL NULL Values
====================================================

What is a NULL Value?

A NULL value means no value or missing data.

It does NOT mean:

- 0 (zero)
- '' (empty string)

It simply means the value is unknown or not provided.

----------------------------------------------------
Example
----------------------------------------------------

StudentID | Name  | Email
----------|-------|-------------------
1         | Ali   | ali@gmail.com
2         | Sara  | NULL
3         | Ahmed | ahmed@gmail.com

Sara's email is NULL, which means it was not entered.

----------------------------------------------------
Why can't we use "=" with NULL?
----------------------------------------------------

This is WRONG:

SELECT *
FROM Students
WHERE Email = NULL;

It returns nothing because NULL is not considered
a normal value.

----------------------------------------------------
IS NULL
----------------------------------------------------

Used to find records where a column has NULL.

Syntax:

SELECT column_name
FROM table_name
WHERE column_name IS NULL;

Example:

SELECT *
FROM Students
WHERE Email IS NULL;

Output:

Name | Email
-----|-------
Sara | NULL

----------------------------------------------------
IS NOT NULL
----------------------------------------------------

Used to find records that contain a value.

SELECT *
FROM Students
WHERE Email IS NOT NULL;

Output:

Name  | Email
------|-------------------
Ali   | ali@gmail.com
Ahmed | ahmed@gmail.com

====================================================
2. SQL UPDATE Statement
====================================================

What is UPDATE?

The UPDATE statement is used to modify
existing data in a table.

----------------------------------------------------
Syntax
----------------------------------------------------

UPDATE table_name
SET column1 = value1,
    column2 = value2
WHERE condition;

----------------------------------------------------
Example
----------------------------------------------------

Table Before Update:

ID | Name | City
---|------|---------
1  | Ali  | Lahore
2  | Sara | Karachi

Query:

UPDATE Students
SET City = 'Islamabad'
WHERE ID = 1;

Output:

ID | Name | City
---|------|-----------
1  | Ali  | Islamabad
2  | Sara | Karachi

Only Ali's city changes.

----------------------------------------------------
Update Multiple Columns
----------------------------------------------------

UPDATE Students
SET Name = 'Ahmed',
    City = 'Lahore'
WHERE ID = 2;

Both Name and City are updated.

----------------------------------------------------
Update Multiple Rows
----------------------------------------------------

UPDATE Customers
SET ContactName = 'Juan'
WHERE Country = 'Mexico';

All customers from Mexico are updated.

----------------------------------------------------
IMPORTANT WARNING
----------------------------------------------------

If you forget the WHERE clause:

UPDATE Students
SET City = 'Lahore';

Every row becomes:

ID | Name  | City
---|-------|--------
1  | Ali   | Lahore
2  | Sara  | Lahore
3  | Ahmed | Lahore

All records are updated!

====================================================
3. SQL DELETE Statement
====================================================

What is DELETE?

DELETE removes records (rows) from a table.

----------------------------------------------------
Syntax
----------------------------------------------------

DELETE FROM table_name
WHERE condition;

----------------------------------------------------
Example
----------------------------------------------------

Before:

ID | Name
---|------
1  | Ali
2  | Sara
3  | Ahmed

Query:

DELETE FROM Students
WHERE ID = 2;

After:

ID | Name
---|------
1  | Ali
3  | Ahmed

Sara is deleted.

----------------------------------------------------
Delete Multiple Rows
----------------------------------------------------

DELETE FROM Customers
WHERE Country = 'Pakistan';

Deletes every customer from Pakistan.

----------------------------------------------------
Delete All Records
----------------------------------------------------

DELETE FROM Students;

Result:

ID | Name
---|------
No Records

The table still exists,
but it is empty.

----------------------------------------------------
DELETE vs DROP TABLE
----------------------------------------------------

DELETE:

DELETE FROM Students;

- Removes all rows
- Table remains

DROP TABLE:

DROP TABLE Students;

Deletes:

- Table
- Data
- Structure

The table no longer exists.

====================================================
4. SQL SELECT TOP / LIMIT / FETCH FIRST
====================================================

These keywords limit the number
of rows returned.

Different databases use different keywords.

----------------------------------------------------
Database Keywords
----------------------------------------------------

Database     | Keyword
-------------|-------------
SQL Server   | TOP
MySQL        | LIMIT
Oracle       | FETCH FIRST

----------------------------------------------------
SQL Server
----------------------------------------------------

SELECT TOP 3 *
FROM Customers;

Returns the first 3 rows.

----------------------------------------------------
MySQL
----------------------------------------------------

SELECT *
FROM Customers
LIMIT 3;

Same result.

----------------------------------------------------
Oracle
----------------------------------------------------

SELECT *
FROM Customers
FETCH FIRST 3 ROWS ONLY;

Same result.

----------------------------------------------------
LIMIT with WHERE
----------------------------------------------------

SELECT *
FROM Customers
WHERE Country = 'Germany'
LIMIT 3;

Returns the first 3 German customers.

----------------------------------------------------
LIMIT with ORDER BY
----------------------------------------------------

SELECT *
FROM Products
ORDER BY Price DESC
LIMIT 5;

Returns the 5 most expensive products.

====================================================
5. SQL Aggregate Functions
====================================================

What are Aggregate Functions?

Aggregate functions perform calculations
on multiple rows and return one result.

----------------------------------------------------
Example Table
----------------------------------------------------

Product  | Price
---------|------
Mouse    | 20
Keyboard | 50
Monitor  | 300
Laptop   | 900

----------------------------------------------------
MIN()
----------------------------------------------------

Returns the smallest value.

SELECT MIN(Price)
FROM Products;

Output:

20

----------------------------------------------------
MAX()
----------------------------------------------------

Returns the largest value.

SELECT MAX(Price)
FROM Products;

Output:

900

----------------------------------------------------
COUNT()
----------------------------------------------------

Counts the number of rows.

SELECT COUNT(*)
FROM Products;

Output:

4

Count customers from Pakistan:

SELECT COUNT(*)
FROM Customers
WHERE Country = 'Pakistan';

----------------------------------------------------
SUM()
----------------------------------------------------

Adds all numeric values.

SELECT SUM(Price)
FROM Products;

Calculation:

20 + 50 + 300 + 900 = 1270

Output:

1270

----------------------------------------------------
AVG()
----------------------------------------------------

Returns the average.

SELECT AVG(Price)
FROM Products;

Calculation:

(20 + 50 + 300 + 900) / 4
= 317.5

Output:

317.5

----------------------------------------------------
Aggregate Functions Ignore NULL
----------------------------------------------------

Example Table:

Marks
-----
80
90
NULL
70

SELECT AVG(Marks)
FROM Students;

SQL ignores the NULL value.

Calculation:

(80 + 90 + 70) / 3 = 80

NOT:

(80 + 90 + 0 + 70) / 4

Only COUNT(*) counts every row,
including rows that contain NULL values.

====================================================
Quick Revision
====================================================

Keyword           Purpose                          Example
----------------  -------------------------------  -----------------------------------------
IS NULL           Find missing values              WHERE Email IS NULL
IS NOT NULL       Find non-missing values          WHERE Email IS NOT NULL
UPDATE            Modify existing records          UPDATE Students SET City='Lahore' WHERE ID=1;
DELETE            Delete rows                      DELETE FROM Students WHERE ID=1;
DROP TABLE        Delete entire table             DROP TABLE Students;
LIMIT (MySQL)     Return limited rows             LIMIT 5
TOP (SQL Server)  Return first rows               TOP 5
FETCH FIRST       Return first rows               FETCH FIRST 5 ROWS ONLY
MIN()             Smallest value                  MIN(Price)
MAX()             Largest value                   MAX(Price)
COUNT()           Count rows                      COUNT(*)
SUM()             Total numeric values            SUM(Price)
AVG()             Average value                   AVG(Price)

====================================================
====================================================

Remember these differences:

- NULL = Missing or unknown data
    (not 0 and not an empty string)

- UPDATE changes existing data.
    Always use a WHERE clause unless
    you intentionally want to update every row.

- DELETE removes rows, while
    DROP TABLE removes the entire table
    and its structure.

- LIMIT / TOP / FETCH FIRST all limit
    the number of rows returned, but the
    keyword depends on the database system.

- Aggregate functions
    (MIN, MAX, COUNT, SUM, AVG)
    summarize data and return a single value.

====================================================
====================================================
*/

