--- Indexes 
select * from tblindex where city = 'London'



sp_help tblindex

-- indexed Views 

--indexed view & materilized view

drop table tblProduct

Create Table tblProduct_New
(
 ProductId int primary key,
 Name nvarchar(20),
 UnitPrice int
)

Insert into tblProduct Values(1, 'Books', 20)
Insert into tblProduct Values(2, 'Pens', 14)
Insert into tblProduct Values(3, 'Pencils', 11)
Insert into tblProduct Values(4, 'Clips', 10)
select * from tblProduct
select * from tblProductSales

Create Table tblProductSales
(
 ProductId int,
 QuantitySold int
)


Insert into tblProductSales values(1, 10)
Insert into tblProductSales values(3, 23)
Insert into tblProductSales values(4, 21)
Insert into tblProductSales values(2, 12)
Insert into tblProductSales values(1, 13)
Insert into tblProductSales values(3, 12)
Insert into tblProductSales values(4, 13)
Insert into tblProductSales values(1, 11)
Insert into tblProductSales values(2, 12)
Insert into tblProductSales values(1, 14)
/* Materilized View -- result set of query gets stored in     */

Create view vWTotalSalesByProduct
with SchemaBinding  --materilized
as
Select Name, 
SUM(ISNULL((QuantitySold * UnitPrice), 0)) as TotalSales, 
COUNT_BIG(*) as TotalTransactions
from dbo.tblProductSales
join dbo.tblProduct
on dbo.tblProduct.ProductId = dbo.tblProductSales.ProductId
group by Name

Create Unique Clustered Index UIX_vWTotalSalesByProduct_Name
on vWTotalSalesByProduct(Name) 


Create view vWTotalSalesByProduct_With
as
Select Name, 
SUM(ISNULL((QuantitySold * UnitPrice), 0)) as TotalSales, 
COUNT_BIG(*) as TotalTransactions
from dbo.tblProductSales
join dbo.tblProduct
on dbo.tblProduct.ProductId = dbo.tblProductSales.ProductId
group by Name


select * from vWTotalSalesByProduct
select * from vWTotalSalesByProduct_With