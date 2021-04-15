
declare @x int
exec   [dbo].[sp_InsTblEmployee] 18,'takishi','male',8500,'finance',@x output
print @x

If (@x = 12 )
print 

select * from tblDepartment
select * from tblEmployee

create procedure sp_InsertDept
@departmentID int, @deptname nvarchar(100), @location nvarchar(100), @deparHead nvarchar(100)
AS
BEGIN
INSERT INTO tblDepartment 
VALUES(@departmentID, @deptname, @location, @deparHead)
END


select * from tblEmployee
select * from tblDepartment

/* Agenda 
 
 1. Insert employee into tblEmployee 
 2. If department is not existing in tableDepartment then it shoudl be inserted into tableDepartment   */

ALTER PROCEDURE [dbo].[sp_InsTblEmployee]
@empId int,@name nvarchar(100), @gender nvarchar(10), @salary int, @deptName nvarchar(100),  -- input parameter
 @out int output   -- output parameter
AS
BEGIN	

--- based on depatName passed to @depatName , we are fetching depatID from tblDepartment
DECLARE @departmentID int

-- if department name exists in system then its ID shoud be stored in @departmentID
-- set a varriable with a value
SELECT @departmentID =  ID from tblDepartment WHERE DepartmentName = @deptName

-- INSERT data into tblemployees
--- if departmentName is exists in table department then employee should be inserted.
IF(@departmentID is not null)   
	
	BEGIN
		INSERT INTO tblEmployee
		VALUES(@empId,@name,@gender,@salary,@departmentID) 
	END

ELSE  --- if departmentName does not exists in table department then first we need to insert the department and then we need to insert the employee
	
	BEGIN
	--select * from tblDepartment
	    DECLARE @x int

	    SELECT top 1 @x =  ID from tblDepartment order by ID desc

		set @x = @x + 1

		exec sp_InsertDept @x,@deptName,NULL,NULL

		INSERT INTO tblEmployee
		VALUES(@empId,@name,@gender,@salary,@departmentID+1) 
	END

SELECT TOP 1 @out =  id FROM tblEmployee ORDER BY ID DESC

END

select * from tblEmployee