use AdventureWorksDW2017

select count(*) from DimProductCategory   --40
select count(*) from DimProductSubcategory   -- 370
select count(*) from DimProduct where color= 'Black'   -- 6060  -- 1330
select count(*) from FactInternetSales   -- 60398000

select DPC.EnglishProductCategoryName,DPS.EnglishProductSubcategoryName
		,DP.EnglishProductName,FIS.SalesAmount
 FROM FactInternetSales FIS inner join DimProduct DP
			ON FIS.ProductKey = DP.ProductKey
			inner join DimProductsubCategory DPS
			ON DP.ProductSubcategoryKey = dps.ProductSubcategoryKey
			inner join DimProductCategory DPC 
			on DPC.ProductCategoryKey = dps.ProductCategoryKey
			inner join DimSalesTerritory DST on
					FIS.SalesTerritoryKey = DST.SalesTerritoryKey
			WHERE DP.Color = 'Black'
					AND DST.SalesTerritoryCountry = 'United States'



/*
I want all the product related information including product name,category 
and subcategory with sales amount.

but I want only for the products which is having color in BLACK and sold 
in United States.
*/

SELECT 
	T_PRODUCT.EnglishProductCategoryName,T_PRODUCT.EnglishProductSubcategoryName
	,T_PRODUCT.EnglishProductName,T_PRODUCT.color, FIS.SalesAmount,
	(
	select firstname + ' ' + lastname from DimCustomer
	WHERE CustomerKey = FIS.CustomerKey)  as 'Name'
	FROM 
		--- intermdediate results set stored for temproary basis in SQL
		(
			SELECT DP.ProductKey,DP.EnglishProductName,DP.Color
			,DPS.EnglishProductSubcategoryName,
			DPC.EnglishProductCategoryName			
			 FROM DimProduct DP inner join DimProductsubCategory DPS
			ON DP.ProductSubcategoryKey = dps.ProductSubcategoryKey
			inner join DimProductCategory DPC 
			on DPC.ProductCategoryKey = dps.ProductCategoryKey
			WHERE DP.Color = 'Black'
		)  AS T_PRODUCT
	INNER JOIN FactInternetSales FIS 
			ON FIS.ProductKey = T_PRODUCT.ProductKey
	WHERE FIS.SalesTerritoryKey 
	IN 	( SELECT SalesTerritoryKey from DimSalesTerritory
				WHERE SalesTerritoryCountry = 'United States')

select * from T_PRODUCT
			
			select * from FactInternetSales
			select * from DimCustomer
			select * from DimSalesTerritory

---CTE --- COMMON TABLE EXPRESSIONS

use JB_08_2020
/* 
get the 
*/
SELECT * 
	FROM
		(
		select *,
		ROW_NUMBER() OVER(order by salary desc) as 'row_numberr',
		RANK() OVER(order by salary desc) as 'rank_1',
		DENSE_RANK() OVER(order by salary desc) as 'dense_rank_2'	
		from tblEmployee
	 ) AS T_RANK
WHERE row_numberr in (2,3,4)




WITH CTE_TABLE 
AS
(
	select *,ROW_NUMBER() OVER(order by salary desc) as 'row_numberr'
	FROM tblEmployee
),
CTE_TABLE_B
AS
(
	select *,ROW_NUMBER() OVER(order by salary desc) as 'row_numberr'
	FROM tblEmployee
)
select * from CTE_TABLE where row_numberr IN (2,3,4)
UNION 
select * from CTE_TABLE_B where row_numberr IN (2,3,4)




	




/*   if we want to fetch the department name and  total employee whose count is more than 2 from tables 

select * from tblEmployee
select * from tblDepartment 

*/

-- one way
Create view vWEmployeeCount
as
Select DepartmentName, DepartmentId, COUNT(*) as TotalEmployees
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId = tblDepartment.ID
group by DepartmentName, DepartmentId

