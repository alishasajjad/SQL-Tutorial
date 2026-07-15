/*
====================================================
SQL Aggregate Functions & LIKE Operator - Theory Notes Day 2
====================================================


====================================================
1. SQL MIN() Function
====================================================

What is MIN()?

The MIN() function is used to find the smallest value
from a column.

It can be used with:

- Numbers
- Dates
- Text values (alphabetical order)


Example:

Products Table:

Product     Price
----------- -----
Mouse       20
Laptop      900
Keyboard    50
Monitor     300


Query:

SELECT MIN(Price)
FROM Products;


Result:

20


Because 20 is the smallest price value.


Syntax:

SELECT MIN(column_name)
FROM table_name;


Using WHERE:

SELECT MIN(Price)
FROM Products
WHERE CategoryID = 1;


It returns the lowest price only from Category 1.


Using Alias (AS):

AS is used to give a meaningful name to the result.


Example:

SELECT MIN(Price) AS LowestPrice
FROM Products;


Output:

LowestPrice
------------
20


MIN() with Dates:

MIN() can also find the earliest date.


Example:

SELECT MIN(BirthDate)
FROM Employees;


Returns the oldest birth date.



====================================================
2. SQL MAX() Function
====================================================

What is MAX()?

The MAX() function returns the largest value
from a column.


Example:

SELECT MAX(Price)
FROM Products;


Output:

900


Syntax:

SELECT MAX(column_name)
FROM table_name;


Using Alias:

SELECT MAX(Price) AS HighestPrice
FROM Products;


Output:

HighestPrice
-------------
900


MAX() with Dates:

MAX() returns the latest date.

Example:

SELECT MAX(BirthDate)
FROM Employees;


It returns the youngest employee's birth date.



Difference Between MIN() and MAX():

MIN()
- Returns the smallest value.

MAX()
- Returns the largest value.



====================================================
3. SQL COUNT() Function
====================================================

What is COUNT()?

COUNT() is used to count the number of rows
or values in a table.


COUNT(*)

Counts all rows in a table.


Example:

SELECT COUNT(*)
FROM Students;


Output:

4


It counts every record.


----------------------------------------------------

COUNT(column)

Counts only values that are NOT NULL.


Example:

Name
----
Ali
Sara
NULL
John


Query:

SELECT COUNT(Name)
FROM Students;


Output:

3


NULL values are ignored.


----------------------------------------------------

COUNT(DISTINCT)

Counts only unique values.


Example:

Country
--------
Pakistan
Pakistan
UK
USA


Query:

SELECT COUNT(DISTINCT Country)
FROM Customers;


Output:

3


Only unique countries are counted.


COUNT with WHERE:

Example:

SELECT COUNT(*)
FROM Products
WHERE Price > 20;


Counts products having price greater than 20.


Using Alias:

SELECT COUNT(*) AS TotalProducts
FROM Products;


Alias gives a meaningful column name.



====================================================
4. SQL SUM() Function
====================================================

What is SUM()?

SUM() is used to add numeric values
from a column.


Example:

Quantity
--------
10
20
15
5


Query:

SELECT SUM(Quantity)
FROM Orders;


Calculation:

10 + 20 + 15 + 5


Result:

50


SUM with WHERE:

SELECT SUM(Quantity)
FROM Orders
WHERE ProductID = 11;


It adds quantities only for Product ID 11.


Using Alias:

SELECT SUM(Quantity) AS TotalQuantity
FROM Orders;


Output:

TotalQuantity
-------------
50


SUM() with Expression:

SQL can perform calculations inside SUM().


Example:

SELECT SUM(Quantity * 10)
FROM Orders;


It calculates the total cost.



====================================================
5. SQL AVG() Function
====================================================

What is AVG()?

AVG() calculates the average value
of numeric data.


Example:

Price
-----
20
40
60


Query:

SELECT AVG(Price)
FROM Products;


Calculation:

(20 + 40 + 60) / 3


Result:

40


AVG with WHERE:

SELECT AVG(Price)
FROM Products
WHERE CategoryID = 1;


Calculates average only for Category 1.


Using Alias:

SELECT AVG(Price) AS AveragePrice
FROM Products;


Higher Than Average Example:


SELECT *
FROM Products
WHERE Price >
(
SELECT AVG(Price)
FROM Products
);


This uses a Subquery.

A subquery is a query written inside another query.



====================================================
6. SQL LIKE Operator
====================================================

What is LIKE?

LIKE is used to search text values
using patterns.


SQL Wildcards:

1. %

Meaning:

Zero, one, or multiple characters.


2. _

Meaning:

Exactly one character.



----------------------------------------------------
Starts With
----------------------------------------------------


SELECT *
FROM Customers
WHERE CustomerName LIKE 'A%';


Returns names starting with A.



----------------------------------------------------
Ends With
----------------------------------------------------


SELECT *
FROM Customers
WHERE CustomerName LIKE '%a';


Returns names ending with a.



----------------------------------------------------
Contains Text
----------------------------------------------------


SELECT *
FROM Customers
WHERE CustomerName LIKE '%or%';


Returns names containing "or".



----------------------------------------------------
Starts and Ends Pattern
----------------------------------------------------


SELECT *
FROM Customers
WHERE CustomerName LIKE 'B%s';


Starts with B and ends with S.



----------------------------------------------------
Single Character Wildcard (_)
----------------------------------------------------


SELECT *
FROM Customers
WHERE CustomerName LIKE '_r%';


The second character must be r.

Example:

Fred
Brian



----------------------------------------------------
At Least Three Characters
----------------------------------------------------


SELECT *
FROM Customers
WHERE CustomerName LIKE 'A__%';


Explanation:

A   → Starts with A
__  → Two required characters
%   → Additional characters allowed


Examples:

Ali
Ahmed
Ayesha



----------------------------------------------------
LIKE Without Wildcards
----------------------------------------------------


SELECT *
FROM Customers
WHERE Country LIKE 'Pakistan';


Works the same as:

SELECT *
FROM Customers
WHERE Country = 'Pakistan';



====================================================
Quick Revision
====================================================

Function / Operator       Purpose

MIN()                     Smallest value

MAX()                     Largest value

COUNT(*)                  Count all rows

COUNT(column)             Count non-NULL values

COUNT(DISTINCT column)    Count unique values

SUM()                     Total numeric values

AVG()                     Average numeric value

LIKE 'A%'                 Starts with A

LIKE '%a'                 Ends with a

LIKE '%or%'               Contains "or"

LIKE '_r%'                Second character is r

LIKE 'A__%'               Starts with A with minimum 3 characters



====================================================
====================================================

MIN()
- Returns the smallest value.

MAX()
- Returns the largest value.

COUNT(*)
- Counts all rows.

COUNT(column)
- Counts only non-NULL values.

COUNT(DISTINCT column)
- Counts only unique values.

SUM()
- Adds numeric values.

AVG()
- Calculates average and ignores NULL values.

LIKE
- Searches text using patterns.

%
- Represents zero or more characters.

_
- Represents exactly one character.


====================================================
====================================================
*/

