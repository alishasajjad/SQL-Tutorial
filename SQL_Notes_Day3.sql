/*
===========================================================
SQL THEORY NOTES - DAY 3
===========================================================



TOPIC: GROUP BY, HAVING, EXISTS, ANY, ALL, SELECT INTO
===========================================================

1. SQL GROUP BY
----------------

What is GROUP BY?

GROUP BY is used to group rows that have the same value into one group.

It is mostly used with aggregate functions like:

COUNT()
SUM()
AVG()
MIN()
MAX()

Syntax

SELECT column_name, aggregate_function(column_name)
FROM table_name
GROUP BY column_name;

Example

Customers Table

Customer    Country
Ali         Pakistan
Ahmed       Pakistan
John        USA
David       USA
Sara        UK

Query

SELECT Country, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country;

Output

Country     TotalCustomers
Pakistan    2
USA         2
UK          1

Explanation

GROUP BY makes groups like:

Pakistan
   Ali
   Ahmed

USA
   John
   David

UK
   Sara

Then COUNT() counts customers inside each group.

GROUP BY with SUM()

Example

Product     Category    Price
A           Food        20
B           Food        30
C           Drinks      40

SELECT Category,
SUM(Price)
FROM Products
GROUP BY Category;

Output

Category    SUM
Food        50
Drinks      40

GROUP BY with ORDER BY

SELECT Country,
COUNT(*) AS Total
FROM Customers
GROUP BY Country
ORDER BY Total DESC;

Countries are sorted from highest count to lowest.

===========================================================

2. SQL HAVING
-------------

What is HAVING?

HAVING filters groups after GROUP BY.

Think of it this way:

WHERE  → filters rows
HAVING → filters groups

Example

SELECT Country,
COUNT(*) AS Total
FROM Customers
GROUP BY Country
HAVING COUNT(*) > 5;

Meaning:

Show only countries that have more than 5 customers.

Example

Customers

Country
Pakistan
Pakistan
Pakistan
USA
UK

After GROUP BY

Country     Count
Pakistan    3
USA         1
UK          1

Now

HAVING COUNT(*) > 2

Output

Country     Count
Pakistan    3

WHERE vs HAVING

WHERE                       HAVING
Filters rows                Filters groups
Used before GROUP BY        Used after GROUP BY
Cannot use aggregates       Can use aggregates

Example

WHERE

SELECT *
FROM Customers
WHERE Country='Pakistan';

Returns only Pakistani customers.

HAVING

SELECT Country,
COUNT(*)
FROM Customers
GROUP BY Country
HAVING COUNT(*) > 5;

Returns only countries having more than 5 customers.

===========================================================

3. SQL EXISTS
-------------

What is EXISTS?

EXISTS checks whether a subquery returns at least one row.

If yes → TRUE

If no → FALSE

Syntax

SELECT column
FROM table
WHERE EXISTS
(
   subquery
);

Example

Suppliers

SupplierID     Name
1              ABC
2              XYZ

Products

SupplierID     Price
1              5
2              20

Query

SELECT SupplierName
FROM Suppliers
WHERE EXISTS
(
SELECT *
FROM Products
WHERE Products.SupplierID = Suppliers.SupplierID
AND Price < 10
);

Output

ABC

Because only supplier ABC has a product cheaper than 10.

Memory Trick

EXISTS

=

Does at least one record exist?

===========================================================

4. SQL ANY
----------

What is ANY?

ANY returns TRUE if at least one value from the subquery satisfies the condition.

Think:

ANY

=

At least one

Example

SELECT ProductName
FROM Products
WHERE ProductID = ANY
(
SELECT ProductID
FROM OrderDetails
WHERE Quantity = 10
);

Meaning

Show products whose ProductID matches any ProductID returned by the subquery.

Example

Subquery returns

2
5
9

Main query

WHERE ProductID = ANY (2,5,9)

Equivalent to

WHERE ProductID = 2
OR ProductID = 5
OR ProductID = 9

===========================================================

5. SQL ALL
----------

What is ALL?

ALL returns TRUE only if every value from the subquery satisfies the condition.

Think

ALL

=

Every value

Example

Subquery returns

2
5
9

Query

WHERE ProductID > ALL
(
2,5,9
)

Means

ProductID > 2

AND

ProductID > 5

AND

ProductID > 9

So only ProductIDs greater than 9 will be selected.

ANY vs ALL

ANY                         ALL
At least one value          Every value
Similar to OR               Similar to AND

===========================================================

6. SQL SELECT INTO
------------------

What is SELECT INTO?

SELECT INTO creates a new table and copies data from an existing table.

Syntax

SELECT *
INTO NewTable
FROM OldTable;

Example

SELECT *
INTO CustomersBackup
FROM Customers;

This creates a new table:

CustomersBackup

and copies all customer records into it.

Copy only selected columns

SELECT CustomerName,
ContactName
INTO Customers2
FROM Customers;

Only these two columns are copied.

Copy with condition

SELECT *
INTO US_Customers
FROM Customers
WHERE Country = 'USA';

Only USA customers are copied.

Create an Empty Table

SELECT *
INTO NewTable
FROM Customers
WHERE 1 = 0;

Since 1 = 0 is always false:

Table is created.
No data is copied.

===========================================================

--------------

GROUP BY
Groups rows with the same value.
Used with COUNT(), SUM(), AVG(), MIN(), MAX().

SELECT Country,
COUNT(*)
FROM Customers
GROUP BY Country;

HAVING
Filters groups after GROUP BY.
Works with aggregate functions.

HAVING COUNT(*) > 5;

EXISTS
Returns TRUE if the subquery returns at least one row.

WHERE EXISTS (subquery);

ANY
TRUE if at least one value matches.

WHERE ProductID = ANY (subquery);

ALL
TRUE only if every value matches.

WHERE Price > ALL (subquery);

SELECT INTO
Creates a new table from an existing table.

SELECT *
INTO BackupTable
FROM Customers;

===========================================================

-------------

GROUP BY    → Group similar rows
HAVING      → Filter groups
EXISTS      → At least one row exists
ANY         → One is enough
ALL         → Every value must satisfy
SELECT INTO → Create a new table and copy data

===========================================================

===========================================================
*/


