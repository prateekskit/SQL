exec sp_TestWhile 50

select * from tblEmployee
select * from tblDepartment



DROP PROCEDURE sp_TestWhile

ALTER PROCEDURE sp_InsTblEmployee
@empId int,@name nvarchar(100), @gender nvarchar(10), @salary int, @deptName nvarchar(100)
AS
BEGIN	

--- based on depatName passed to @depatName , we are fetching depatID from tblDepartment
DECLARE @departmentID int
SELECT @departmentID =  ID from tblDepartment WHERE DepartmentName = @deptName

-- INSERT data into tblemployees

--- @empID is exisiting into tblemployee

   INSERT INTO tblEmployee
   VALUES(@empId,@name,@gender,@salary,@departmentID) 

   --print ID already exists 
END

select * from tblemployee order by salary desc

select TOP 2 name from tblEmployee order by salary desc