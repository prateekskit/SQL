-- transactions 
use db_2

Create Table tblPhysicalAddress
(
 AddressId int NOT NULL primary key,
 EmployeeNumber int,
 HouseNumber nvarchar(50),
 StreetAddress nvarchar(50),
 City nvarchar(10),
 PostalCode nvarchar(50)
)

Insert into tblPhysicalAddress values (3, 101, '#10', 'King Street', 'Londoon', 'CR27DW')

select * from tblPhysicalAddress

/* TRY CATCH BLOCK 
To get the errors from a system 
*/ 


ALTER PROCEDURE spUpdateAddress
as
Begin
 Begin Try
  Begin Transaction

  
   Update tblMailingAddress set City = 'LONDON LONDONASLDASDASDASDASDASDSADASD' 
   where AddressId = 1 and EmployeeNumber = 101
   
   Update tblPhysicalAddress set City = 'LONDON' 
   where AddressId = 1 and EmployeeNumber = 101
  Commit Transaction
 End Try
 Begin Catch
  print 'in catch block'
  Rollback Transaction

 End Catch
End 
exec spupdateAddress

Alter Procedure spUpdateAddress
as
Begin
 Begin Try
  Begin Transaction
   Update tblPhysicalAddress set City = 'LONDON12' 
   where AddressId = 1 and EmployeeNumber = 101
   
   Update tblPhysicalAddress set City = 'LONDON LONDON' 
   where AddressId = 1 and EmployeeNumber = 101
  Commit Transaction
 End Try
 Begin Catch
  Rollback Transaction
 End Catch
End

exec spUpdateAddress


-- diryt read,lost updates,non-repeatable reads,phantom reads

/* DEFAULT ISOLATION LEVEL FOR A TRANSACTION IS READ COMMITED     */
-- dirty read example 

Create table tblInventory
(
    Id int identity primary key,
    Product nvarchar(100),
    ItemsInStock int
)
Go
select * from tblInventory
truncate table tblInventory
Insert into tblInventory values ('iPhone', 10)
select * from tblinventory



	update tblInventory
	set ItemsInStock = 10

	Begin Tran
	Update tblInventory set ItemsInStock = 9 where Id=1

	-- Billing the customer
	Waitfor Delay '00:00:15'
	-- Insufficient Funds. Rollback transaction

	Rollback Transaction

--Transaction 2 : RUN IN ANOTHER WINDOW  -- remember default transaction level of SQL SERVER is READ COMMITTED 
--- first without setting up transaction
Set Transaction Isolation Level Read Uncommitted
Select * from tblInventory where Id=1


select * from tblInventory


--- LOST UPDATE ISSUES
-- REPEATABLE READ LOCK THE RESOURCES , on which it is doing the update. 
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
Begin Tran
Declare @ItemsInStock int
Select @ItemsInStock = ItemsInStock
from tblInventory where Id=1
-- Transaction takes 10 seconds
Waitfor Delay '00:00:15'
Set @ItemsInStock = @ItemsInStock - 1
--Set Transaction Isolation Level serializable
Update tblInventory
Set ItemsInStock = @ItemsInStock where Id=1
Print @ItemsInStock
Commit Transaction

--- run in different windows
select * from tblInventory
Begin Tran
Declare @ItemsInStock int

Select @ItemsInStock = ItemsInStock
from tblInventory where Id=1

-- Transaction takes 1 second
Waitfor Delay '00:00:5'
Set @ItemsInStock = @ItemsInStock - 2

Update tblInventory
Set ItemsInStock = @ItemsInStock where Id=1

Print @ItemsInStock

Commit Transaction




--- Non Repetable Read

-- Transaction 1
Begin Transaction
Select ItemsInStock from tblInventory where Id = 1

-- Do Some work
waitfor delay '00:00:10'
Set transaction isolation level repeatable read
Select ItemsInStock from tblInventory where Id = 1
Commit Transaction

-- Transaction 2
Update tblInventory set ItemsInStock = 10 where Id = 1

Set transaction isolation level repeatable read
Begin Transaction
Select ItemsInStock from tblInventory where Id = 1

-- Do Some work
waitfor delay '00:00:10'

Select ItemsInStock from tblInventory where Id = 1
Commit Transaction

-- Transaction 2
Update tblInventory set ItemsInStock = 10 where Id = 1


--- phantom read example
Create table tblE
(
    Id int primary key,
    Name nvarchar(50)
)
Go

Insert into tblE values(1,'Mark')
Insert into tblE values(3, 'Sara')
Insert into tblE values(100, 'Mary')