/*
====================================================
SQL Wildcards, IN, BETWEEN & Aliases - 
====================================================


====================================================
1. SQL Wildcards
====================================================

What are SQL Wildcards?

Wildcards are special characters used with the LIKE
operator to search data using patterns.

They are mostly used for searching text values.



====================================================
Wildcard %
====================================================

The % wildcard represents:

- Zero characters
- One character
- Multiple characters


Example:

SELECT *
FROM Customers
WHERE CustomerName LIKE 'A%';


Meaning:

Find names that start with A.


Examples:

Ali
Ahmed
Ayesha



----------------------------------------------------
Ends With
----------------------------------------------------


SELECT *
FROM Customers
WHERE CustomerName LIKE '%n';


Meaning:

Find names ending with n.


Examples:

John
Hasan



----------------------------------------------------
Contains Text
----------------------------------------------------


SELECT *
FROM Customers
WHERE CustomerName LIKE '%ar%';


Meaning:

Find values containing "ar" anywhere.


Examples:

Areeba
Farhan
Maryam



====================================================
Wildcard _
====================================================

The _ wildcard represents exactly one character.


Example:

SELECT *
FROM Customers
WHERE City LIKE '_ondon';


Matches:

London


Explanation:

_ = L

ondon = Remaining characters



Example:

SELECT *
FROM Customers
WHERE CustomerName LIKE 'A___';


Meaning:

- Starts with A
- Total length must be 4 characters


Matches:

Ayan
Amir


Does not match:

Ahmed

because Ahmed has 5 characters.



====================================================
Wildcard []
====================================================

The [] wildcard is mainly supported in SQL Server.


It is used to match one character from a list.


Example:

SELECT *
FROM Customers
WHERE CustomerName LIKE '[ABC]%';


Meaning:

Name should start with:

A
B
or
C


Examples:

Ali
Bilal
Chris



====================================================
Wildcard [A-F]
====================================================

Used to specify a range of characters.


Example:

SELECT *
FROM Customers
WHERE CustomerName LIKE '[A-F]%';


Matches names starting with:

A
B
C
D
E
F



====================================================
Wildcard Summary
====================================================

Wildcard       Meaning

%              Any number of characters

_              Exactly one character

[]             One character from a list

[A-F]          One character from a range



====================================================
2. SQL IN Operator
====================================================

What is IN?

The IN operator is used to check multiple values
without writing multiple OR conditions.


Without IN:


SELECT *
FROM Customers
WHERE Country='Pakistan'
OR Country='India'
OR Country='China';



Using IN:


SELECT *
FROM Customers
WHERE Country IN ('Pakistan','India','China');


IN makes queries shorter and easier to read.



----------------------------------------------------
NOT IN
----------------------------------------------------


NOT IN is used to exclude multiple values.


Example:


SELECT *
FROM Customers
WHERE Country NOT IN ('Pakistan','India');


Meaning:

Show all customers except those from Pakistan
and India.



----------------------------------------------------
IN with Subquery
----------------------------------------------------


Example:


SELECT *
FROM Customers
WHERE CustomerID IN
(
SELECT CustomerID
FROM Orders
);


Meaning:

Return only customers who have placed orders.



====================================================
3. SQL BETWEEN Operator
====================================================

What is BETWEEN?

BETWEEN is used to select values within a specific
range.

The starting and ending values are included.



----------------------------------------------------
Numbers
----------------------------------------------------


Example:


SELECT *
FROM Products
WHERE Price BETWEEN 100 AND 500;


Returns values:

100
101
200
350
500


Both 100 and 500 are included.



----------------------------------------------------
NOT BETWEEN
----------------------------------------------------


Example:


SELECT *
FROM Products
WHERE Price NOT BETWEEN 100 AND 500;


Returns values:

Less than 100

OR

Greater than 500



----------------------------------------------------
BETWEEN with IN
----------------------------------------------------


Example:


SELECT *
FROM Products
WHERE Price BETWEEN 100 AND 500
AND CategoryID IN (1,2,3);


Conditions:

1. Price must be between 100 and 500

2. Category must be 1, 2, or 3



----------------------------------------------------
BETWEEN with Text
----------------------------------------------------


Example:


SELECT *
FROM Products
WHERE ProductName BETWEEN 'A' AND 'M';


Returns product names alphabetically
between A and M.



----------------------------------------------------
BETWEEN with Dates
----------------------------------------------------


Example:


SELECT *
FROM Orders
WHERE OrderDate BETWEEN
'2026-01-01'
AND
'2026-01-31';


Returns all orders between these dates.



====================================================
4. SQL Aliases (AS)
====================================================

What is an Alias?

An alias is a temporary name given to a column
or table.

It improves readability of SQL queries.



----------------------------------------------------
Column Alias
----------------------------------------------------


Original:


SELECT CustomerName
FROM Customers;


Using Alias:


SELECT CustomerName AS Name
FROM Customers;


Output:


Name
----
Ali
Ahmed


AS changes the display name of the column.



----------------------------------------------------
Alias with Spaces
----------------------------------------------------


Example:


SELECT ProductName AS "Product Name"
FROM Products;


Creates a readable column name with spaces.



----------------------------------------------------
Table Alias
----------------------------------------------------


Instead of:


Customers.CustomerName


Use:


SELECT c.CustomerName
FROM Customers AS c;


Here:

c = Customers table



----------------------------------------------------
Alias in JOIN Queries
----------------------------------------------------


Without alias:


SELECT Customers.CustomerName,
Orders.OrderID
FROM Customers
JOIN Orders
ON Customers.CustomerID=Orders.CustomerID;



With alias:


SELECT c.CustomerName,
o.OrderID
FROM Customers AS c
JOIN Orders AS o
ON c.CustomerID=o.CustomerID;


Advantages:

- Shorter queries
- Easier to read
- Commonly used in JOIN operations



----------------------------------------------------
Concatenate Columns
----------------------------------------------------


CONCAT() combines multiple columns into one value.


Example:


SELECT CONCAT(Address, ', ', City, ', ', Country)
AS FullAddress
FROM Customers;


Output:


Street 5, Lahore, Pakistan



====================================================
Difference Between LIKE, IN, BETWEEN and AS
====================================================


Operator      Purpose                 Example


LIKE          Pattern searching       LIKE 'A%'


IN            Multiple values         IN ('PK','UK')


BETWEEN       Range of values         BETWEEN 100 AND 500


AS            Temporary alias         Name AS CustomerName



====================================================
Important Rules
====================================================

% 
- Represents any number of characters.


_
- Represents exactly one character.


LIKE
- Used for searching text patterns.


IN
- Used for multiple specific values.
- Short form of multiple OR conditions.


NOT IN
- Excludes multiple values.


BETWEEN
- Finds values inside a range.
- Includes starting and ending values.


AS
- Creates temporary names for columns or tables.


Table aliases like:

c = Customers

o = Orders

p = Products


make JOIN queries shorter and easier to understand.



====================================================
====================================================
*/

