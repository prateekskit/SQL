USE JB_2021

--stored procedures

--- system procedures

sp_help tblcustomer
sp_helptext getDataTblCustomer


ALTER PROCEDURE getDataTblCustomer 
	@id int,
	@empid int
AS
BEGIN

	select * from tblcustomer where id = @id
	select * from tblEmployee where id = @empid

END

exec getDataTblCustomer 11011,5

--- IF and ELSE
--- TRANSACTION 
---- TRY, CATCH
/*
if my work is done
	I can leave
else if my work is halfdone
	I can do rest tomorrow
else
	I have to stay
*/

--- if ID exists in my table then please update else insert as a new record

ALTER PROCEDURE UpdInsTblCustomer
	@id int,@name varchar(100)	
AS
BEGIN
	declare @id_customer int
	set @id_customer = 0  --- dfault values
	select @id_customer = id
	 from tblcustomer where id = @id

		if (@id_customer = 0)
			BEGIN
				INSERT INTO tblcustomer 
				VALUES(@id,@name)
			END
		ELSE
			BEGIN
				update tblcustomer 
				set namee = @name
				where id = @id
			END

	select * from tblcustomer where id = @id
	
	EXEC getDataTblCustomer 11011,@id

END

select * from tblcustomer

exec UpdInsTblCustomer 11011,'Joe',



sp_help tblemployee

















