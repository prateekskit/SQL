--this command selects a specific database to execute my queries against
/*
this command selects a specific
database to execute my queries against
USE JB_2021
*/

USE JB_2021

---- DDL & DML Statements
--- DDL - DATA DEFINITION LANGUAGE     --- CREATE, ALTER, DROP, TRUNCATE,
--- DML - DATA MANIPULATIOn LANGUAGE   ---  select, insert, update, delete, merge

--- varchar, nvarchar, char
/*
CREATE TABLE <tblName>
(
<column1> <data type1>
<column2> <data type2>
)
*/

---2^31 (-2,147,483,648) to 2^31-1 (2,147,483,647)   4 BYTES
--- varchar, nvarchar , char
-- varchar(50)   -- varriable character
--- nvarchar(100)  

CREATE TABLE tblExample
(
ID int,
fname varchar(100),
gender char(1),
salary int
)

delete from tblExample

ALTER TABLE tblexample ADD age int

ALTER TABLE tblexample ALTER COLUMN fname int

select * from tblExample
/*
INSERT INTO <tblName>(<col1>,<col2>...)
VALUEs(<val1>,<val2>...)
*/

INSERT INTO tblExample
VALUES(1,'jb_1','F',25000)

INSERT INTO tblExample(id,salary)
VALUES(1,25000)



select id,salary 
from tblExample

SELECT * FROM DimCustomer


--- locate the table in another database at same server
---- copy over the data to new database with SELECT * INTO command.
select * into dimcustomer_jb from AdventureWorksDW2017.dbo.DimCustomer
select *  from AdventureWorksDW2017.dbo.DimCustomer
select * into dimcustomer_jb from AdventureWorksDW2017.dbo.DimCustomer

select firstname,lastname,birthdate into dimcustomer_name
from AdventureWorksDW2017.dbo.DimCustomer
drop table dimcustomer_name
select * from dimcustomer_name

use JB_2021

CREATE TABLE tblcustomer1
(
id int,
namee varchar(max)
)

insert into tblCustomer
select customerkey,FirstName+' '+ lastname from 
AdventureWorksDW2017.dbo.DimCustomer

select * from AdventureWorksDW2017.dbo.DimCustomer

select customerkey,FirstName+ISNULL(MiddleName,'x')+lastname from 
AdventureWorksDW2017.dbo.DimCustomer

select 1*2

select 'jan'+'bask'

select * from dimcustomer_jb

update <table_name>
SET <column_name> = specified values,
	<columna_name> = specified values
WHERE <conditions>


update dimcustomer_jb
set MiddleName = 'YY',
	Title = 'Mrs.'
WHERE Customerkey = 18029

DELETE FROM <tableName> where <condditons>

delete from dimcustomer_jb where CustomerKey = 18029

TRUNCATE TABLE dimcustomer_jb

select * from dimcustomer_jb
DROP TABLE 


--- IDENTITY(BASE,SEED)
--- IDENDITY(1,1)    --- 1 --- 1+1 -- 1+1 
--- IDENDITY(100,10000)    --- 100 --- 100+10000 -- 1+1 

CREATE TABLE tblEmp
(
ID  int identity(100,10000),
name varchar(max),
city varchar(max)
)
drop table tblEmp
select * from tblEmp

insert into tblEmp
values('Hikoro','Tokyo')

--20100    --- 30100
delete from tblEmp

truncate table tblEmp

drop table tblEmp