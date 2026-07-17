-- ==========================================
-- SQL Tutorial - Day 4
-- ==========================================


-- ==========================================
-- SQL PRIMARY KEY, FOREIGN KEY, CHECK,
-- DEFAULT, INDEX & AUTO_INCREMENT
-- ==========================================

/*
==================================================
1. PRIMARY KEY
==================================================

What is a PRIMARY KEY?

A PRIMARY KEY is a column (or group of columns)
that uniquely identifies each row in a table.

Think of it as a person's CNIC.

Every citizen has a unique CNIC.

Similarly, every row should have a unique ID.

--------------------------------------------------
Example
--------------------------------------------------

Students Table

StudentID    Name    Age
----------------------------
1            Ali     20
2            Sara    21
3            Ahmed   19

Here,

StudentID is the PRIMARY KEY.

No two students can have the same StudentID.

--------------------------------------------------
Rules of PRIMARY KEY
--------------------------------------------------

A Primary Key:

Must be unique.
Cannot be NULL.
Only ONE Primary Key per table.
Automatically behaves like UNIQUE + NOT NULL.

Think of it as:

PRIMARY KEY = UNIQUE + NOT NULL

--------------------------------------------------
Creating a PRIMARY KEY
--------------------------------------------------

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT
);

--------------------------------------------------
Valid Inserts
--------------------------------------------------

INSERT INTO Students
VALUES (1,'Ali',20);

INSERT INTO Students
VALUES (2,'Sara',21);

Works perfectly.

--------------------------------------------------
Invalid (Duplicate)
--------------------------------------------------

INSERT INTO Students
VALUES (1,'Ahmed',19);

Error

Because StudentID = 1 already exists.

--------------------------------------------------
Invalid (NULL)
--------------------------------------------------

INSERT INTO Students
VALUES (NULL,'Ali',20);

Error

Primary Key cannot be NULL.

--------------------------------------------------
Composite PRIMARY KEY
--------------------------------------------------

Sometimes one column isn't enough.

Example

StudentID    CourseID
-----------------------
1            CS101
1            CS102
2            CS101

Here StudentID repeats.

CourseID repeats.

But together

(StudentID, CourseID)

is always unique.

PRIMARY KEY(StudentID, CourseID)

This is called a Composite Primary Key.


==================================================
2. FOREIGN KEY
==================================================

This is probably the most important concept
in relational databases.

--------------------------------------------------
What is a FOREIGN KEY?
--------------------------------------------------

A FOREIGN KEY creates a relationship
between two tables.

It tells SQL:

"This value must already exist
in another table."

--------------------------------------------------
Example
--------------------------------------------------

Students Table (Parent)

StudentID    Name
-------------------
1            Ali
2            Sara

StudentID is PRIMARY KEY.

--------------------------------------------------
Orders Table (Child)
--------------------------------------------------

OrderID    StudentID
---------------------
101        1
102        2

StudentID here is a FOREIGN KEY.

--------------------------------------------------
Relationship
--------------------------------------------------

Students
---------

StudentID (PK)

1
2

      │
      │
      ▼

Orders
--------

OrderID
StudentID (FK)

101 -> 1
102 -> 2

The Foreign Key always points
to a Primary Key.

--------------------------------------------------
Creating a FOREIGN KEY
--------------------------------------------------

CREATE TABLE Orders(
    OrderID INT PRIMARY KEY,
    StudentID INT,

    FOREIGN KEY(StudentID)
    REFERENCES Students(StudentID)
);

--------------------------------------------------
Valid Insert
--------------------------------------------------

Students table

1
2
3

Now

INSERT INTO Orders
VALUES(101,2);

Works.

Because StudentID 2 exists.

--------------------------------------------------
Invalid Insert
--------------------------------------------------

INSERT INTO Orders
VALUES(101,8);

Error

Student 8 doesn't exist.

--------------------------------------------------
Prevents Deleting Parent Data
--------------------------------------------------

Suppose

Students

StudentID    Name
------------------
1            Ali

Orders

OrderID    StudentID
---------------------
101        1

Now

DELETE FROM Students
WHERE StudentID=1;

Error

Because Orders still refers
to StudentID = 1.

This prevents broken relationships.

--------------------------------------------------
Parent and Child Tables
--------------------------------------------------

Students
---------
Primary Key

        │

        ▼

Orders
---------
Foreign Key

Parent = Students

Child = Orders

--------------------------------------------------
PRIMARY KEY vs FOREIGN KEY
--------------------------------------------------

PRIMARY KEY                     FOREIGN KEY
---------------------------------------------------------
Uniquely identifies a row       Refers to another table's
                                Primary Key

Only one per table              Many Foreign Keys allowed

Cannot be NULL                  Can be NULL
                                (unless specified NOT NULL)

Must be unique                  Duplicates are allowed


==================================================
3. CHECK Constraint
==================================================

Purpose

Restricts values using a condition.

--------------------------------------------------
Example
--------------------------------------------------

Age should never be less than 18.

Instead of trusting users,

SQL checks it automatically.

--------------------------------------------------
Example
--------------------------------------------------

CREATE TABLE Students(

ID INT PRIMARY KEY,

Age INT CHECK(Age>=18)

);

--------------------------------------------------
Valid
--------------------------------------------------

INSERT INTO Students
VALUES(1,20);

Works.

--------------------------------------------------
Invalid
--------------------------------------------------

INSERT INTO Students
VALUES(2,15);

Error

Because

15 >=18

False

--------------------------------------------------
Another Example
--------------------------------------------------

Salary

CHECK(Salary>0)

Quantity

CHECK(Quantity>=1)

Marks

CHECK(Marks BETWEEN 0 AND 100)


==================================================
4. DEFAULT Constraint
==================================================

Purpose

Provides a default value when the user
doesn't supply one.

--------------------------------------------------
Without DEFAULT
--------------------------------------------------

INSERT INTO Students(Name)

VALUES('Ali');

City becomes

NULL

--------------------------------------------------
With DEFAULT
--------------------------------------------------

City VARCHAR(50)
DEFAULT 'Lahore'

Now

INSERT INTO Students(Name)

VALUES('Ali');

Result

Name    City
---------------
Ali     Lahore

SQL inserted Lahore automatically.

--------------------------------------------------
Example
--------------------------------------------------

CREATE TABLE Students(

ID INT PRIMARY KEY,

City VARCHAR(100)
DEFAULT 'Lahore'

);

--------------------------------------------------
Another Example
--------------------------------------------------

Automatically store today's date.

OrderDate DATE
DEFAULT CURRENT_DATE

Now every new order automatically
gets today's date.


==================================================
5. CREATE INDEX
==================================================

Why do we need Indexes?

Imagine a book.

--------------------------------------------------
Without index
--------------------------------------------------

You search page by page.

Very slow.

--------------------------------------------------
With index
--------------------------------------------------

Go directly to the page.

Much faster.

Database indexes work exactly the same.

--------------------------------------------------
Without Index
--------------------------------------------------

Searching

Ali

Database checks

Row1

Row2

Row3

...

Row1000000

Very slow.

--------------------------------------------------
With Index
--------------------------------------------------

Database jumps directly to

Ali

Very fast.

--------------------------------------------------
Create Index
--------------------------------------------------

CREATE INDEX idx_name

ON Students(Name);

Now searching by Name becomes faster.

--------------------------------------------------
Unique Index
--------------------------------------------------

CREATE UNIQUE INDEX idx_email

ON Students(Email);

Now Email must also be unique.

--------------------------------------------------
Drawback
--------------------------------------------------

Indexes improve SELECT performance.

But

INSERT

UPDATE

DELETE

become slightly slower because SQL
must update the index too.

So only create indexes on columns
that are searched frequently.


==================================================
6. AUTO_INCREMENT
==================================================

Normally

INSERT INTO Students

VALUES(?,?,?)

You must manually write

1
2
3
4

Very annoying.

AUTO_INCREMENT solves this.

--------------------------------------------------
Example
--------------------------------------------------

CREATE TABLE Students(

StudentID INT AUTO_INCREMENT PRIMARY KEY,

Name VARCHAR(100)

);

Now

INSERT INTO Students(Name)

VALUES('Ali');

Database stores

StudentID    Name
------------------
1            Ali

--------------------------------------------------
Next
--------------------------------------------------

INSERT INTO Students(Name)

VALUES('Sara');

Database stores

StudentID    Name
------------------
2            Sara

--------------------------------------------------
Next
--------------------------------------------------

INSERT INTO Students(Name)

VALUES('Ahmed');

Database stores

StudentID    Name
------------------
3            Ahmed

SQL automatically generates IDs.

--------------------------------------------------
SQL Server
--------------------------------------------------

Instead of AUTO_INCREMENT

IDENTITY(1,1)

means

Start from 1

Increase by 1

Example

StudentID INT IDENTITY(1,1)


==================================================
Real-World Example
==================================================

CREATE TABLE Students(

StudentID INT AUTO_INCREMENT PRIMARY KEY,

Name VARCHAR(100) NOT NULL,

Email VARCHAR(100) UNIQUE,

Age INT CHECK(Age>=18),

City VARCHAR(100) DEFAULT 'Lahore'

);

This table enforces several rules:

• AUTO_INCREMENT → StudentID is generated automatically.
• PRIMARY KEY → StudentID is unique and cannot be NULL.
• NOT NULL → Name is required.
• UNIQUE → No two students can have the same Email.
• CHECK → Age must be at least 18.
• DEFAULT → If City isn't provided, it becomes "Lahore" automatically.


==================================================
==================================================

Constraint          Purpose
------------------------------------------------------------
PRIMARY KEY         Unique identity of each row
                    Example: StudentID

FOREIGN KEY         Links one table to another
                    Example:
                    Orders.StudentID
                    → Students.StudentID

CHECK              Restricts allowed values
                   Example:
                   Age >= 18

DEFAULT            Inserts a value automatically
                   if none is provided
                   Example:
                   City = 'Lahore'

CREATE INDEX       Speeds up searches
                   Example:
                   Index on Name

AUTO_INCREMENT     Generates IDs automatically
                   Example:
                   1, 2, 3, 4...


==================================================
==================================================

PRIMARY KEY
→ "Who am I?"
(Unique identity)

FOREIGN KEY
→ "Who is my parent?"
(Relationship)

CHECK
→ "Is this value valid?"
(Validation)

DEFAULT
→ "Use this if nothing is given."
(Fallback value)

INDEX
→ "Find data faster."
(Performance)

AUTO_INCREMENT
→ "Generate IDs automatically."
(Convenience)

*/