/*
===========================================================
SQL 
TOPIC: INSERT INTO SELECT, CASE, NULL FUNCTIONS,
       STORED PROCEDURES, COMMENTS, OPERATORS
===========================================================

1. SQL INSERT INTO SELECT
-------------------------

What is it?

INSERT INTO SELECT copies data from one existing table into another existing table.

Source table = where data comes from
Target table = where data is inserted

Unlike SELECT INTO, this does not create a new table.

Syntax

INSERT INTO target_table
SELECT * FROM source_table;

Example

Suppliers

SupplierName    City      Country
ABC             Berlin    Germany
XYZ             London    UK

Customers

Initially

CustomerName    City      Country

Run:

INSERT INTO Customers(CustomerName, City, Country)
SELECT SupplierName, City, Country
FROM Suppliers;

Now Customers becomes

CustomerName    City      Country
ABC             Berlin    Germany
XYZ             London    UK

Copy only German suppliers

INSERT INTO Customers(CustomerName, City, Country)
SELECT SupplierName, City, Country
FROM Suppliers
WHERE Country='Germany';

Only German records will be copied.

Difference

SELECT INTO

Creates a new table

SELECT * INTO BackupCustomers
FROM Customers;

INSERT INTO SELECT

Copies data into an existing table

INSERT INTO BackupCustomers
SELECT *
FROM Customers;

===========================================================

2. SQL CASE
-----------

CASE works like if-else.

Syntax

CASE
WHEN condition THEN result
WHEN condition THEN result
ELSE result
END

Example

Products

Product     Price
Milk        10
Laptop      700

Query

SELECT ProductName,
Price,
CASE
WHEN Price < 20 THEN 'Cheap'
WHEN Price <= 100 THEN 'Medium'
ELSE 'Expensive'
END AS Category
FROM Products;

Output

Product     Price     Category
Milk        10        Cheap
Laptop      700       Expensive

Think of CASE like:

if Price < 20
    Cheap

else if Price <= 100
    Medium

else
    Expensive

===========================================================

3. SQL NULL Functions
---------------------

NULL means

Missing value

Not 0.

Not empty string.

Unknown.

Example

Product     Stock     Ordered
Milk        20        NULL

Now

Stock + Ordered

becomes

20 + NULL = NULL

Not 20.

COALESCE()

Most common function.

COALESCE(value, replacement)

Example

SELECT
Price * (Stock + COALESCE(Ordered,0))
FROM Products;

If Ordered is NULL

replace it with 0.

MySQL

IFNULL(Ordered,0)

SQL Server

ISNULL(Ordered,0)

Oracle

NVL(Ordered,0)

All do the same thing.

===========================================================

4. Stored Procedure
-------------------

A Stored Procedure is a saved SQL query.

Instead of writing the same query repeatedly, save it once.

Example

Without procedure

SELECT *
FROM Customers
WHERE City='London';

Write again...

Again...

Again...

Instead

CREATE PROCEDURE GetCustomers
AS
BEGIN
SELECT *
FROM Customers;
END;

Run anytime

EXEC GetCustomers;

Procedure with parameter

CREATE PROCEDURE GetCustomer
@City nvarchar(50)
AS
BEGIN

SELECT *
FROM Customers
WHERE City=@City;

END;

Execute

EXEC GetCustomer @City='London';

Returns only London customers.

Benefits

Faster
Reusable
More secure
Easier maintenance

===========================================================

5. SQL Comments
---------------

Comments are ignored by SQL.

Used for explanation.

Single line

-- Select German customers

SELECT *
FROM Customers;

Multiple lines

/*
This query
shows German
customers
*/



