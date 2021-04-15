/*
First Proc  ---- Second Prod
SEcond PRoc  --- Third Prodce
*/

use JB_Nov_11

select * from tblEmployee
select * from tblDepartment

exec sp_InsTblEmployee 12,'Bella','FeMale',35468,'Security'

ALTER PROCEDURE [dbo].[sp_InsTblEmployee]
@empId int,@name nvarchar(100), @gender nvarchar(10), @salary int, @deptName nvarchar(100)
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
		    DECLARE @x int,@y int
			set @y = 0
			select top 1 @y = ID from tblDepartment order by id desc
			set @y = @y + 1
			exec SP_INSERTDEPT @y,@deptName,NULL,NULL, @x output
		
		INSERT INTO tblEmployee
		VALUES(@empId,@name,@gender,@salary,@x) 

	END
END

select * from tblEmployee
select * from tblDepartment

ALTER PROCEDURE SP_INSERTDEPT @id int, @deptname varchar(100),@Locat varchar(100), @head varchar(100), @id_new int out
AS
BEGIN
		INSERT into tblDepartment
		VALUES(@id,@deptname,@locat,@head)

		select top 1 @id_new =  id from tbldepartment order by id desc

END

declare @x int
exec SP_INSERTDEPT 5,'Medical','Uk','Mrxyz', @x output
print @x

select * from tbldepartment


