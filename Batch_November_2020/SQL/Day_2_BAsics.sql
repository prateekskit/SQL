SELECT Name,GroupName
FROM [HumanResources].[Department]
WHERE GroupName = 'Research and Development'



----
CREATE TABLE tblEmployee
(
EmpID int,  --- integer  
EmpName varchar(100),  --- alpha numeric 100 bytes
City nvarchar(100),
IsFlag char(10),
salary float,
birthdate date,
IsContractor bit   --- 1 byte
)


-------DML - Data Manipulation Language syntax   
--- INSERT, UPDATE, DELETE statememnts are called as DML Syntax...

--- DDL - DATA Definition Language
---- Deals with strucutre creation,, CREATE A TABLE, DELETE/DROP a TABLE, TRUNCATE TABLE, ALTER TABLE

---- how to copy the data from one table to another 
--- query the table which is udner another database system.

select * from AdventureWorksDW2017.dbo.DimCustomer

SELECT * into DimCustomerCopy 
FROM  AdventureWorksDW2017.dbo.DimCustomer

select * from DimCustomerCopy



---- Copy over the data in existing table.



select * from AdventureWorksDW2017.dbo.DimCustomer

SELECT * into DimCustomerCopy 
FROM  AdventureWorksDW2017.dbo.DimCustomer

select * from DimCustomerCopy

CREATE TABLE customer
(
Firstname varchar(1000),
LastNAme varchar(1000),
emailaddress nvarchar(1000)
)

select * from customer

insert into customer
select Firstname,LastNAme,emailaddress from DimCustomerCopy
WHERE Firstname  = 'Jerry'

----- UPDATE the entries in an existing table.

select * from DimCustomerCopy

UPDATE DimCustomerCopy
SET FirstName = 'stiffiny'						--- helpp you to set the values for a column
WHERE FirstName = 'Destiny' 
AND CustomerKey = 12194

DELETE FROM DimCustomerCopy
WHERE CustomerKey = 12194


--- DDL - DATA Definition Language
---- Deals with strucutre creation,, CREATE A TABLE, DELETE/DROP a TABLE, TRUNCATE TABLE, ALTER TABLE

select * from customer
--- if you want to know the details about the existing table sp_help

sp_help customer


-- Add a new column in existing table.
ALTER TABLE customer ADD birthdate datetime 
--- make the change in existing column
ALTER TABLE customer ALTER COLUMN LastNAme nvarchar(1000)
--- dropping an existing column......
ALTER TABLe customer DROP COLUMN birthdate 


-- remove the strucxture of table from memory
DROP TABLE DimCustomerCopy

--- truncate table statement will also act like DELETE table statement, it will remove the complete data from a table
--- but still it comes under the DDL operation.

TRUNCATE table customer 

--- AND OR NOT
SELECT *
FROM DIMcustomercopy
WHERE lastname = 'Morgan' AND maritalStatus = 'M'

/*  
		x			y		AND		OR

		TRUE		TRUE	TRUE	TRUE
		FALSE		TRUE	FALSE	TRUE
		TRUE		FALSE	FALSE	TRUE
		FALSE		FALSE	FALSE	false

*/

SELECT *
FROM DIMcustomercopy
WHERE lastname = 'Morgan' AND maritalStatus = 'p'

SELECT *
FROM DIMcustomercopy
WHERE lastname = 'Morgan' or maritalStatus = 'p'

SELECT *
FROM DIMcustomercopy
WHERE lastname = 'XXXXXXX' AND maritalStatus = 'p'

---- lIKE oPERATOR 


SELECT * FROM DIMcustomercopy 
where FIRSTNAME LIKE 'JAM%'


SELECT * FROM DIMcustomercopy 
where FIRSTNAME LIKE '%SA'


SELECT * FROM DIMcustomercopy 
where FIRSTNAME LIKE 'A%A'