/*
SELECT *
FROM Customers;

Useful while debugging.

===========================================================

6. SQL Operators
----------------

Operators perform calculations or comparisons.

Arithmetic Operators

Operator     Meaning
+            Addition
-            Subtraction
*            Multiply
/            Divide
%            Remainder

Example

SELECT Price * Quantity
FROM Orders;

-----------------------------------------------------------

Comparison Operators

Operator     Meaning
=            Equal
>            Greater
<            Less
>=           Greater or equal
<=           Less or equal
<>           Not equal

Example

SELECT *
FROM Products
WHERE Price > 100;

-----------------------------------------------------------

Logical Operators

AND

Both conditions must be true.

SELECT *
FROM Customers
WHERE Country='USA'
AND City='New York';

Think

USA ✓
New York ✓

Return row.

-----------------------------------------------------------

OR

At least one condition must be true.

WHERE Country='USA'
OR Country='UK'

-----------------------------------------------------------

NOT

Reverse the condition.

WHERE NOT Country='USA'

Returns every country except USA.

-----------------------------------------------------------

IN

WHERE Country IN ('USA','UK','Germany')

Same as

Country='USA'
OR Country='UK'
OR Country='Germany'

-----------------------------------------------------------

BETWEEN

WHERE Price BETWEEN 20 AND 50

Means

20 <= Price <= 50

-----------------------------------------------------------

LIKE

Pattern matching

'A%'

Starts with A

'%A'

Ends with A

'%A%'

Contains A

-----------------------------------------------------------

EXISTS

Checks whether a subquery returns at least one row.

SELECT *
FROM Customers
WHERE EXISTS
(
SELECT *
FROM Orders
WHERE Orders.CustomerID = Customers.CustomerID
);

Returns customers who have at least one order.

-----------------------------------------------------------

ANY

True if at least one value satisfies the condition.

Example

WHERE ProductID = ANY
(
SELECT ProductID
FROM OrderDetails
WHERE Quantity = 10
)

If even one ProductID matches, it returns the row.

-----------------------------------------------------------

ALL

True only if every value satisfies the condition.

Example

WHERE ProductID = ALL(...)

All returned values must satisfy the condition.

-----------------------------------------------------------

ANY vs ALL (Easy Trick)

Suppose the subquery returns:

10
20
30

ANY

At least ONE must match.

Like asking:

"Did any student pass the exam?"

Even one pass → TRUE.

ALL

EVERY value must match.

Like asking:

"Did all students pass the exam?"

One failure → FALSE.

===========================================================

--------------------

Topic                                   Purpose

INSERT INTO SELECT                      Copy data into an existing table
SELECT INTO                             Create a new table and copy data
CASE                                    SQL version of if-else
COALESCE / IFNULL / ISNULL              Replace NULL values
Stored Procedure                        Save SQL queries for reuse
Comments                                Explain or temporarily disable SQL code
Arithmetic Operators                    +, -, *, /, %
Comparison Operators                    =, >, <, <>
Logical Operators                       AND, OR, NOT, IN, LIKE,
                                        BETWEEN, EXISTS, ANY, ALL

===========================================================
===========================================================
*/



