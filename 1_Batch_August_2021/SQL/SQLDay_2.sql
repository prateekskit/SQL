-- Descriptions - Below command will create a new database.
-- CREATE DATABASE <USER POVIDED DATABASE NAME>
-- CREATE DATABASE <USER POVIDED DATABASE NAME>
/*
Hi
This is JANBASSK
This is going to 4th class for year 2021
*/

CREATE DATABASE JB_2021

--- below command will choose a specific database name, where you are going to perform some operations
USE JB_2021

USE AdventureWorksDW2017


----- 
/*

.MDF --  Primary Data File --- It stored the data contents of the database.  

.LDF --   Log Data File


*/

--- * means getting all the columns from a table
select * from dimAccount
--- good practice - not to put any space in your column names.

SELECT [CustomMembers],[AccountDescription],AccountKey
FROM DimAccount


---------- DATA TYPES--------------------
-----------.
--- int - which denotes the integer values OR Numeric Values ---
--- varchar, char, nvarchar ---- string or alphanumeric values
--- date - which spefically store the data values.
--- decimal, float, numeric - decimal values 


use jb_2021


/*
CREATE TABLE <user defined table name>
(
<column name 1> <datatype 1>,
<column name 2> <datatype 2>,
<column name 3> <datatype 3>,
....
....
...
<column name N> <datatype N>
)
*/

CREATE TABLE Emp
(
EmpID int,
EmpName varchar(300),
Salary decimal(18,2),
DOB datetime
)
select * from Emp



---- difference between varchar,nvarchar, char 
--- difference bettween float,decimal,numeric












