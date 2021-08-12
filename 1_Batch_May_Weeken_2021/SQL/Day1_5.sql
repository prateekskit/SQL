------ Comments  --- Non Executable Entities
  -- COMMENTS
 -- CREATE DATABASE TEST 
 ---Commands 
-- I am creating a database JB_May_2021 for my new batch 
-- 
/*   
laskdlad
kakdlajd
lasdjlakjd
lajdlajds
*/


CREATE DATABASE JB_May_2021

--- USE DATABASE_NAME

USE JB_May_2021
--- DROP = DELETE
DROP DATABASE TSQLV4



--- DATA TYPES

CREATE TABLE tblemp
(
	ID INT,
	NAME VARCHAR(900),   ---- varriable character ( length of name)
	Salary NUMERIC(5,2)
)


---- SELECT column name from table 

SELECT ID,NAME,Salary 
FROM tblEmp

SELECT ID,Salary 
FROM tblEmp

SELECT *
FROM tblEmp


------ INSERT some data into the table......
/*
INSERT INTO <table name>(Col1,col2,col3)
VALUES(val1,val2,val3)
*/

INSERT INTO tblemp
VALUES(1,'John',200.00)

INSERT INTO tblemp
VALUES('New','John',200.00)



----- ALTER COMMANDS

ALTER TABLE tblEmp ADD Gender varchar(10)

ALTER TABLE tblEmp ALTER COLUMN Salary NUMERIC(10,3)


select * from tblemp
/*

numeric values --- INT, BIGINT, SMALLINT
STRING or alphabaticall -- VARCHAR,CHAR, NVARCHAR
DATE & TIME				--- DATETIME,TIME,DATE DATETIME2
DECIMALS				--- DECIMALS,NUMERIC,FLOAT

*/

use JB_May_2021

--- VARCHAR,CHAR, NVARCHAR
--- install SQL SEVER
-- import Adventure Works
--- exeucte the script I have provided
--- see different data types in SQL



--STRING datatypes -- VARCHAR,CHAR, NVARCHAR

-- VARCHAR         firstname varchar(10)   --- John          
-- CHAR				firstname char(10)     -----   fixrd lenght data type --- A, AB, ABC, ABCD  --- 10 memory as length
-- NVARCHAR			firstname nvarchar(10)  --- John

----------------------------- Day 2 - 5 ------------------------------

---CROSS DATABASE QUERY to a Table --- 

USE JB_May_2021
----- this will create a table in the JB database
SELECT * into Customer_Replica
FROM AdventureWorksDW2017.dbo.DimCustomer

--- this will create a table in the Adventure works database.
SELECT * into adventureworksDW2017.dbo.Customer_Replicas
FROM AdventureWorksDW2017.dbo.DimCustomer

select * from Customer_Replica
select * from customer_subset_a

CREATE TABLE Customer_SubSet_A
(
customerKey int,
FirstName varchar(100),
LastName varchar(100),
MaritalStatus char(1),
Gender char(1)
)

select * from customer_subset_a

insert into customer_subset_a
select CustomerKey,FirstName,LastName,MaritalStatus,Gender from Customer_Replica

-----------------------------------------------------------------------------------------

select * from tblemp
select * from customer_subset_a
UPDATE tblemp
SET Name = 'Rock'

UPDATE tblemp
SET Gender = 'Male'

UPDATE customer_subset_a
SET Firstname = 'Elliot',
	LastName = 'Johnson'
WHERE customerKey = 11000 


-- DELETE STATEMENT
select * from tblemp
DELETE FROM tblemp
select * from customer_subset_a
delete from customer_subset_a WHERE customerKey = 14616

TRUNCATE table customer_subset_a 

DROP TABLE tblemp
----

/*
SQL we have 2 types of syntax 

DDL  ---- DATA DEFINITION Language
CREATE ALTER DROP TRUNCATE

DML  --- DATA Manipulation Language
INSERT UPDATE DELETE SELECT
*/

---------------- WHERE CLAUSE -----------------

 -- =
select * from Customer_Replica WHERE customerkey = 11000
-- get all thse customer who are married
select * from Customer_Replica WHERE MaritalStatus = 'M'
--- Negative
select * from Customer_Replica WHERE MaritalStatus != 'M'
select * from Customer_Replica WHERE MaritalStatus = 'S'

select * from Customer_Replica WHERE MaritalStatus <> 'M'

select customerkey,firstname,emailaddress,MaritalStatus,Gender,YearlyIncome,EnglishEducation,EnglishOccupation
from Customer_Replica WHERE MaritalStatus = 'M'


select customerkey,firstname,emailaddress,MaritalStatus,Gender,YearlyIncome,EnglishEducation,EnglishOccupation
from Customer_Replica WHERE EnglishEducation = 'Partial College'

---- I want all the customers who are either bachelors holder or partial college holder

---- IN