/*
===========================================================
SQL 
TOPIC: CREATE DATABASE, DROP DATABASE,
       BACKUP DATABASE, CREATE TABLE,
       DROP TABLE, TRUNCATE TABLE
===========================================================

1. SQL CREATE DATABASE
----------------------

What is it?

CREATE DATABASE is used to create a new database.

Think of a database as a folder that stores tables.

Syntax

CREATE DATABASE database_name;

Example

CREATE DATABASE SchoolDB;

Now a new database named SchoolDB is created.

Check Databases

MySQL

SHOW DATABASES;

Output

information_schema
mysql
SchoolDB
test

SQL Server

SELECT name
FROM sys.databases;

===========================================================

2. SQL DROP DATABASE
--------------------

What is it?

Deletes an entire database permanently.

⚠ Everything inside it is deleted:

Tables
Data
Views
Stored Procedures

Syntax

DROP DATABASE database_name;

Example

DROP DATABASE SchoolDB;

Now SchoolDB no longer exists.

Remember

Command              Result
CREATE DATABASE      Creates a database
DROP DATABASE        Deletes the entire database

===========================================================

3. SQL BACKUP DATABASE
----------------------

What is it?

Creates a backup (copy) of your database.

If your database crashes, you can restore it from the backup.

Syntax

BACKUP DATABASE database_name
TO DISK = 'filepath';

Example

BACKUP DATABASE SchoolDB
TO DISK='D:\Backups\SchoolDB.bak';

A backup file named SchoolDB.bak is created.

Differential Backup

Instead of copying the entire database again, SQL copies only the changes made since the last full backup.

Example

BACKUP DATABASE SchoolDB
TO DISK='D:\Backups\SchoolDB.bak'
WITH DIFFERENTIAL;

Difference

Full Backup                 Differential Backup
Copies whole database       Copies only changed data
Takes more time             Faster
Larger file                 Smaller file

===========================================================

4. SQL CREATE TABLE
-------------------

What is it?

Creates a new table inside a database.

Think of a table like an Excel spreadsheet.

Example

Students
------------------------
ID
Name
Age
City

Syntax

CREATE TABLE table_name(
    column datatype constraint
);

Example

CREATE TABLE Students(
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    City VARCHAR(50)
);

This creates the table:

StudentID     Name     Age     City

Initially, it is empty.

Understanding the Data Types

StudentID INT

Stores integers.

Example

1
2
3

VARCHAR(100)

Stores text up to 100 characters.

Example

Ali
Ahmed
Sarah

Constraints Used

PRIMARY KEY

Every row must have a unique ID.

Example

ID     Name
1      Ali
2      Sara

You cannot insert another row with ID = 1.

NOT NULL

The value cannot be empty.

Name VARCHAR(100) NOT NULL

Allowed

Ali

Not Allowed

NULL

Create Table from Existing Table

Instead of creating an empty table, copy data from another table.

Example

CREATE TABLE GermanCustomers AS
SELECT *
FROM Customers
WHERE Country='Germany';

Now

Customers

↓

Copies only German customers into

GermanCustomers

===========================================================

5. SQL DROP TABLE
-----------------

What is it?

Deletes an entire table permanently.

Everything is removed.

Structure
Rows
Columns
Data

Syntax

DROP TABLE table_name;

Example

DROP TABLE Students;

The Students table is gone forever.

Safer Version

DROP TABLE IF EXISTS Students;

If the table doesn't exist, SQL won't throw an error.

DROP TABLE vs DROP DATABASE

DROP TABLE                  DROP DATABASE
Deletes one table           Deletes whole database
Other tables remain         Everything is deleted

===========================================================

6. SQL TRUNCATE TABLE
---------------------

What is it?

Deletes all rows from a table, but keeps the table itself.

Syntax

TRUNCATE TABLE table_name;

Example

Before

ID     Name
1      Ali
2      Sara
3      Ahmed

Run

TRUNCATE TABLE Students;

After

ID     Name

The table still exists, but it has no rows.

DELETE vs TRUNCATE vs DROP

This is one of the most important interview questions.

Feature             DELETE      TRUNCATE      DROP
Deletes rows        Yes         Yes           No
Deletes all rows    Optional    Always        Entire table
WHERE allowed       Yes         No            No
Table remains       Yes         Yes           No
Structure remains   Yes         Yes           No
Faster              No          Yes           Fastest

Example

DELETE

DELETE FROM Students
WHERE Age > 20;

Only students older than 20 are deleted.

TRUNCATE

TRUNCATE TABLE Students;

All rows are deleted, but the table remains.

DROP

DROP TABLE Students;

The table itself is deleted.

===========================================================

--------------

Command                         Purpose

CREATE DATABASE                 Create a new database
DROP DATABASE                   Delete an entire database
BACKUP DATABASE                 Create a backup of a database
CREATE TABLE                    Create a new table
CREATE TABLE AS SELECT          Create a new table from existing table
DROP TABLE                      Delete a table permanently
TRUNCATE TABLE                  Remove all rows but keep structure

===========================================================


-----------------

CREATE   → Make something new.

DROP     → Remove everything
           (database or table).

TRUNCATE → Empty the table,
           but keep it.

DELETE   → Remove selected rows
           (or all rows).

BACKUP   → Save a copy of the database.

===========================================================
===========================================================
*/