Select DepartmentName, TotalEmployees 
from vWEmployeeCount
where  TotalEmployees >= 2

-- second way to write same query
Select DepartmentName, DepartmentId, COUNT(*) as TotalEmployees
into #TempEmployeeCount
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId = tblDepartment.ID
group by DepartmentName, DepartmentId

Select DepartmentName, TotalEmployees
From #TempEmployeeCount
where TotalEmployees >= 2


--- third way using table varriable
/*Just like TempTables, a table variable is also created in TempDB. The scope of a table variable is the batch,
 stored procedure, or statement block in which it is declared. They can be passed as parameters between procedures.*/

  Declare @tblEmployeeCount table
(DeptName nvarchar(20),DepartmentId int, TotalEmployees int)

Insert @tblEmployeeCount
Select DeptName, DepartmentId, COUNT(*) as TotalEmployees
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId = tblDepartment.DeptId
group by DeptName, DepartmentId

Select DeptName, TotalEmployees
From @tblEmployeeCount
where  TotalEmployees >= 2


---- using derived table

Select DeptName, TotalEmployees
from 
 (
  Select DeptName, DepartmentId, COUNT(*) as TotalEmployees
  from tblEmployee
  join tblDepartment
  on tblEmployee.DepartmentId = tblDepartment.DeptId
  group by DeptName, DepartmentId
 ) 
as EmployeeCount
where TotalEmployees >= 2




-- using CTE
--select * from tblDepartment
With EmployeeCount(DepartmentName, DepartmentId, TotalEmployees)
as
(
 Select DepartmentName, DepartmentId, COUNT(*) as TotalEmployees
 from tblEmployee
 join tblDepartment
 on tblEmployee.DepartmentId = tblDepartment.DeptId
 group by DepartmentName, DepartmentId
)
Select DepartmentName, TotalEmployees
from EmployeeCount
where TotalEmployees >= 2


select * from EmployeeCount


-- Multiple CTEs 

With EmployeesCountBy_Payroll_IT_Dept(DepartmentName, Total)
as
(
 Select Departmentname , COUNT(tblEmployee.Id) as TotalEmployees
 from tblEmployee 
 join tblDepartment 
 on tblEmployee.DepartmentId = tblDepartment.deptID
 where Departmentname IN ('Payroll','IT')
 group by Departmentname
),
EmployeesCountBy_HR_Admin_Dept(DepartmentName, Total)
as
(
 Select Departmentname, COUNT(tblEmployee.Id) as TotalEmployees
 from tblEmployee
 join tblDepartment 
 on tblEmployee.DepartmentId = tblDepartment.deptID
 group by Departmentname 
)
Select * from EmployeesCountBy_HR_Admin_Dept 
UNION
Select * from EmployeesCountBy_Payroll_IT_Dept


--- recusrsive CTE

Create Table tblEmployeeMgr
(
  EmployeeId int Primary key,
  Name nvarchar(20),
  ManagerId int
)

Insert into tblEmployeeMgr values (1, 'Tom', 2)
Insert into tblEmployeeMgr values (2, 'Josh', null)
Insert into tblEmployeeMgr values (3, 'Mike', 2)
Insert into tblEmployeeMgr values (4, 'John', 3)
Insert into tblEmployeeMgr values (5, 'Pam', 1)
Insert into tblEmployeeMgr values (6, 'Mary', 3)
Insert into tblEmployeeMgr values (7, 'James', 1)
Insert into tblEmployeeMgr values (8, 'Sam', 5)
Insert into tblEmployeeMgr values (9, 'Simon', 1)


-- one way
Select Employee.Name as [Employee Name],
IsNull(Manager.Name, 'Super Boss') as [Manager Name]
from tblEmployeeMgr Employee
left join tblEmployeeMgr Manager
on Employee.ManagerId = Manager.EmployeeId

 -- with CTE
