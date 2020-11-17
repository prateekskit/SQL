--USE AdventureWorks2017
--hI JANBASKK    --- comments


/*

SELECT Query Structure

SELECT <COLUMN NAME OR *>
FROM	<TABLE NAME>
WHERE <CONDITIONS>
*/


SELECT Name,GroupName
FROM [HumanResources].[Department]
WHERE GroupName = 'Research and Development'


---- CREATE TABLE SYNTAX
/*

CREATE TABLE <table name>
(
Define columns

)


*/

CREATE TABLE tblEmployee
(
EmpID int,  --- integer  
EmpName varchar(100),
salary float
)


select * from tblEmployee

/*

INSERT STATEMENT 

INSERT INTO <tablename>
VALUEs (,,)

 */

 INSERT INTO tblEmployee
 VALUES(1,'xyz',90.56)

 INSERT INTO tblEmployee(Empid,Salary)
 VALUES(1,90.56)

 select * from tblEmployee