-- ==========================================
-- SQL ALTER TABLE & CONSTRAINTS 
-- ==========================================

/*
==================================================
1. ALTER TABLE
==================================================

What is ALTER TABLE?

ALTER TABLE is used to change an existing table.

Imagine you already created a table.

Later you realize:

• You forgot a column.
• You want to remove a column.
• You want to rename a column.
• You want to change a data type.

Instead of deleting the table and creating it again,
we use ALTER TABLE.

--------------------------------------------------
Example Table
--------------------------------------------------

Students

ID    Name    Age
--------------------
1     Ali     20
2     Sara    21

--------------------------------------------------
ADD COLUMN
--------------------------------------------------

Suppose later you decide to store Email.

ALTER TABLE Students
ADD Email VARCHAR(100);

Now table becomes

ID   Name   Age   Email
----------------------------
1    Ali    20
2    Sara   21

Email column is added.

--------------------------------------------------
DROP COLUMN
--------------------------------------------------

Suppose Email is no longer needed.

ALTER TABLE Students
DROP COLUMN Email;

Now Email disappears.

ID   Name   Age
---------------
1    Ali    20
2    Sara   21

--------------------------------------------------
RENAME COLUMN
--------------------------------------------------

Suppose you don't like the name "Name".

You want "StudentName".

ALTER TABLE Students
RENAME COLUMN Name TO StudentName;

Result

ID   StudentName   Age
-----------------------
1      Ali         20

--------------------------------------------------
MODIFY COLUMN
--------------------------------------------------

Suppose Age was INT.

Now you want BIGINT or another datatype.

ALTER TABLE Students
MODIFY Age BIGINT;

or SQL Server

ALTER TABLE Students
ALTER COLUMN Age BIGINT;

The datatype changes.

--------------------------------------------------
Rename Table
--------------------------------------------------

ALTER TABLE Students
RENAME TO CollegeStudents;

Old

Students

New

CollegeStudents

--------------------------------------------------
Summary of ALTER TABLE
--------------------------------------------------

Command          Purpose
------------------------------------------
ADD              Add new column
DROP COLUMN      Delete column
MODIFY           Change datatype
RENAME COLUMN    Change column name
RENAME TO        Change table name


==================================================
2. SQL Constraints
==================================================

What are Constraints?

Constraints are rules.

They make sure users cannot insert invalid data.

Think of them as security guards.

Example:

Without constraints

Age = -10

Database accepts it.

Wrong!

With constraints

Age must be >=18

Database rejects invalid values.

--------------------------------------------------
Types of Constraints
--------------------------------------------------

The main ones are:

• NOT NULL
• UNIQUE
• PRIMARY KEY
• FOREIGN KEY
• CHECK
• DEFAULT
• INDEX

Let's understand them one by one.


==================================================
3. NOT NULL
==================================================

Normally a column can contain NULL.

Example

Name
-------
Ali
NULL
Sara

Sometimes this isn't acceptable.

Every student must have a name.

So we use

Name VARCHAR(50) NOT NULL

Now

INSERT INTO Students(Name)
VALUES(NULL);

❌ Error

Because NULL isn't allowed.

--------------------------------------------------
Example
--------------------------------------------------

CREATE TABLE Students
(
ID INT,
Name VARCHAR(50) NOT NULL
);

Valid

INSERT INTO Students
VALUES(1,'Ali');

Invalid

INSERT INTO Students
VALUES(2,NULL);

--------------------------------------------------
Adding NOT NULL Later
--------------------------------------------------

ALTER TABLE Students
MODIFY Name VARCHAR(50) NOT NULL;

Now Name cannot be empty.

--------------------------------------------------
Removing NOT NULL
--------------------------------------------------

ALTER TABLE Students
MODIFY Name VARCHAR(50) NULL;

Now NULL is allowed again.


==================================================
4. UNIQUE Constraint
==================================================

Purpose

No duplicate values.

Example

Suppose Email must be unique.

Wrong

Ali
ali@gmail.com

Sara
ali@gmail.com

Two users have the same email.

Impossible.

Use

Email VARCHAR(100) UNIQUE

Now duplicates aren't allowed.

--------------------------------------------------
Example
--------------------------------------------------

CREATE TABLE Students
(
ID INT,
Email VARCHAR(100) UNIQUE
);

Insert

Ali
ali@gmail.com

Works.

Insert

Sara
ali@gmail.com

❌ Error

Duplicate Email.

--------------------------------------------------
Multiple Column UNIQUE
--------------------------------------------------

UNIQUE(ID, Name)

Now the combination must be unique.

Example

Allowed

1 Ali
2 Ali
1 Sara

Not allowed

1 Ali
1 Ali

Because both columns match.

--------------------------------------------------
Naming Constraints
--------------------------------------------------

Instead of automatic names

CONSTRAINT UC_Student UNIQUE(Email)

Now the constraint has a readable name.

--------------------------------------------------
Adding UNIQUE Later
--------------------------------------------------

ALTER TABLE Students
ADD UNIQUE(Email);

--------------------------------------------------
Removing UNIQUE
--------------------------------------------------

ALTER TABLE Students
DROP CONSTRAINT UC_Student;

(SQL Server)

or

ALTER TABLE Students
DROP INDEX UC_Student;

(MySQL)


==================================================
Difference Between NOT NULL and UNIQUE
==================================================

NOT NULL                    UNIQUE
------------------------------------------------
Cannot be empty             Cannot have duplicate values
NULL not allowed            Duplicate values not allowed
Many rows can have          Every value must be different
different values

Example

Email

NOT NULL

Ali@gmail.com
Sara@gmail.com
NULL ❌

UNIQUE

Ali@gmail.com
Sara@gmail.com
Ali@gmail.com ❌


==================================================
Difference Between UNIQUE and PRIMARY KEY
==================================================

Many students confuse these.

PRIMARY KEY

• Only one per table.
• Cannot be NULL.
• Must be UNIQUE.

Example

StudentID

1
2
3

--------------------------------------------------
UNIQUE
--------------------------------------------------

• Can have multiple UNIQUE constraints in one table.
• Ensures values are unique.
• Depending on the database, it may allow NULL values.

Example

Email UNIQUE

Phone UNIQUE

Both columns are unique.

--------------------------------------------------
Comparison
--------------------------------------------------

PRIMARY KEY               UNIQUE
------------------------------------------------
Only one per table        Many allowed
Unique                    Unique
Cannot be NULL            May allow NULL (depends on DBMS)
Identifies each row       Prevents duplicates


==================================================
Real-Life Example
==================================================

Imagine a university database.

Students

StudentID
Name
Email
Phone

Rules:

• StudentID must always exist and be unique → PRIMARY KEY
• Email cannot repeat → UNIQUE
• Phone cannot repeat → UNIQUE
• Name cannot be empty → NOT NULL

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15) UNIQUE
);

This combination is very common in real-world databases.


==================================================
==================================================

Topic           Purpose
------------------------------------------------
ALTER TABLE     Modify an existing table
ADD             Add a new column
DROP COLUMN     Delete a column
MODIFY / ALTER COLUMN
                Change datatype or constraints
RENAME COLUMN   Rename a column
RENAME TO       Rename the table
Constraints     Rules that protect data integrity
NOT NULL        Column cannot contain NULL values
UNIQUE          Prevents duplicate values
PRIMARY KEY     Unique identifier for each row
                (NOT NULL + UNIQUE)

*/



