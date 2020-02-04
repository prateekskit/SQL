-- system defined stored procedure

sp_help tblMailingAddress
sp_helptext sp_GetMailingAddr
sp_help vWEmployeesByDepartment
sp_tables
sp_columns tblEmployee
Sp_depends tblemployee
sp_help tblemployee

sp_helptext sp_columns




create procedure sp_GetMailingAddr
AS
begin
select * from tblMailingAddress
end

sp_GetMailingAddr 'berlin'

ALTER PROCEDURE sp_GetMailingAddr
@param_city varchar(10)
AS
begin
select * from tblMailingAddress where city = @param_city
end




select * from tblMailingAddress

select * from sp_GetMailingAddr

exec sp_GetMailingAddr


--- User Defined Stored Procs

-- insert/update & delete opertaion with help of a stored procedure

CREATE PROCEDURE <procedure_Name> ( parameter 1 data_type, parameter 2 )
AS
BEGIN
<logic>
END




ALTER PROCEDURE sptblEmployeeSelect
AS
BEGIN
SELECT * FROM tblEmployee
end

exec sptblEmployeeSelect

ALTER PROCEDURE sptblEmployeeSelect
@departmentID int
AS 
BEGIN
select * from tblEmployee where DepartmentId = @departmentID
end

exec sptblEmployeeSelect 4
select * from tblEmployee where DepartmentId = 2


--- insert into tbldepartment about information of new department
select * from tblDepartment

sp_help tblDepartment

ALTER PROCEDURE sp_InsertDept
@departmentID int,
@name varchar(100),
@location nvarchar(100),
@departmenthead nvarchar(100)
AS 
BEGIN

insert into tblDepartment
values(@departmentID,@name,@location,@departmenthead)

exec sp_GetDept @departmentID

end	


create procedure sp_GetDept
@departmentID int
AS
BEGIN
select * from tblDepartment where ID = @departmentID
END

sp_InsertDept 12,'security','Africa','Henry'

select * from tblDepartment

--select * from tblDepartment



select * from depar
--output parameter

ALTER Procedure spGetEmployeeCountByGender
@Gender nvarchar(20),
@EmployeeCount int Output
as
Begin
 Select @EmployeeCount = COUNT(Id) 
 from tblEmployee 
 where Gender = @Gender
End 

declare @count int
exec spGetEmployeeCountByGender 'Male',@count out
print @count



ALTER PROCEDURE spUpdateEmployeebyCount
@gender nvarchar(20)
AS
BEGIN
declare @count int
declare @str varchar(100)
exec spGetEmployeeCountByGender @gender,@count out

if(@count > 5)
	begin
		update tblEmployee
		set salary = 10000
		where id = 1

		select * from tblEmployee
	end
else
	begin
		Print 'none'
	end
END

select * from tblEmployee
spUpdateEmployeebyCount 'male'

Declare @count int
Execute spGetEmployeeCountByGender 'Female', @count
if(@count is null)
 Print 'EmployeeTotal is null'
else
 Print 'EmployeeTotal is not null'
 ---- Try and catch error blocks



ALTER PROCEDURE sptblDeptInsert_withTry
@departmentID int,
@name varchar(100),
@location nvarchar(100),
@departmenthead nvarchar(100)
AS 
BEGIN
	
begin try
	begin tran
		insert into tblDepartment
		values(@departmentID,@name,@location,@departmenthead)
	commit tran
end try
begin catch
   rollback tran
   Select 
   ERROR_NUMBER() as ErrorNumber,
   ERROR_MESSAGE() as ErrorMessage,
   ERROR_PROCEDURE() as ErrorProcedure,
   ERROR_STATE() as ErrorState,
   ERROR_SEVERITY() as ErrorSeverity,
   ERROR_LINE() as ErrorLine
end catch
end

sptblDeptInsert_withTry 12,'Security','Japan','Ted Jhonson'
select * from tblDepartment

-- Error Handling with TRY & CATCH Blocks


ALTER procedure sp_test
as
begin
begin try
	--begin tran
	update tblEmployee
	set salary = 'nmsd'
	--commit tran
end try
begin catch
	--rollback tran
	print 'Please contact to your system Admin'
end catch
end

exec sp_test

update tbl
set xyz =4




select * from tblDepartment

begin tran


insert into tblDepartment
values(11,'security','Moscow','Kvitko')
 
update tblDepartment
set ID = 19
where DepartmentName = 'IT'

commit tran
rollback tran






sptblDeptInsert_withTry 4,'finance','London','Ted Jhonson'
select * from tblDepartment


---- to check the open transactions
--DBCC OPENTRAN;
--SELECT * FROM sys.sysprocesses WHERE open_tran = 1
