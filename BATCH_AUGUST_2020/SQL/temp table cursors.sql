-- # temp tables

insert into #temp_new
select *  from tblEmp where salary > 4500
delete from #temp_new


select * from tblEmp where salary > 4500
select * from #temp
select * from #temp_new

select * into ##temp_global from gender
select * from ##temp_global

drop table ##temp_global


-- # temprorary tables  -- gloabl and local 



-- Cusrsors --- Not good to use and should not be used often -- try to use case or other way instead 

Create Table tblProducts
(
 [Id] int identity primary key,
 [Name] nvarchar(50),
 [Description] nvarchar(250)
)

Create Table tblProductSale
(
 Id int primary key identity,
 ProductId int foreign key references tblProducts(Id),
 UnitPrice int,
 QuantitySold int
)


Declare @Id int
Set @Id = 1

While(@Id <= 300000)
Begin
 Insert into tblProducts values('Product - ' + CAST(@Id as nvarchar(20)), 
 'Product - ' + CAST(@Id as nvarchar(20)) + ' Description')
 
 Print @Id
 Set @Id = @Id + 1
End


declare @RandomProductId int
declare @RandomUnitPrice int
declare @RandomQuantitySold int

-- Declare and set variables to generate a 
-- random ProductId between 1 and 100000
declare @UpperLimitForProductId int
declare @LowerLimitForProductId int

set @LowerLimitForProductId = 1
set @UpperLimitForProductId = 100000

-- Declare and set variables to generate a 
-- random UnitPrice between 1 and 100
declare @UpperLimitForUnitPrice int
declare @LowerLimitForUnitPrice int

set @LowerLimitForUnitPrice = 1
set @UpperLimitForUnitPrice = 100

-- Declare and set variables to generate a 
-- random QuantitySold between 1 and 10
declare @UpperLimitForQuantitySold int
declare @LowerLimitForQuantitySold int

set @LowerLimitForQuantitySold = 1
set @UpperLimitForQuantitySold = 10

--Insert Sample data into tblProductSale table
Declare @Counter int
Set @Counter = 1

While(@Counter <= 450000)
Begin
 select @RandomProductId = Round(((@UpperLimitForProductId - @LowerLimitForProductId) * Rand() + @LowerLimitForProductId), 0)
 select @RandomUnitPrice = Round(((@UpperLimitForUnitPrice - @LowerLimitForUnitPrice) * Rand() + @LowerLimitForUnitPrice), 0)

 select @RandomQuantitySold = Round(((@UpperLimitForQuantitySold - @LowerLimitForQuantitySold) * Rand() + @LowerLimitForQuantitySold), 0)
 
 Insert into tblProductSale 
 values(@RandomProductId, @RandomUnitPrice, @RandomQuantitySold)

 Print @Counter
 Set @Counter = @Counter + 1
End

/*

select * from tblProducts
delete from tblProducts where id > 150000
select * from tblProductSale
delete from tblProductSale where id > 200000


*/


/*    CURSOR DEFINITION */ 

Declare @ProductId int
-- Declare the cursor using the declare keyword
Declare ProductIdCursor CURSOR FOR 
Select ProductId from tblProductSale
-- Open statement, executes the SELECT statment
-- and populates the result set
Open ProductIdCursor
-- Fetch the row from the result set into the variable
Fetch Next from ProductIdCursor into @ProductId
-- If the result set still has rows, @@FETCH_STATUS will be ZERO
While(@@FETCH_STATUS = 0)
Begin
 Declare @ProductName nvarchar(50)
 Select @ProductName = Name from tblProducts where Id = @ProductId
 
 if(@ProductName = 'Product - 55')
 Begin
  Update tblProductSale set UnitPrice = 55 where ProductId = @ProductId
 End
 else if(@ProductName = 'Product - 65')
 Begin
  Update tblProductSale set UnitPrice = 65 where ProductId = @ProductId
 End
 else if(@ProductName like 'Product - 100%')
 Begin
  Update tblProductSale set UnitPrice = 1000 where ProductId = @ProductId
 End
 Fetch Next from ProductIdCursor into @ProductId 
End
-- Release the row set
CLOSE ProductIdCursor 
-- Deallocate, the resources associated with the cursor
DEALLOCATE ProductIdCursor

-- check query
Select  Name, UnitPrice 
from tblProducts join
tblProductSale on tblProducts.Id = tblProductSale.ProductId
where (Name='Product - 55' or Name='Product - 65' or Name like 'Product - 100%') order by name

Update tblProductSale
set UnitPrice = 
 Case 
  When Name = 'Product - 55' Then 155
  When Name = 'Product - 65' Then 165
  When Name like 'Product - 100%' Then 10001
 End     
from tblProductSale
join tblProducts
on tblProducts.Id = tblProductSale.ProductId
Where Name = 'Product - 55' or Name = 'Product - 65' or 
Name like 'Product - 100%' 

-- Cursors 