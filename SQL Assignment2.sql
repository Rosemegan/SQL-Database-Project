#PART ONE
#MEANING OF DATABASE MANAGEMENT SYSTEM(DBMS)
#Software systems used to store,retrieve and run queries on data and serves as an interface between an end user and a databases

#DIFFERENT TYPES OF DBMS
#Relational DBMS-stores data in tables using columns and rows and allows users to create,update and administer a relational database. 
#Object-oriented DBMS-Can store data as objects(represents an item) and classes(represents a group or collection of objects). 
#Hierarchical DBMS-is one where tree-like structure are used to organize data and which data elements have one-to-many relationships.
#Network DBMS-organizes data in graphical representations which users can access through several paths. It organizes data in many-to-many relationships.

#RELATIONAL DATABASES IN SQL
#Collection of information that organizes data in predefined relationships where data is stored in one or more tables of columns and rows.
#Examples of standard relational databases are; Microsoft SQL Server,Oracle Database,MySQL,PostgreSQL,IBM DB2

#DIFFERENCES BETWEEN RELATIONAL AND NON-RELATIONAL DATABASES
#In relational data is stored in structured tables with predefined schemas while in non-relational data is stored in variety of formats e.g key-value pairs,documents,graphs or wide columns.
#Relational uses a predefined schema where each table's columns and data types must be defined before inserting data while non-relational is schema-less or use dynamic schemas which allows data fields to vary.
#In relational relationships between data are managed using foreign keys and joins while non-relational do not rely on joins and foreign keysto relate data.
#Relational is generally scale vertically which can be costly while non-realtional is desidned to scale horizontally.
#In relational performance can slow down wuth large numbers of data and complex queries while non-relational is optimized for high-performance operations.
#Reltional follows ACID properties(Atomocity,Consistency,Isolation,Durability)while non-relational follow BASE properties(Basically Available,Soft state,Eventually consistent)
#Data integrity in relational is strong while in non-relational data integrity is weaker.

#DEFINITION OF PRIMARY,FOREIGN AND COMPOSITE KEYS
#A primary key is a column in a reltional table that is distinctive for each record/uniquely identifies each row.
#A foreign key is a column or combination of columns that is used to establish and enforce a link between the data in two tables to control the data the data that can be stored in the foreign key table.
#A composite key is a candidate key that consists of two or more attributes, that together uniquely identify an entire occurrence.

#DIFFERENCE BETWEEN CHAR AND VARCHAR
#CHAR has a fixed size and stores data of fixed length and values are padded with spaces to the specified length while VARCHAR has a variable size and store variable format data and its values are not padded with spaces.

#OTHER DATA TYPES IN SQL
#Integer,datetime,decimal,date,time.

#DIFFERENCE BETWEEN DELETE AND TRUNCATE
#Delete removes one or multiple rows from a table using conditions while truncate removes all the rows from a table without using any condition.

#DIFFERENCE BETWEEN WHERE AND HAVING
#A HAVING clause is like a WHERE clause but applies only to groups as a whole that is to rows in the result set whereas the WHERE clause applies to individual rows.

#WHAT ARE CONSTRAINTS
#SQL constraints are used to specify rules for the data in a table/used to limit the type of data that can go into a table.

#VARIOUS CONSTRAINTS IN SQL
#NOT NULL is used when the values cannot be null/must have a values.
#UNIQUE is used when values cannot match any older value.
#PRIMARY KEY is used to uniquely identify a row.
#FOREIGN KEY is used to reference a row in another table.

#SQL QUERY TO DISPLAY CURRENT DATE
SELECT CURRENT_DATE;

#FUNCTION OF INTERSECT
#Intersect is used to combine two SELECT statements but the dataset returned by the INTERSECT statement will be the intersection of the data sets of the two SELECT statements.

#OPERATOR USED IN PATTERN MATCHING
# LIKE  is used ina a WHERE clause to search for a specified pattern ina column.

#HOW IS AUTO-INCREAMENT USED
#It is a feature that is applied to a field so that it can automatically generate and provide a unique value to every record that you enter into an SQL table.

#ACID PROPERTY
#ACID is an acronym that refers to the set of 4 key properties that define a transaction that is Atomicity,Consistency,Isolation and Durability.If a database operation has these proerties it can be callrd an ACID transaction.

#DIFFERENCE BETWEEN TRIGGERES AND STORED PROCEDURES
#Triggers are mainly used to maintain referential integrity and record activities performed on a table while procedures are used to perform tasks as specified by the users.
#Triggers do not return values and cannot accept values as input parameters while procedures can return 0 to n values and can accept values as parameters.


#PART TWO
#JOINING
SELECT customers.customer_id,customers.first_name,customers.last_name,customers.address,orders.order_id,orders.order_date
FROM customers
JOIN orders ON customers.customer_id = orders.customer_id
JOIN shippers ON orders.shipper_id = shippers.shipper_id;

#LIST OF CUSTOMERS NORN BEFORE 1976
SELECT customer_id,first_name,last_name,birth_date
FROM customers
WHERE birth_date < '1976-01-01';
    
#CUSTOMERS WHOSE ADDRESS CONTAINS JUNCTION OR TERRACE
SELECT customer_id,first_name,last_name,address
FROM customers
WHERE address REGEXP 'JUNCTION|TERRACE';
    
