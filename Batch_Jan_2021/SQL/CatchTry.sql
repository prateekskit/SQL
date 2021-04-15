ALTER PROCEDURE proc_sample
@id int
AS
BEGIN
	BEGIN TRY ----- TRY START
		BEGIN TRAN   --- TRAN Start here
			UPDATE tblEmployee set salary = 1000 where id = @id  -- 1
			WAITFOR DELAY '00:00:15'
			insert into tblEmployee(id,name,salary)
			VALUES(@id,'Jon',1100)  -- 2
			select * from tblEmployee where id = @id   -- 3
		COMMIT TRAN
			print 'transactions completed successfully'
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
			print 'transactions failed'
	END CATCH
END

use AdventureWorksDW2017
select * from dimcustomer

UPDATE DimCustomer
set title = 'Mr.'
where CustomerKey = 11000

begin tran
	UPDATE DimCustomer
	set Suffix = 'Jr.'
commit tran
rollback tran



exec proc_sample 6
	select * from tblEmployee
	sp_help tblemployee