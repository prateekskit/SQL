ALTER procedure sp_gettableEmployee @name varchar(100),@id int output
AS
begin
		-- creating a temp table
		select * from tblEmployee
		select * from tblDepartment
		-- updating the temp table
		update tblEmployee
		set id = 100
		where name = @name
		--- populating the output parameter
		select @id = id from tblEmployee where name = @name
end


declare @x int
exec sp_gettableEmployee 'Sara',@x out
print @x
select * from tblEmployee where id = @x




ALTER procedure sp_updateEmployee @salary int, @id int
as
begin

		--- TRY & CATCH  BLOCKs
		BEGIN TRY
			BEGIN TRAN
				
				UPDATE tblEmployee
				set salary = @salary
				where id = @id

				set @salary = 100000/@salary
				select * from tblEmployee where id = @id
			COMMIT TRAN
		END TRY
		BEGIN CATCH
			print 'An error has occured, please contact your system admin'	
			ROLLBACK TRAN
		   Select 
		   ERROR_NUMBER() as ErrorNumber,
		   ERROR_MESSAGE() as ErrorMessage,
		   ERROR_PROCEDURE() as ErrorProcedure,
		   ERROR_STATE() as ErrorState,
		   ERROR_SEVERITY() as ErrorSeverity,
		   ERROR_LINE() as ErrorLine
		END CATCH
end

select 1/0
exec sp_updateEmployee 0,1
select * from tblEmployee



begin tran

update tblDepartment
set DepartmentName = 'IT'
where id = 1

commit tran
rollback tran


select * from tblDepartment
