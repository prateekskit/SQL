ALTER PROCEDURE [dbo].[sp_InsTblEmployee]
@empId int,@name nvarchar(100), @gender nvarchar(10), @salary int, @deptName nvarchar(100), @out int output
AS
BEGIN	

--- based on depatName passed to @depatName , we are fetching depatID from tblDepartment
DECLARE @departmentID int
SELECT @departmentID =  ID from tblDepartment WHERE DepartmentName = @deptName

-- INSERT data into tblemployees

if(@departmentID is not null)
	BEGIN
		INSERT INTO tblEmployee
		VALUES(@empId,@name,@gender,@salary,@departmentID) 
	END
ELSE
	BEGIN

	    DECLARE @x int

	    SELECT top 1 @x =  ID from tblDepartment order by ID desc

		set @x = @x + 1

		exec [dbo.sp_InsertDept] @x,@deptName,NULL,NULL

		INSERT INTO tblEmployee
		VALUES(@empId,@name,@gender,@salary,@departmentID+1) 
	END

SELECT TOP 1 @out =  id FROM tblEmployee ORDER BY ID DESC

END