---- self join 
--- 
CREATE TABLE tblManagerReln
(
ID int,
EmpName varchar(100),
MgrID int
)


INSERT into tblManagerReln
values(5,'Sikka',3)

SELECT * FROM TBLMANAGERRELN


--- I wanted to find the employee name and their corresponding Manager's Name
SELECT * FROM TBLMANAGERRELN
select  M.EmpName as 'EmployeeName', 
		E.EmpName as 'ManagerName'
from tblManagerReln M inner join tblManagerReln E
							ON E.ID = M.MgrID

					
select   E.EmpName as 'EmployeeName',M.EmpName as 'ManagerName'
		 from tblManagerReln as E left outer join tblManagerReln as M
							ON E.MgrID = M.ID

--- SET OPERATORS
/*
UNION
UNION ALL
EXCEPT
INTERSECT
*/

CREATE TABLE tblC
(
id int,
color varchar(10)
)




insert into tblC
values(1,'RED')
insert into tblC
values(2,'YELLOW')
insert into tblC
values(3,'WHITE')


---- merge all the data and brings up the unique record set
---- order of column in each query should be of similar data type
select ID,color from tblA
UNION     
select ID,color from tblB

select * from tblA
select * from tblB
select * from tblC

select * from tblA
UNION     
select * from tblB
UNION 
select * from tblC


select tblA.ID,tblB.color,tblc.* from tblA full outer join tblB on tblA.ID = tblB.ID
					full outer join tblC on tblB.ID = tblC.ID

select * from tblA
UNION     
select * from tblB
UNION 
select * from tblC



select * from tblA  -- 3
UNION ALL
select * from tblB   -- 3
UNION ALL
select * from tblC   -- 3


select customerkey,yearlyincome from DimCustomer
union
select EmployeeKey,baserate from DimEmployee

use JB_2021


select * from tblA
select * from tblB
select * from tblC


select * from tblA
INTERSECT
select * from tblB
INTERSECT
select * from tblC


update tblC
set color = 'RED'
where id = 1

--- 10-2 = 8
--- (10-2)-5 = 3 
--- (A-b)-C

select * from tblA
select * from tblB
select * from tblC


select * from tblA
EXCEPT
select * from tblB  --- 2 white
EXCEPT
select * from tblC


select * from tblC

update tblC
set color = 'silver'
where id = 2



-----------------------------------------------
------------------Sub Query---------------------------

select color,count(*) from tblA group by color
UNION ALL
select color,count(*) from tblB group by color
UNION ALL
select color,count(*) from tblC group by color

------------------



use AdventureWorksDW2017


---- sub-queries 
--- CTEs  -- common table Expressions


select DP.EnglishProductName, FIS.SalesAmount  from FactInternetSales FIS inner join DimProduct DP
				on FIS.ProductKey = DP.ProductKey
				inner join DimProductSubcategory DPS on DP.ProductSubcategoryKey = dps.ProductSubcategoryKey
				where dps.EnglishProductSubcategoryName = 'Mountain Bikes'


select DP.EnglishProductName, FIS.SalesAmount  
from FactInternetSales FIS inner join DimProduct DP    --- 1
	 on FIS.ProductKey = DP.ProductKey                     
WHERE DP.ProductSubcategoryKey = --2
								(  select ProductSubcategoryKey -- 5
									from DimProductSubcategory   ---3 
									where EnglishProductSubcategoryName = 'Mountain Bikes'		-- 4											
									)

select DP.EnglishProductName, FIS.SalesAmount  
from FactInternetSales FIS inner join DimProduct DP    --- 1
	 on FIS.ProductKey = DP.ProductKey                     
WHERE DP.ProductSubcategoryKey IN --2
								(  select ProductSubcategoryKey -- 5
									from DimProductSubcategory   ---3 
									where EnglishProductSubcategoryName like '%Bikes'		-- 4											
									)

				select * from DimProductCategory
				select * from DimProductSubcategory  -- Mountain Bikes
				select * from DimProduct

----



select T.EnglishProductName, FIS.SalesAmount  
FROM 
		( select ProductKey,Color,EnglishProductName from DimProduct inner join	DimProductSubcategory
							on DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
						where EnglishProductSubcategoryName = 'Mountain Bikes'
			) AS T

			inner join FactInternetSales FIS
				ON T.ProductKey = FIS.ProductKey
		
