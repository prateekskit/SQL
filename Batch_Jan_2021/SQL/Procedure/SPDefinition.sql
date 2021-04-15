/*

Whenever there is new customer inserted into the system, I want to fetch its customerID so that I can 
pass it on and get the details of newly inserted customer.

*/


ALTER PROCEDURE [dbo].[UpdInsDimCustomer] @customerKey int,@customerAlternatekey varchar(100),
									 @FirstName varchar(100),@LastName varchar(100),
									@birthDate date,	@emailaddress varchar(300), 
									@out_CustomerKey int out
AS
BEGIN
		IF exists(select * from DimCustomer where CustomerKey = @customerKey)	
			begin
				UPDATE DimCustomer
					set FirstName = @FirstName
					,LastName = @LastName
					,BirthDate=@birthDate
					,EmailAddress=@emailaddress
				WHERE CustomerKey = @customerKey

				print 'Update Query Executed Successfully for Customer ID' + CAST(@customerKey AS VARCHAR)

				set @out_CustomerKey = -1

			end
	   ELSE
			begin
				INSERT INTO DimCustomer(CustomerAlternateKey, FirstName,LastName,BirthDate,EmailAddress)
				VALUES(@customerAlternatekey,@FirstName,@LastName,@BirthDate,@EmailAddress)
			
				print 'Insert Query Executed Successfully for Customer ID' + cast(@customerKey AS varchar)

				select top 1 @out_CustomerKey = customerkey from dimcustomer order by CustomerKey desc

			END
			
	--exec  getCustomerDetails @customerKey

END
GO


