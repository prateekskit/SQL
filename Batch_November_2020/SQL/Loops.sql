	--if  else

	--while loops 
	
	declare @fixedDose int
	declare @varriableDose int
	declare @mandatorydose int
	
	set @fixedDose = 10
	set @varriableDose = 100
	set @mandatorydose = 1000
	
	if (@fixedDose = 10)
		begin
			print @fixedDose
		end
	else if(@mandatorydose = 1000)
		begin
			print @mandatorydose
		end
	else
		begin
			print @varriableDose
		end


	select * from tblEmp
	delete from tblEmp

if exists(select * from tblemp)
	begin
		print 'there is data in table'
	end
else
	begin
		print 'there is no data in table'
	end






	-------- while loops


	declare @x int    --- declaring the varriable
	set @x  = 0
	while(@x  < 10)   --- setting up the condition
		begin
			--set @x = @x+1 ---- incrementing the varriable  @x = 0+1 - 1
			print @x 
		end





