-- ==========================================
-- SQL Working With Dates, Views,
-- SQL Injection, Parameters,
-- Prepared Statements & SQL Hosting
-- ==========================================

/*
==================================================
1. SQL Working With Dates
==================================================

What are SQL Dates?

A date stores calendar information such as:

• Year
• Month
• Day

Example:

2025-11-11

Some data types also store time.

Example:

2025-11-11 13:23:44

--------------------------------------------------
Common Date Data Types
--------------------------------------------------

Data Type      Stores
------------------------------------
DATE           Only date
TIME           Only time
DATETIME       Date + Time
TIMESTAMP      Date + Time
YEAR           Only year

Example:

2025-07-17
14:30:45
2025-07-17 14:30:45

--------------------------------------------------
Selecting a Date
--------------------------------------------------

Orders Table

OrderID    Product    OrderDate
-----------------------------------
1          Laptop     2025-11-11
2          Mouse      2025-11-09

Query

SELECT *
FROM Orders
WHERE OrderDate='2025-11-11';

Output

Laptop

--------------------------------------------------
Problem with DateTime
--------------------------------------------------

Suppose table contains

2025-11-11 10:30:15

If you write

SELECT *
FROM Orders
WHERE OrderDate='2025-11-11';

Result

No rows

Because SQL compares

2025-11-11

with

2025-11-11 10:30:15

They are not exactly equal.

--------------------------------------------------
Remember
--------------------------------------------------

Use DATE when possible.

Only use DATETIME if time is important.


==================================================
2. SQL Views
==================================================

What is a View?

A View is a virtual table.

It does not store data.

Instead, it stores a SELECT query.

Imagine:

Table
 ↓
SELECT Query
 ↓
View

--------------------------------------------------
Why use Views?
--------------------------------------------------

Instead of writing this every day

SELECT Name,City
FROM Customers
WHERE Country='Brazil';

Create a View once.

--------------------------------------------------
Create View
--------------------------------------------------

CREATE VIEW BrazilCustomers AS
SELECT CustomerName, ContactName
FROM Customers
WHERE Country='Brazil';

--------------------------------------------------
Use View
--------------------------------------------------

Now simply write

SELECT *
FROM BrazilCustomers;

Same output every time.

--------------------------------------------------
Update View
--------------------------------------------------

SQL Server

ALTER VIEW BrazilCustomers AS
SELECT CustomerName,
       ContactName,
       City
FROM Customers
WHERE Country='Brazil';

--------------------------------------------------
Delete View
--------------------------------------------------

DROP VIEW BrazilCustomers;

--------------------------------------------------
Remember
--------------------------------------------------

View

✔ Saves SQL queries

✔ Simplifies complex queries

✔ Shows latest data automatically


==================================================
3. SQL Injection
==================================================

This is one of the most important security topics.

Suppose website login uses

SELECT *
FROM Users
WHERE Username='Ali'
AND Password='123';

Looks fine.

--------------------------------------------------
Hacker Input
--------------------------------------------------

Instead of username

Ali

Hacker enters

' OR 1=1 --

SQL becomes

SELECT *
FROM Users
WHERE Username=''
OR 1=1;

Since

1=1

is always TRUE,

SQL returns

ALL USERS

The hacker logs in.

--------------------------------------------------
Another example
--------------------------------------------------

User enters

105 OR 1=1

SQL becomes

SELECT *
FROM Users
WHERE UserID=105
OR 1=1;

Again

Everything is returned.

--------------------------------------------------
Even worse
--------------------------------------------------

105;
DROP TABLE Users;

If allowed,

SQL executes

SELECT *
FROM Users;

DROP TABLE Users;

The table is deleted.

--------------------------------------------------
SQL Injection Summary
--------------------------------------------------

Bad user input

↓

Changes SQL query

↓

Reads or deletes database


==================================================
4. SQL Parameters
==================================================

How do we stop SQL Injection?

Use Parameters.

Instead of

SELECT *
FROM Users
WHERE UserID=" + userInput

Use

SELECT *
FROM Users
WHERE UserID=@userid;

Then

@userid

gets the value safely.

Even if user enters

1 OR 1=1

SQL treats it as plain text.

No injection.

--------------------------------------------------
Example
--------------------------------------------------

SELECT *
FROM Users
WHERE Name=@name;

Application sends

@name="Ali"

Safe.


==================================================
5. Prepared Statements
==================================================

Prepared Statements work like Parameters.

--------------------------------------------------
Process
--------------------------------------------------

Step 1

Prepare SQL

INSERT INTO Students
VALUES(?,?,?)

Question marks are placeholders.

--------------------------------------------------
Step 2
--------------------------------------------------

Later provide values

Ali

22

Lahore

Database safely inserts them.

--------------------------------------------------
Advantages
--------------------------------------------------

✔ Faster

✔ Reusable

✔ Prevent SQL Injection

✔ Cleaner code

--------------------------------------------------
Example
--------------------------------------------------

INSERT INTO Students
VALUES(?,?,?)

Later

?

Ali

?

22

?

Lahore


==================================================
6. SQL Hosting
==================================================

Hosting means

Where your database lives.

Example

Website

↓

Database Server

↓

MySQL

or

SQL Server

Oracle

PostgreSQL

--------------------------------------------------
Popular Databases
--------------------------------------------------

MySQL

✔ Fast

✔ Free

✔ Very popular

--------------------------------------------------

SQL Server

✔ Microsoft

✔ Enterprise applications

✔ Strong security

--------------------------------------------------

Oracle

✔ Very powerful

✔ Large companies

✔ Expensive

--------------------------------------------------

PostgreSQL

✔ Free

✔ Open Source

✔ Advanced features


==================================================
==================================================

Topic                 Purpose
------------------------------------------------------------
DATE                  Store date/time values

VIEW                  Virtual table based on a
                      SELECT query

SQL Injection         Malicious SQL entered
                      by attackers

Parameters            Safely pass user input
                      to queries

Prepared Statements   Precompiled parameterized
                      queries for security and
                      performance

Hosting               Database server where
                      your database is stored


==================================================
Interview Questions
==================================================

Q1. Difference between DATE and DATETIME?

DATE stores only the date (YYYY-MM-DD),
while DATETIME stores both date and time
(YYYY-MM-DD HH:MM:SS).

--------------------------------------------------

Q2. What is a View?

A View is a virtual table created from
a SELECT query.

It stores the query, not the actual data.

--------------------------------------------------

Q3. What is SQL Injection?

SQL Injection is an attack where malicious
SQL code is inserted into user input to read,
modify, or delete database data.

--------------------------------------------------

Q4. How do you prevent SQL Injection?

By using Parameterized Queries or
Prepared Statements instead of concatenating
user input into SQL queries.

--------------------------------------------------

Q5. What is a Prepared Statement?

A Prepared Statement is a precompiled SQL
query with placeholders that safely accepts
user input and improves security and performance.

--------------------------------------------------

Q6. What is SQL Hosting?

SQL Hosting is a service that stores your
database on a server so applications or
websites can access it.

*/
