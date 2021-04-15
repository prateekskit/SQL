/* 
This is Janbask. we are in class 2
DATE - 04/12/2021
*/

-- Command used to create a new database

CREATE DATABASE JB_2021_April 

USE jb_2021_April

---- CREATE a TABLE
/*
CREATE TABLE <Any table name>
(
	<col name 1> datatype,
	<col name 2> datatype,
	.
	.
	.
	<col name N> datatype
)
*/


create table tblEmp
(
id int,
EmpName varchar(max), CHAR(10), NVARCHAR(100)
Salary int
)

/* Data type
INT, BIGINT,   --- numeric
VARCHAR,NVARCHAR,CHAR   -- text or string or alphanumeric
date, datetime --- calendar 
float,decimal  ----- decimal values
bit --- true/false
*/

--- INSERT some records in the table.

/*
INSERT INTO <table name>(<col1>,<col2> ....<colN>)
VALUES(x1,x2,x3....xn)
*/

INSERT INTO tblEmp
values(1,'Raj',2000)


INSERT INTO tblEmp
values(2,'Raj',2000,'Manhotra')
---select statemement 

SELECT * from tblEmp

--- DDL   --- Data Definition Language
---    CREATE, ALTER , TRUNCATE, 
--- DML   --- Data Manipulation Language
---	INSERT, DELETE, UPDATE, SELECT
--- DCL ---  Data Control Language


---- ALTER Keyword 
-- ALTER TABLE <tableName> ADD <column name> <datatype>

ALTER TABLE tblemp ADD EmpLastName VARCHAR(10)

ALTER TABLE tblemp ALTER COLUMN EmpLastName VARCHAR(100)

select * from tblemp
select ID,empName from tblEmp

SELECT * INTO tblemp_new
FROM tblEmp

--CROSS DATABASE QUERY
SELECT * FROM AdventureWorksDW2017.DBO.DimCustomer

SELECT *  INTO DIMCUSTOMER_REPLICA
FROM AdventureWorksDW2017.DBO.DimCustomer

SELECT * FROM DIMCUSTOMER_REPLICA


