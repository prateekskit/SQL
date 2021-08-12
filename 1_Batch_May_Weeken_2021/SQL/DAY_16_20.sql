use AdventureWorksDW2017

---------------- CTE - Common Table Expressions ------------------

select  * FROM
				(
							SELECT FIRSTNAME,GENDER,YEARLYINCOME, 
							ROW_NUMBER() OVER(order by yearlyincome desc ) AS 'ROW NUMBER',
							RANK() OVER(order by yearlyincome desc )  AS 'RANK',
							DENSE_RANK() OVER(order by yearlyincome desc )  AS 'DENSE_RANK'
							from table_customer							
				) AS T
WHERE RANK IN (3,4,5)



/*
WITH <CTE_Name>
AS
	(
			<My Logic>
	)
SELECT * FROM <CTE_Name>
*/

WITH CTE_ROWNUM
AS
	(
		SELECT FIRSTNAME,GENDER,YEARLYINCOME, 
							ROW_NUMBER() OVER(order by yearlyincome desc ) AS 'ROW NUMBER',
							RANK() OVER(order by yearlyincome desc )  AS 'RANK',
							DENSE_RANK() OVER(order by yearlyincome desc )  AS 'DENSE_RANK'
							from table_customer		
	)
SELECT * FROM CTE_TABLE WHERE RANK IN (2,3,4)

----------------------------------------------------------------------------------------------

WITH 
	CTE_ROWNUM
AS
	(
		SELECT FIRSTNAME,GENDER,YEARLYINCOME, 
							ROW_NUMBER() OVER(order by yearlyincome desc ) AS 'ROW NUMBER'
							from table_customer		
	)
,

	CTE_RANK
AS
	(
		SELECT FIRSTNAME,GENDER,YEARLYINCOME, 							
							RANK() OVER(order by yearlyincome desc )  AS 'RANK'							
							from table_customer		
	)
,
	CTE_DENSE_RANK
AS
	(
		SELECT FIRSTNAME,GENDER,YEARLYINCOME, 
							DENSE_RANK() OVER(order by yearlyincome desc )  AS 'DENSE_RANK'
							from table_customer		
	)
select * from CTE_ROWNUM inner join CTE_RANK
			ON CTE_ROWNUM.firstname = CTE_RANK.firstname
						inner join CTE_DENSE_RANK 
						ON CTE_DENSE_RANK.firstname = CTE_ROWNUM.firstname



---------------- TEMP TABLES-----------------------------------------

---- these tables gets created in the temPDB .. for a shorter period . 
------ it will be automaitcally deleted if the user session is over.

---- Local Temp Tables & Global Temp Tables






SELECT FIRSTNAME,GENDER,YEARLYINCOME, 
							ROW_NUMBER() OVER(order by yearlyincome desc ) AS 'ROW NUMBER',
							RANK() OVER(order by yearlyincome desc )  AS 'RANK',
							DENSE_RANK() OVER(order by yearlyincome desc )  AS 'DENSE_RANK'
							into #temp_rank
							from table_customer		



print 'x'
print 'hello'
select * from DimCustomer

select * from #temp_rank


-----  Global temp table 


SELECT FIRSTNAME,GENDER,YEARLYINCOME, 
							ROW_NUMBER() OVER(order by yearlyincome desc ) AS 'ROW NUMBER',
							RANK() OVER(order by yearlyincome desc )  AS 'RANK',
							DENSE_RANK() OVER(order by yearlyincome desc )  AS 'DENSE_RANK'
							into ##temp_Global
							from table_customer		


							select * from ##temp_Global
-----------------------------------------------------------------------------------------------------------------------


-------------- IF & ELSE blocks and the while loop-----------

DECLARE @x int    --- defining a varriable
SET @x = -1			--- initializing the varriable or setting a property for the varriable

IF(@x < 0)
	BEGIN
		print 'First Condition is passed'
		
	END
ELSE IF (@x  = 0)
	BEGIN
		print 'Second Condition is passed'
	END
ELSE
	BEGIN
		print 'Third Condition is passed'
	END

	truncate table table_customer
	SELECT * FROM table_customer

IF(EXISTS(select * from table_customer))
	BEGIN
		select * from table_customer		
	END
ELSE 
	BEGIN
		select * from DimCustomer
	END


------------------------------while LOOPS -------------------------------------


declare @x int 
SET @X = 10             --- initialized my loop

WHILE (@x < 10)             ----- conditions 
	BEGIN

		print @x
		SET @x = @x + 1    --- incremental conditions
	END


------------------------------- PROCEUDRES -------------------------------------------

---- what is the diff between procedures and functions --------------

--- system procedures & used defined procedures.

sp_help <tableName>
sp_help dimcustomer
sp_helptext fn_Age

sp_helptext sp_help

/*
CREATE PROCEDURE <proceudre_name>
	PArameters
AS
BEGIN

					

END
*/
select distinct englisheducation from DimCustomer
-----  I wanted to get the details about the dimcustomer based on there education level

