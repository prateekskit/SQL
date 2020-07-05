use jb_9_2020

-- to fetch the properties of any tables. stored procedure -- sp_help
sp_help tblEmp

USE jb_07_2020

--- fetching the data from other database if you are in different database scope
-- it will copy the structure and the data both
select * into tblempNew from jb_9_2020.dbo.tblEmp

---- create/copy a new table on the fly and insert the data as well

CREATE TABLE tblEmp_1
(
Id int,
[Name] nvarchar(100),  --- [] is to by pass the pre-defined sql syntax
Salary int,
Gender nvarchar(10)
)

select * from tblEmp_1

-- copy the data from one table to another without structure 
insert into tblEmp_1
select Id,[Name],Salary,Gender from tblempNew
-- UPDATE the data

-- MOST COMMON QUESTION IN INTERVIEW
nvarchar(10)   --- THIS store the foreign keywords
VARCHAR(10)   -- this store the keyword based on collation selected (lnaguage selected for database)
char(10)   --- similar to varchar but some storage differences

a varchar(1000),  --- dynamic in nature  
b char(2)         --- 

'Y' , 'N'
'M' & 'F' 

a = 'janbask'    
b = 'janbask'

--- UPDATE the data in the table.
select * from tblEmp_1
UPDATE tblEmp_1 
set [Name] = 'Rebbeca',
	Gender = 'Female'
where ID = 1
-- DML -- DATA MANIPULATION SYNTAX
INSERT
UPDATE
DELETE
SELECT

delete from tblEmp_1 where Id = 1
select * from tblEmp_1

-- Trasaction Control Language 
 select * from tblEmpNew
begin tran
 UPDATE tblEmpNew 
	set [Name] = 'Jonas',
	Gender = 'Male'
	where ID = 1
--COMMIT TRAN
--ROLLBACK TRAN



-- DDL -- DATA DEFINITION LANG SYNTAX
CREATE TABLE
ALTER TABLE tblEmp_1 alter column 
DROP
TRUNCATE 
TRUNCATE table tblEmp_1

use AdventureWorksDW2017

select * from DimCustomer
select firstname,lastname from DimCustomer
select * from DimCustomer where CustomerKey = 11111
-- all the customers who are married and female
select * from DimCustomer where MaritalStatus = 'M' AND GENDER = 'F'
--- all the customers, who are either married or female
select * from DimCustomer where MaritalStatus = 'M' OR GENDER = 'F'

select * from DimCustomer where YearlyIncome > 80000 -- < <=
select * from DimCustomer where YearlyIncome <= 90000.00 -- < <= >= >
-- not equal to
select * from DimCustomer where TotalChildren != 0
select * from DimCustomer where TotalChildren <> 0
select * from DimCustomer where FirstName like 'Et%'
select * from DimCustomer where FirstName like 'A%'
select * from DimCustomer where FirstName like 'A%A'
select * from DimCustomer where FirstName like '%A'

---Some Other Examples.

select * from DimCustomer where	lastname like 'B__k%'	
select * from DimCustomer where	lastname like '_k%'	
select * from DimCustomer where phone like '6_1%'
-- first character in last name will be either Y or Z
select * from DimCustomer where	lastname like '[YZ]%'
--start with A B C or you can specifiy range	
select * from DimCustomer where lastname like '[A-C]%'	
--- ^ Range not in specified character
select * from DimCustomer where lastname like '[^A-C]%'	