With
  EmployeesCTE (EmployeeId, Name, ManagerId, [Level])
  as
  (
    Select EmployeeId, Name, ManagerId, 1
    from tblEmployee
    where ManagerId is null
    
    union all
    
    Select tblEmployee.EmployeeId, tblEmployee.Name, 
    tblEmployee.ManagerId, EmployeesCTE.[Level] + 1
    from tblEmployee
    join EmployeesCTE
    on tblEmployee.ManagerID = EmployeesCTE.EmployeeId
  )
Select EmpCTE.Name as Employee, Isnull(MgrCTE.Name, 'Super Boss') as Manager, 
EmpCTE.[Level] 
from EmployeesCTE EmpCTE
left join EmployeesCTE MgrCTE
on EmpCTE.ManagerId = MgrCTE.EmployeeId



--- UNION , INTERSECT & EXCEPT & UNION ALL

Create Table TableA
(
    Id int,
    Name nvarchar(50),
    Gender nvarchar(10)
)
Go

Insert into TableA values (1, 'Mark', 'Male')
Insert into TableA values (2, 'Mary', 'Female')
Insert into TableA values (3, 'Steve', 'Male')
Insert into TableA values (3, 'Steve', 'Male')
Go

Create Table TableB
(
    Id int primary key,
    Name nvarchar(50),
    Gender nvarchar(10)
)
Go

Insert into TableB values (2, 'Mary', 'Female')
Insert into TableB values (3, 'Steve', 'Male')
Insert into TableB values (4, 'John', 'Male')
Go




select * from tableA
select * from tableB

Select Id, Name, Gender from TableA
INTERSECT
Select Id, Name, Gender from TableB



-- PIVOT and UNPIVOT



Create Table tblPivot
(
 SalesAgent nvarchar(50),
 SalesCountry nvarchar(50),
 SalesAmount int 
)

Insert into tblpivot values('Tom', 'UK', 200)
Insert into tblpivot values('John', 'US', 180)
Insert into tblpivot values('John', 'UK', 260)
Insert into tblpivot values('David', 'India', 450)
Insert into tblpivot values('Tom', 'India', 350)
Insert into tblpivot values('David', 'US', 200)
Insert into tblpivot values('Tom', 'US', 130)
Insert into tblpivot values('John', 'India', 540)
Insert into tblpivot values('John', 'UK', 120)
Insert into tblpivot values('David', 'UK', 220)
Insert into tblpivot values('John', 'UK', 420)
Insert into tblpivot values('David', 'US', 320)
Insert into tblpivot values('Tom', 'US', 340)
Insert into tblpivot values('Tom', 'UK', 660)
Insert into tblpivot values('John', 'India', 430)
Insert into tblpivot values('David', 'India', 230)
Insert into tblpivot values('David', 'India', 280)
Insert into tblpivot values('Tom', 'UK', 480)
Insert into tblpivot values('John', 'US', 360)
Insert into tblpivot values('David', 'UK', 140) 


select * from tblPivot
-- wirte a query which returns TOTAL SALES, grouped by SALESCOUNTRY and SALESAGENT. The output should be as shown below

-- Pivoting
Select SalesCountry, SalesAgent, SUM(SalesAmount) as Total 
from tblpivot
group by SalesCountry, SalesAgent
order by SalesCountry, SalesAgent


Select SalesAgent,India, US, UK 
from tblpivot
Pivot 
(
   Sum(SalesAmount) for SalesCountry in ([India],[US],[UK])
) as PivotTable

-- unpivoting

Create Table tblunpivot
(
 SalesAgent nvarchar(50),
 India int,
 US int,
 UK int
)
Go

Insert into tblunpivot values ('David', 960, 520, 360)
Insert into tblunpivot values ('John', 970, 540, 800)
Go
select * from tblunpivot

SELECT SalesAgent, Country, SalesAmount
FROM tblunpivot
unpivot
(
       SalesAmount
       FOR Country IN (India, US ,UK)
) AS UnpivotExample


-- dynamic SQL