select * from DimCustomer where EnglishEducation = 


CREATE PROCEDURE getCustomerByEducation 
						@EE nvarchar(100),@E
AS
BEGIN

		select * from DimCustomer where EnglishEducation = @EE

END
----------------------- 
ALTER PROCEDURE getCustomerByEducation 
						@EE nvarchar(100),@EO nvarchar(100)
AS
	BEGIN
		SELECT 'Data based on Education filter'
		select * from DimCustomer where EnglishEducation = @EE

		SELECT 'Data based on Occupation Filter'
		select * from DimCustomer where EnglishOccupation = @EO
	END

--------------------------------------------------------------------

--- this is going to be an explicit call
EXEC getCustomerByEducation 'Graduate Degree'

---------------------------------------------------------------------
use JB_May_2021
----- 
select * from tblEmployee
select * from tblDepartment

------ Create a procedure which do following things
	--- if an employee is already exists in employee table, simply return the rows.
	--- if an employee is new, then insert the data in the system.
sp_help tblemployee

--- ID should be unique
---- WE need to fetch the department id from tblDepartment

ALTER PROCEDURE EmployeeRecord
				@Name nvarchar(100),@gender varchar(10), @salary int, 
				@departmentName varchar(100)
AS
BEGIN
		IF EXISTS(select * from tblEmployee where name = @Name)
			select * from tblEmployee where name = @Name
		ELSE
			BEGIN
			    PRINT 'Inside the Else Block'
				DECLARE @id_new int 
				DECLARE @deptID_new int

				-- this query is fetching the latest ID from tblemployee and will be used to form a new id
				select @id_new = max(id) from tblEmployee
				--- this query is fetching the department id from department table.
				select @deptID_new = ID from tblDepartment where DepartmentName = @departmentName

						/*

						Check if the Department name exists in table department, if not
						then insert the department as new entry, fetch the ID of department
						and then use that ID, for the insertion of the employee.

						*/


				INSERT INTO tblEmployee
				VALUES(@id_new+1,@Name,@gender,@salary,@deptID_new)


				select * from tblEmployee where name = @Name 

			END
END









select * from tblEmployee
select * from tblDepartment
EXEC EmployeeRecord 'Monica','FeMale','8000','HR'

-------------------------------------------------------------- 06-06-2021---------------------------

ALTER PROCEDURE EmployeeRecord
				@Name nvarchar(100),@gender varchar(10), @salary int, 
				@departmentName varchar(100)
AS
BEGIN
		IF EXISTS(select * from tblEmployee where name = @Name)
			select * from tblEmployee where name = @Name
		ELSE
			BEGIN
			    PRINT 'Inside the first Else Block'
				DECLARE @id_new int 
				DECLARE @deptID_new int

				-- this query is fetching the latest ID from tblemployee and will be used to form a new id
				select @id_new = max(id) from tblEmployee
				--- this query is fetching the department id from department table.
				select @deptID_new = ID from tblDepartment where DepartmentName = @departmentName						

				------- if department does not exists then we have to insert the department first
					IF (@deptID_new is null OR @deptID_new = '')
						BEGIN							
							print 'Department Name does not exists'
							DECLARE @id_dept int
							select @id_dept = max(id) from tblDepartment
							--- insert the record in table department
							INSERT INTO tblDepartment(id,DepartmentName)
							VALUES(@id_dept+1,@departmentName)
							-- insert the record in table employee
							INSERT INTO tblEmployee
							VALUES(@id_new+1,@Name,@gender,@salary,@id_dept+1)

							select * from tblEmployee where name = @Name 

						END
					ELSE
						BEGIN
							print 'Department Name Already Exists'
							INSERT INTO tblEmployee
							VALUES(@id_new+1,@Name,@gender,@salary,@deptID_new)

							select * from tblEmployee where name = @Name 

						END
			END
END


ALTER PROCEDURE InsDepartment
				@DepartmentName varchar(100), @outparam int output
AS
BEGIN
		print 'Insert department procedure is called'
		DECLARE @deptID_new int
		select @deptID_new = ID from tblDepartment where DepartmentName = @departmentName						

				------- if department does not exists then we have to insert the department first
					IF (@deptID_new is null OR @deptID_new = '')
						BEGIN							
							print 'Department Name does not exists'
							DECLARE @id_dept int
							select @id_dept = max(id) from tblDepartment
							--- insert the record in table department
							INSERT INTO tblDepartment(id,DepartmentName)
							VALUES(@id_dept+1,@departmentName)
							
							SET @outparam = @id_dept+1

						END
			

END

declare @out int
EXEC InsDepartment 'Complaince', @out out
print @out



ALTER PROCEDURE EmployeeRecord
				@Name nvarchar(100),@gender varchar(10), @salary int, 
				@departmentName varchar(100)
