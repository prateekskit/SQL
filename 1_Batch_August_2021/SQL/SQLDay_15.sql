------------ Stored Procedures-------------

--- you can perform update,insert,delete operations
--- they does not return a value 
---- you can't use SP with your regular query. name of sp with select,or from or where clause
--- SP are independent entitities

--- system defined and user defined
--- system defined SPs

sp_help and sp_helptext 

use JB_2021

EXEC sp_help tblemployee
EXEC sp_helptext [sp_help]
use JB_2021
EXEC sp_helptext [dbo.fn_age]


------------------------------------------- User Defined SP------------------------------------
select * from dimcustomer_Bakcup
select * from tblEmployee

ALTER PROCEDURE getCustomerData 	
	@education nvarchar(100),@income int
AS
	BEGIN
		SELECT * 
		FROM DIMCUSTOMER_BAKCUP
		WHERE ENGLISHEDUCATION = @EDUCATION
		AND		YEARLYINCOME = @INCOME
	END
	
	EXEC getCustomerData 'Bachelors',10000


select * from tblEmployee

insert into tblEmployee
values(11,'Mike','Male',9000,2)

ALTER PROCEDURE insrtemployee 
	@ID int,
	@name nvarchar(20),
	@gender varchar(10),
	@salary int,
	--@did int 
	@departmentname varchar(100)
AS
	BEGIN
		if exists(select * from tblEmployee where id = @ID)
			begin
				select * 
				from tblEmployee
				where id = @ID

				--select 'Data is already present with id = ' + CAST(@id as varchar)
				print 'Data is already present with id = ' + CAST(@id as varchar)
			end

		else if not exists(select * from tblDepartment where id = @did)
			begin
				select 'department ID is not present in the table department'
				select 'expected values are' + '1,2,3,4'
			end

		else
			
			begin
				insert into tblEmployee
				values(@ID,@name,@gender,@salary,@did)				

				select * 
				from tblEmployee
				where id = @ID

				print 'Record Inserted'

			end

	END

EXEC insrtemployee 22,'Roaan','FeMale',7000,4

select * from tblDepartment

/*
1. Alter the SP, and instead of passing the department id, pass department name 
2. if department name exists in the table department then fetch the department ID values from here
3. use the department id value to insert the data in table employee
4. if department name does not exists in the table department, then first insert the department and
	get the latest inserted department id from table department.
*/

--

declare @id int
select @id = id from tblDepartment where DepartmentName = 'HR'
print @id  