#OFFICES LOCATED IN CITIES THAT HAVE 'i'
SELECT office_id,city,address
FROM offices
WHERE city LIKE '%i%';

#CUSTOMERS WITH PHONE NUMBER BEGINNING WITH 3
SELECT client_id,name,phone
FROM clients
WHERE phone LIKE '3%';

#PART 3
#CREATING DATABASE
CREATE DATABASE CompanyDB;
USE CompanyDB;
CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);
CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    DepartmentID INT
);
INSERT INTO Departments (DepartmentName) VALUES
('Mathematics'),
('Chemistry'),
('Biotechnology'),
('Physics'),
('Forensic Science');

INSERT INTO Employees (FirstName, LastName, DepartmentID) VALUES
('Carlene', 'Rose', 1),
('Mary', 'Christian', 2),
('John', 'Austin', 3),
('Joshua',' Robert',5),
('Talia','Mali',4),
('Pearl','Megan',3),
('Ethan','Joseph',2);

#INNER JOIN
SELECT 
    CONCAT(FirstName, ' ', LastName) AS FullName,
    DepartmentName
FROM employees e
INNER JOIN departments d
ON d.DepartmentID = d.DepartmentID;

#LEFT JOIN
SELECT 
    CONCAT(FirstName, ' ', LastName) AS FullName,
    DepartmentName
FROM employees e
LEFT JOIN departments d
ON d.departmentID = e.departmentID;

#DIFFERENCE BETWEEN INNER JOIN AND LEFT JOIN
#Inner join returns rows where there is a match in both tables while left join returns rows where the table matches rows from the right table.

DELIMITER $$

CREATE PROCEDURE GetStudentStats(IN studentID INT, OUT totalCourses INT, OUT avgGrade DECIMAL(5, 2))
BEGIN
    # Calculate total courses and average grade
    SELECT 
        COUNT(CourseID) AS TotalCourses,
        IFNULL(AVG(Grade), 0) AS AverageGrade
    INTO 
        totalCourses, avgGrade
    FROM 
        Enrollments
    WHERE 
        StudentID = studentID;
END $$

DELIMITER ;

#IFNULL(AVG(Grade), 0) ensures that if no grades are found, the result will be 0 instead of NULL.
#COUNT(CourseID) returns 0 if no courses are found. This ensures the stored procedure handles cases where the student has no enrollments.

#ADVANTAGES OF STORED PROCEDURES
#Stored procedures are precompiled, leading to faster execution times.
#Permissions can be granted on stored procedures, limiting direct access to underlying tables.
#Complex operations can be stored in the procedure, reducing redundancy and centralizing logic in the database.
#In a university system, a procedure like GetStudentStats can be used by multiple applications to retrieve student statistics. Instead of writing the same SQL query in multiple places, the stored procedure ensures that all applications use the same logic.Also any updates to the logic only need to be made in the stored procedure.

CREATE INDEX idx_name ON Products (Name);
#Ensures faster a query searches for products based on their name, the database can quickly locate the relevant rows using the index instead of scanning the entire table search queries 
#Indexes allow the database to search through a smaller subset of data, minimizing the amount of data read from disk and improving overall query performance.
#Efficient sorting in that if a query involves sorting by ProductName, the index can significantly speed up the sorting process.

SELECT product_id, Name, quantity_in_stock
FROM Products
WHERE Name LIKE 'B%';

CREATE INDEX idx_order_date ON Orders (order_date);

SELECT * 
FROM Orders
WHERE OrderYear = 2019 AND OrderMonth = 10;

CREATE INDEX idx_order_date ON Orders (OrderDate);

SELECT * 
FROM Orders
WHERE order_date BETWEEN '2018-10-01' AND '2019-10-31';

#TRADE-OFFS IN USING INDEXES
#While read performance improves with indexes, write operations (INSERT, UPDATE, DELETE) slow down.
#Each time a row is modified or added, the database must also update all relevant indexes, which introduces overhead.
#RECOMMENDATION
#One should minimize the number of indexes on tables that experience high write activity.
#Indexes require rebuilding and reorganizing to remain efficient, especially for large datasets. 
#RECOMMENDATION
#Ensure there are regular index maintenance tasks
#Indexes require additional disk space to store the data structure
#RECOMMENDATION
#Use composite indexes wisely to cover several query patterns instead of creating multiple single-column indexes.

#USE INDEXES CAREFULLY
#In tables with frequent inserts, updates, or deletes.
#Avoid indexing columns with low uniqueness

#AVOID INDEXEX
#For tables with very few rows
#If queries frequently change

#PART 4
#GRANTING ACCESS
CREATE USER 'Rose_Megan'@'localhost' IDENTIFIED BY 'password123';
GRANT ALL PRIVILEGES ON companydb.* TO 'Rose_Megan'@'localhost';
GRANT SELECT ON companydb.* TO 'Rose_Megan'@'localhost';
GRANT SELECT, INSERT ON companydb.employees TO 'Rose_Megan'@'localhost';
GRANT ALL PRIVILEGES ON companydb.* TO 'Rose_Megan'@'localhost' WITH GRANT OPTION;

#REVOKING ACCESS
REVOKE INSERT, UPDATE ON companydb.employees FROM 'Rose_Megan'@'localhost';
REVOKE ALL PRIVILEGES ON CompanyDB.* FROM 'Rose_Megan'@'localhost';
DROP USER 'Rose_Megan'@'localhost';

FLUSH PRIVILEGES;