AS
BEGIN
	print 'Insert Employee Record'
		IF EXISTS(select * from tblEmployee where name = @Name)
			select * from tblEmployee where name = @Name
		ELSE
			BEGIN
			    PRINT 'Inside the first Else Block'
				DECLARE @id_new int 
				DECLARE @deptID_new int

				-- this query is fetching the latest ID from tblemployee and will be used to form a new id
				select @id_new = max(id) from tblEmployee
				--- this query is fetching the department id from department table.
				select @deptID_new = ID from tblDepartment where DepartmentName = @departmentName						

				------- if department does not exists then we have to insert the department first
					IF (@deptID_new is null OR @deptID_new = '')
						BEGIN							
							print 'Department Name does not exists'
							
							declare @out int
							EXEC InsDepartment @departmentName, @out out						
							
							INSERT INTO tblEmployee
							VALUES(@id_new+1,@Name,@gender,@salary,@out)

							select * from tblEmployee where name = @Name 

						END
					ELSE
						BEGIN
							print 'Department Name Already Exists'
							INSERT INTO tblEmployee
							VALUES(@id_new+1,@Name,@gender,@salary,@deptID_new)

							select * from tblEmployee where name = @Name 

						END
			END
END

select * from tblEmployee
select * from tblDepartment
delete from tblDepartment where id = 7
EXEC EmployeeRecord 'Alyziee','FeMale','9000','Department10'


-------------------------------------------------------- VIEWS ------------------------------------
----  system views 
--- user views

--- views help us to implement the column level security as well as row level security	

use AdventureWorksDW2017


/*
Professional
NULL
Clerical
Manual
Management
Skilled Manual
*/


select distinct EnglishOccupation from DimCustomer


CREATE VIEW VW_GetCustomerProfessional
AS
select  * from DimCustomer where EnglishOccupation = 'Professional'


CREATE VIEW VW_GetCustomerClerical
AS
select  * from DimCustomer where EnglishOccupation = 'Clerical'


select * from VW_GetCustomerProfessional

select * from VW_GetCustomerClerical





ALTER VIEW VW_GetCustomerClerical
AS
select  FirstName,LastName,BirthDate,MaritalStatus,Gender,EmailAddress,EnglishEducation,EnglishOccupation
 from DimCustomer where EnglishOccupation = 'Clerical'


 select * from VW_GetCustomerClerical


 select * from [INFORMATION_SCHEMA].[TABLES]

 select * from INFORMATION_SCHEMA.VIEWS
 select * from INFORMATION_SCHEMA.COLUMNS


 ----------------------------------------------------------------- TRANSACTIONS------------------------

 --with  a BEGIN TRAN  there will be 	either a COMMIT TRAN  	OR  A ROLLBACK TRAN




	use JB_May_2021

	select * from tblDepartment


BEGIN TRAN
	UPDATE tblDepartment
	SET Location = 'Oslo'
	WHERE ID IN (5,6)
	
COMMIT TRAN
ROLLBACK TRAN


select * from tblDepartment

ALTER PROCEDURE PROC_Sample
AS
BEGIN

		BEGIN TRY
			BEGIN TRAN		
					UPDATE tblDepartment
					SET Location = 'Frankfurt'
					WHERE ID > 6
	
					select 1/0   --- error occured 

					UPDATE tblDepartment
					SET Location = 'Oslo'
					WHERE ID IN (5,6)
			COMMIT TRAN
		END TRY

		BEGIN CATCH
					ROLLBACK TRAN
				    print 'statement terminate'

		END CATCH
END
------------------------------------------------------------


----------------------------------------------------------- TRIGGERS-----------------------------------

--- are the properties for the tables.
--- DML triggers --- associated with tables and table operations like insert,update,delete
--- in SQL, we have some magic table - INSERTED & DELETED  generally accessible by TRIGGERS only,
-- inside triggers only
---  FOR/AFTER    &  INSTEAD OF


sp_help tblEmp_Logs

ALTER TABLE tblEmp_Logs ADD InsertedDate datetime2 
ALTER TABLE tblEmp_Logs ADD constraint df_date DEFAULT(getdate()) for InsertedDate
ALTER TABLE tblEmp_Logs ALTER COLUMN ID int identity(1,1)


select * from tblEmp_Logs

ALTER TRIGGER tr_InsEmp
ON tblEmployee
FOR INSERT,DELETE,UPDATE
AS
BEGIN
			If exists(select * from inserted)
			BEGIN
				insert into tblEmp_Logs(ID,name,gender,salary,departmentID)
				select * from inserted
			END
			else if exists(select * from inserted)
			BEGIN
				insert into tblEmp_Logs(ID,name,gender,salary,departmentID)
				select * from deleted
			END		

END

select * from tblEmployee
INSERT INTO tblEmployee
VALUES(103,'Jessica','Female',10000,5)

DELETE FROM tblEmployee where ID = 1

select * from inserted

UPDATE tblEmployee
set Name = 'Pina',
	Salary = 9000
where ID = 2

select * from tblEmp_Logs