/*
====================================================
SQL JOINs -
====================================================


====================================================
1. What is a JOIN?
====================================================

A JOIN is used to combine data from two or more tables
using a common column.

Tables are connected through a related column.

Example:

Customers Table:

CustomerID     CustomerName
-----------    -------------
1              Ali
2              Ahmed
3              Sara


Orders Table:

OrderID        CustomerID      Product
-------        ----------      -------
101            1               Laptop
102            2               Mouse
103            2               Keyboard


Common Column:

CustomerID


SQL uses this common column to combine related data.


General JOIN Syntax:

SELECT columns
FROM Table1
JOIN Table2
ON Table1.CommonColumn = Table2.CommonColumn;


ON keyword defines the relationship between tables.



====================================================
Types of SQL JOINs
====================================================

Important JOIN types:

1. INNER JOIN
2. LEFT JOIN
3. RIGHT JOIN
4. FULL JOIN
5. SELF JOIN



====================================================
2. INNER JOIN
====================================================

What is INNER JOIN?

INNER JOIN returns only the rows that have matching
values in both tables.


Example:

SELECT Customers.CustomerName,
Orders.Product
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;


Result:

Customer       Product
---------      --------
Ali            Laptop
Ahmed          Mouse
Ahmed          Keyboard


Explanation:

- Sara is not returned because she has no order.
- Order records without matching customers are ignored.


INNER JOIN returns only common records.


Visual Idea:

Customers ∩ Orders


Only the intersection of both tables is returned.



JOIN vs INNER JOIN

JOIN and INNER JOIN are the same.


Example:

SELECT *
FROM Customers
JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;


is equal to:


SELECT *
FROM Customers
INNER JOIN Orders
ON Customers.CustomerID = Orders.CustomerID;



====================================================
3. Joining Multiple Tables
====================================================

SQL can join more than two tables.


Example:

Customers

Orders

Shippers


Query:

SELECT Orders.OrderID,
Customers.CustomerName,
Shippers.ShipperName
FROM Orders
INNER JOIN Customers
ON Orders.CustomerID=Customers.CustomerID
INNER JOIN Shippers
ON Orders.ShipperID=Shippers.ShipperID;


Multiple tables can be connected using multiple JOIN
conditions.



====================================================
4. LEFT JOIN
====================================================

What is LEFT JOIN?

LEFT JOIN returns:

✔ All records from the LEFT table

✔ Matching records from the RIGHT table


If no matching record exists:

NULL values are returned.


Example:

Customers:

ID      Name
--      ----
1       Ali
2       Ahmed
3       Sara


Orders:

Order   CustomerID
-----   ----------
101     1
102     2


Query:

SELECT Customers.CustomerName,
Orders.OrderID
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID=Orders.CustomerID;


Result:

Customer      Order
---------     -----
Ali           101
Ahmed         102
Sara          NULL


Explanation:

Sara appears because LEFT JOIN keeps every row
from the left table.



Finding Customers Without Orders:


SELECT Customers.CustomerName
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID=Orders.CustomerID
WHERE Orders.CustomerID IS NULL;


Returns customers who have no orders.


LEFT JOIN is commonly used in interviews.



====================================================
5. RIGHT JOIN
====================================================

What is RIGHT JOIN?

RIGHT JOIN is opposite to LEFT JOIN.


It returns:

✔ All records from the RIGHT table

✔ Matching records from the LEFT table


Example:

Orders:

Order   EmployeeID
-----   ----------
101     1
102     2


Employees:

ID      Name
--      ----
1       John
2       David
3       Mike


Query:

SELECT Orders.OrderID,
Employees.Name
FROM Orders
RIGHT JOIN Employees
ON Orders.EmployeeID=Employees.EmployeeID;


Result:

Order       Employee
-----       --------
101         John
102         David
NULL        Mike


Explanation:

Mike appears because RIGHT JOIN keeps all rows
from the right table.



====================================================
6. FULL JOIN
====================================================

What is FULL JOIN?

FULL JOIN returns all records from both tables.


It includes:

✔ Matching records

✔ Unmatched records from left table

✔ Unmatched records from right table


Example:


Customers:

ID     Name
--     ----
1      Ali
2      Ahmed
3      Sara


Orders:

Order   CustomerID
-----   ----------
101     1
102     2
103     5


Query:

SELECT Customers.CustomerName,
Orders.OrderID
FROM Customers
FULL JOIN Orders
ON Customers.CustomerID=Orders.CustomerID;


Result:

Customer       Order
---------      -----
Ali            101
Ahmed          102
Sara           NULL
NULL           103


Explanation:

- Sara has no order.
- Order 103 has no customer.

Both are still displayed.



Important:

MySQL does not directly support FULL JOIN.

It can be created using:

LEFT JOIN
+
UNION
+
RIGHT JOIN


FULL JOIN is supported in:

- SQL Server
- PostgreSQL



====================================================
7. SELF JOIN
====================================================

What is SELF JOIN?

A SELF JOIN is when a table is joined with itself.


Why use SELF JOIN?

To compare rows inside the same table.


Example:

Customers:

ID     Name       City
--     ----       ----
1      Ali        Lahore
2      Ahmed      Lahore
3      Sara       Karachi


Query:


SELECT
A.CustomerName,
B.CustomerName,
A.City
FROM Customers A,
Customers B
WHERE A.CustomerID<>B.CustomerID
AND A.City=B.City;


Result:

Customer1     Customer2     City
----------    ----------    ----
Ali           Ahmed         Lahore


Explanation:

Ali and Ahmed live in the same city.


Aliases are required because SQL needs two different
names for the same table.



====================================================
8. Table Aliases in JOIN
====================================================

Table aliases are short names given to tables.


Instead of:


Customers.CustomerName


Use:


c.CustomerName


Example:


SELECT c.CustomerName,
o.OrderID
FROM Customers c
JOIN Orders o
ON c.CustomerID=o.CustomerID;


Advantages:

- Makes queries shorter.
- Improves readability.
- Commonly used in JOIN queries.



====================================================
JOIN Comparison
====================================================


JOIN Type          Returns


INNER JOIN         Only matching rows


LEFT JOIN          All left table rows + matching right rows


RIGHT JOIN         All right table rows + matching left rows


FULL JOIN          All rows from both tables


SELF JOIN          A table joined with itself



====================================================
Easy Way to Remember
====================================================


INNER JOIN:

Only common records.


LEFT JOIN:

Keep everything from the left table.


RIGHT JOIN:

Keep everything from the right table.


FULL JOIN:

Keep everything from both tables.


SELF JOIN:

Compare rows inside the same table.



====================================================
Visual Memory
====================================================


INNER JOIN:

Table A ∩ Table B


LEFT JOIN:

Keep all from Table A


RIGHT JOIN:

Keep all from Table B


FULL JOIN:

Table A + Table B


SELF JOIN:

Table A ↔ Table A



====================================================
====================================================

INNER JOIN:
Returns only matching records.


LEFT JOIN:
Never removes rows from the left table.


RIGHT JOIN:
Never removes rows from the right table.


FULL JOIN:
Returns complete data from both tables.


SELF JOIN:
Used when a table needs to compare its own records.


Table aliases make JOIN queries shorter and easier
to understand.


====================================================
====================================================
*/