select customerkey,firstname,emailaddress,MaritalStatus,Gender,YearlyIncome,EnglishEducation,EnglishOccupation
from Customer_Replica WHERE EnglishEducation IN ('Partial College','Bachelors')

--- NOT IN

select customerkey,firstname,emailaddress,MaritalStatus,Gender,YearlyIncome,EnglishEducation,EnglishOccupation
from Customer_Replica WHERE EnglishEducation NOT IN ('Partial College','Bachelors')


----- BETWEEN & AND

select customerkey,firstname,emailaddress,MaritalStatus,Gender,YearlyIncome,EnglishEducation,EnglishOccupation
from Customer_Replica WHERE CustomerKey  BETWEEN 11010 AND 11020

--- DISTINCT KEYWORD  --- UNIQUE VALUE

select distinct  maritalstatus from Customer_Replica

select distinct  maritalstatus,gender from Customer_Replica

select distinct englisheducation from Customer_Replica


---- ORDER BY CLAUSE 
--- by default order by is acending 
select distinct englisheducation from Customer_Replica order by englisheducation

select distinct englisheducation from Customer_Replica order by englisheducation desc


select FirstName,YearlyIncome from Customer_Replica order by YearlyIncome 

select FirstName,YearlyIncome from Customer_Replica order by YearlyIncome desc, FirstName

--- LIKE
---  Arthimatic Operators 
--- AND & OR CLAUSE
-- GROUP BY & HAVING

--LIKE OPERATOR--

SELECT * FROM Customer_SubSet_A
--- all last name starting with C
SELECT * FROM Customer_SubSet_A where lastname like 'C%'

--- all last name starting with C and ending with A
SELECT * FROM Customer_SubSet_A where lastname like 'C%A'


--- all last name should have character A and X in between 
SELECT * FROM Customer_SubSet_A where lastname like '%A%X%'

--Amanda
--- all firstname which should have 'ma' as string in the name
SELECT * FROM Customer_SubSet_A where FirstName like '%ma%'


--- positional conditions 
--- All the names where 2nd charcter is A
SELECT * FROM Customer_SubSet_A where FirstName like '_A%'

SELECT * FROM Customer_SubSet_A where FirstName like '__A%'

SELECT * FROM Customer_SubSet_A where FirstName like '%A_'

--- Like operator with Range statements 
SELECT * FROM Customer_SubSet_A where FirstName like '[B-D]%' order by FirstName

SELECT * FROM Customer_SubSet_A where FirstName like '%[X-Z]_' order by FirstName

--- firstname should ends up with either X OR A OR D OR S
SELECT * FROM Customer_SubSet_A where FirstName like '%[XADS]' order by FirstName

--- firstname should not ends up with either X OR A OR D OR S
SELECT * FROM Customer_SubSet_A where FirstName  not like '%[XADS]' order by FirstName

--- first name should ends with XADS
SELECT * FROM Customer_SubSet_A where FirstName  like '%XADS' order by FirstName

SELECT * FROM Customer_SubSet_A where FirstName  like '%SA' order by FirstName


--- Arthimaetic operators 
 ---- either on integer values or decimal values
-- + , - , * , / , %

select 1 + 2
select 1 - 2
select 2 * 2
select 2 / 2
select 13 % 5  -- remainder

select * from Customer_SubSet_A
-- ALIAS name -- you can put differnt column name for a calculation
select firstname,lastname, firstname + ','  +lastname AS [FullName] from Customer_SubSet_A  -- 0 


select firstname as [Customer Name],lastname as [Customer Name Last], firstname + ','  +lastname AS [FullName] from Customer_SubSet_A  -- 0 



---- multiple conditions for the WHERE  AND & OR Clauses 

/*

AND				OR		
A	B			A	B	
TRUE	TRUE	TRUE		TRUE	TRUE	TRUE
TRUE	FALSE	FALSE		TRUE	FALSE	TRUE
FALSE	TRUE	FALSE		FALSE	TRUE	TRUE
FALSE	FALSE	FALSE		FALSE	FALSE	FALSE


*/

--- marital staus should be married and gender should Males
--- All the male customers who are married
select * from Customer_Replica where MaritalStatus = 'M' AND GENDER = 'M'


--- All the customers  --- either they should be FEMALEs or Single
select * from Customer_Replica where Gender = 'F' 

select * from Customer_Replica where MaritalStatus = 'S' OR GENDER = 'F'


select * from Customer_Replica where firstname like 'AB%' and EnglishEducation IN ('Partial College','Bachelors')

--- comparison operators 

--- all the customers who's yearlyincome is grater than 50000 


select * from Customer_Replica where YearlyIncome > 50000 order by YearlyIncome desc
select * from Customer_Replica where YearlyIncome >= 50000 order by YearlyIncome desc
select * from Customer_Replica where YearlyIncome <= 50000 order by YearlyIncome desc