select * from tblE
Select * from tblE where Id between 1 and 3   --- 2 records 
delete from tblE where id = 2
truncate table tblE


-- Transaction 1
Begin Transaction
Select * from tblE where Id between 1 and 3
-- Do Some work
waitfor delay '00:00:10'
Select * from tblE where Id between 1 and 3
Commit Transaction

-- Transaction 2
Insert into tblE values(2, 'Marcus')


---- to resolve this issue

Set transaction isolation level serializable
Begin Transaction
Select * from tblE where Id between 1 and 3
-- Do Some work
waitfor delay '00:00:10'
Select * from tblE where Id between 1 and 3
Commit Transaction

-- Transaction 2

Insert into tblEmployees values(2, 'Marcus')

select * from tblE
delete from tblE where id = 2

---DEADLOCKSSs


Create table TableA
(
    Id int identity primary key,
    Name nvarchar(50)
)
Go

Insert into TableA values ('Mark')
Go

Create table TableB
(
    Id int identity primary key,
    Name nvarchar(50)
)
Go

Insert into TableB values ('Mary')

-- run one by one in seperate windows....
-- Transaction 1
Begin Tran
Update TableA Set Name = 'Mark Transaction 1' where Id = 1

-- From Transaction 2 window execute the first update statement

Update TableB Set Name = 'Mary Transaction 1' where Id = 1

-- From Transaction 2 window execute the second update statement
Commit Transaction


-- run one by one in seperate windows.---
-- Transaction 2
Begin Tran
Update TableB Set Name = 'Mark Transaction 2' where Id = 1

-- From Transaction 1 window execute the second update statement

Update TableA Set Name = 'Mary Transaction 2' where Id = 1

-- After a few seconds notice that one of the transactions complete
-- successfully while the other transaction is made the deadlock victim

Commit Transaction





---- Prevention of DeadLockss



--- Dynamic Querries

Create table tblDyn
(
     ID int primary key identity,
     FirstName nvarchar(50),
     LastName nvarchar(50),
     Gender nvarchar(50),
     Salary int
)
Go
select * from tblDyn
truncate table tblDyn

Insert into tblDyn values ('Mark', 'Hastings', 'Male', 60000)
Insert into tblDyn values ('Steve', 'Pound', 'Male', 45000)
Insert into tblDyn values ('Ben', 'Hoskins', 'Male', 70000)
Insert into tblDyn values ('Philip', 'Hastings', 'Male', 45000)
Insert into tblDyn values ('Mary', 'Lambeth', 'Female', 30000)
Insert into tblDyn values ('Valarie', 'Vikings', 'Female', 35000)
Insert into tblDyn values ('John', 'Stanmore', 'Male', 80000)
Go

Create Procedure spSearchEmployees
@FirstName nvarchar(100),
@LastName nvarchar(100),
@Gender nvarchar(50),
@Salary int
As
Begin

     Select * from tblDyn where
     (FirstName = @FirstName OR @FirstName IS NULL) AND
     (LastName  = @LastName  OR @LastName  IS NULL) AND
     (Gender      = @Gender    OR @Gender    IS NULL) AND
     (Salary      = @Salary    OR @Salary    IS NULL)
End
Go




Declare @sql nvarchar(1000)
Declare @params nvarchar(1000)

Set @sql = 'Select * from tblDyn where FirstName=@FirstName and LastName=@LastName'
Set @params = '@FirstName nvarchar(100), @LastName nvarchar(100)'

Execute sp_executesql @sql, @params, @FirstName='Ben',@LastName='Hoskins'


ALTER Procedure spSearchEmployeesBadDynamicSQL
@FirstName nvarchar(100) = NULL,
@LastName nvarchar(100) = NULL,
@Gender nvarchar(50) = NULL,
@Salary nvarchar(50) = NULL
As
Begin

     Declare @sql nvarchar(max)

     Set @sql = 'Select * from tblDyn where 1 = 1'
         
     if(@FirstName is not null)
          Set @sql = @sql + ' and FirstName=''' + @FirstName + ''''
     if(@LastName is not null)
          Set @sql = @sql + ' and LastName=''' + @LastName + ''''
     if(@Gender is not null)
          Set @sql = @sql + ' and Gender=''' + @Gender + ''''
     if(@Salary is not null)
          Set @sql = @sql + ' and Salary=''' + @Salary + ''''
	--	  print @sql
     Execute sp_executesql @sql
End
Go
select * from tblDyn
exec spSearchEmployeesBadDynamicSQL NULL,'Hastings',NULL,NULL