/*
====================================================
SQL UNION & UNION ALL 
====================================================


====================================================
1. SQL UNION Operator
====================================================

What is UNION?

The UNION operator is used to combine the results
of two or more SELECT statements into one result set.


Important Points:

- It removes duplicate rows automatically.
- It returns only unique records.
- It combines similar data from multiple tables.


Syntax:


SELECT column_name
FROM Table1

UNION

SELECT column_name
FROM Table2;



====================================================
Example of UNION
====================================================


Customers Table:

Country
--------
Pakistan
India
China


Suppliers Table:

Country
--------
India
USA
China



Query:


SELECT Country
FROM Customers

UNION

SELECT Country
FROM Suppliers;



Output:


Country
--------
Pakistan
India
China
USA



Explanation:

India and China exist in both tables.

However, they appear only once in the result
because UNION removes duplicate records.



Memory Trick:

UNION = Combine + Remove Duplicates



====================================================
2. Conditions for UNION
====================================================

For UNION to work correctly, the SELECT statements
must follow certain rules.



----------------------------------------------------
Rule 1: Same Number of Columns
----------------------------------------------------


Both SELECT queries must return the same number
of columns.


Correct Example:


SELECT Name, City
FROM Customers

UNION

SELECT SupplierName, City
FROM Suppliers;



Both queries return 2 columns.



Incorrect Example:


SELECT Name
FROM Customers

UNION

SELECT SupplierName, City
FROM Suppliers;



Error occurs because:

First query returns 1 column.

Second query returns 2 columns.



----------------------------------------------------
Rule 2: Compatible Data Types
----------------------------------------------------


The corresponding columns should have compatible
data types.


Correct:


SELECT Name
FROM Customers

UNION

SELECT SupplierName
FROM Suppliers;



Both columns contain text values.



Incorrect:


SELECT Name
FROM Customers

UNION

SELECT Price
FROM Products;



One column contains text.

One column contains numbers.



====================================================
3. UNION with WHERE Clause
====================================================

WHERE can be used before UNION to filter data
from each table.


Example:


SELECT City
FROM Customers
WHERE Country='Germany'

UNION

SELECT City
FROM Suppliers
WHERE Country='Germany';



SQL performs these steps:

1. Filters German cities from Customers.
2. Filters German cities from Suppliers.
3. Combines the results.
4. Removes duplicate cities.



====================================================
4. UNION with Alias
====================================================

Aliases can be used with UNION to create temporary
column names.


Example:


SELECT
'Customer' AS Type,
ContactName
FROM Customers

UNION

SELECT
'Supplier',
ContactName
FROM Suppliers;



Output:


Type          ContactName
------------  ------------
Customer      Ali
Customer      Ahmed
Supplier      Hamza
Supplier      Bilal



Explanation:

Type is a temporary column created using AS.



====================================================
5. SQL UNION ALL
====================================================

What is UNION ALL?

UNION ALL is used to combine results of multiple
SELECT statements.


Difference:

UNION ALL does not remove duplicates.

It returns every row including repeated values.



Syntax:


SELECT column_name
FROM Table1

UNION ALL

SELECT column_name
FROM Table2;



====================================================
Example of UNION ALL
====================================================


Customers:

Country
--------
Pakistan
India


Suppliers:

Country
--------
India
USA



Query:


SELECT Country
FROM Customers

UNION ALL

SELECT Country
FROM Suppliers;



Output:


Country
--------
Pakistan
India
India
USA



Explanation:

India appears twice because UNION ALL keeps
duplicate records.



====================================================
6. Difference Between UNION and UNION ALL
====================================================


UNION:

- Removes duplicate rows.
- Returns only unique records.
- Slightly slower because duplicate checking is required.


UNION ALL:

- Keeps duplicate rows.
- Returns all records.
- Faster because no duplicate checking is performed.



Comparison Table:


UNION                  UNION ALL
-----------------------------------------
Removes duplicates    Keeps duplicates

Unique records        All records

Slower                Faster



====================================================
7. Example Comparison
====================================================


Customers Table:


Name
----
Ali
Ahmed
Ali



Suppliers Table:


Name
----
Ahmed
Hamza



----------------------------------------------------
Using UNION
----------------------------------------------------


SELECT Name
FROM Customers

UNION

SELECT Name
FROM Suppliers;



Output:


Ali
Ahmed
Hamza



Duplicates are removed.



----------------------------------------------------
Using UNION ALL
----------------------------------------------------


SELECT Name
FROM Customers

UNION ALL

SELECT Name
FROM Suppliers;



Output:


Ali
Ahmed
Ali
Ahmed
Hamza



Duplicates are preserved.



====================================================
8. Interview Question
====================================================


Question:

What is the difference between UNION and UNION ALL?



UNION:

- Removes duplicate rows.
- Returns unique records.
- Slower due to duplicate removal.


UNION ALL:

- Includes duplicate rows.
- Returns all records.
- Faster because no duplicate checking is performed.



====================================================
9. HackerRank / Exam Tip
====================================================


If the question says:


"Display all records including duplicates"


Use:


UNION ALL



If the question says:


"Display only unique records"


Use:


UNION



====================================================
Quick Revision Notes
====================================================


UNION:

- Combines two or more SELECT queries.
- Removes duplicate rows.
- Requires:
    * Same number of columns.
    * Compatible data types.
    * Same column order.


Example:


SELECT Name FROM Table1

UNION

SELECT Name FROM Table2;



----------------------------------------------------


UNION ALL:

- Combines multiple SELECT queries.
- Keeps duplicate rows.
- Faster than UNION.


Example:


SELECT Name FROM Table1

UNION ALL

SELECT Name FROM Table2;



====================================================
Memory Trick
====================================================


UNION = Unique

(Removes duplicates)


UNION ALL = All

(Includes duplicates)



====================================================
====================================================
*/





