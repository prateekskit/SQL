-- if else conditions
declare @x int 
set @x = -1

if (@x = 0)
	begin
	select * from DimCustomer
	end

else if (@x > 0)
	
	begin
	select * from DimCurrency
	end

else
	begin
	select * from DimEmployee
	end

--- while loop
declare @x int   -- declareation of varriable
set @x = 1

WHILE (@x < 10)   --- while loop condition
BEGIN
		print @x   -- logic
		set @x = @x + 1   -- increment operator condition

END

ALTER procedure getFemalecustomer
as
begin
--- 
	select * into #temp from DimCustomer where gender = 'F'

	declare @x int

	set @x = 0

	select @x = count(*) from #temp 

	if(@x <= 0)
		print 'no data'
	else
		print @x


	update #temp 
	set NumberCarsOwned = 3
	where MaritalStatus = 'M'

	select * from #temp

drop table #temp

end



ALTER PROCEDURE updSalarybyDeptID @salary int,@deptID int
AS
BEGIN
		
		update tblEmployee
		set salary = @salary
		where DepartmentId = @deptID

		select * from tblEmployee
END
