/* CTE   */

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

select * from tblDepartment
--- third way using table varriable
/*Just like TempTables, a table variable is also created in TempDB. The scope of a table variable is the batch,
 stored procedure, or statement block in which it is declared. They can be passed as parameters between procedures.*/

 Declare @tblEmployeeCount table
(DeptName nvarchar(20),DepartmentId int, TotalEmployees int)

Insert @tblEmployeeCount
Select DepartmentName, DepartmentId, COUNT(*) as TotalEmployees
from tblEmployee
join tblDepartment
on tblEmployee.DepartmentId = tblDepartment.ID
group by DepartmentName, DepartmentId

Select DeptName, TotalEmployees
From @tblEmployeeCount
where  TotalEmployees >= 2


---- using derived table

Select DepartmentName, TotalEmployees
from 
 (
  Select DepartmentName, DepartmentId, COUNT(*) as TotalEmployees
  from tblEmployee
  join tblDepartment
  on tblEmployee.DepartmentId = tblDepartment.ID
  group by DepartmentName, DepartmentId
 ) 
as EmployeeCount
where TotalEmployees >= 2




-- using CTE  -- COMMON TABLE EXPRESSIONS
--select * from tblDepartment

/*
 CTE Syntax 
 */

 WITH <Reference/Alias_name> (<col1>,<col2>,....<coln>)
 AS
 (
 /*Do your calcuations*/
 )
 SELECT <<Reference/Alias_name> 


With EmployeeCount(DepartmentName, DepartmentId, TotalEmployees)
as
(
 Select DepartmentName, DepartmentId, COUNT(*) as TotalEmployees
 from tblEmployee
 join tblDepartment
 on tblEmployee.DepartmentId = tblDepartment.ID
 group by DepartmentName, DepartmentId
)
Select DepartmentName, TotalEmployees
from EmployeeCount
where TotalEmployees >= 2


select * from EmployeeCount


-- Multiple CTEs -- having multi level statements and then use them at once. It will help to divide the queries in few steps and then
-- ultimately getting some results

With EmployeesCountBy_Payroll_IT_Dept(DepartmentName, Total)
as
(
 Select Departmentname , COUNT(tblEmployee.Id) as TotalEmployees
 from tblEmployee 
 join tblDepartment 
 on tblEmployee.DepartmentId = tblDepartment.ID
 where Departmentname IN ('Payroll','IT')
 group by Departmentname
),
EmployeesCountBy_HR_Admin_Dept(DepartmentName, Total)
as
(
 Select Departmentname, COUNT(tblEmployee.Id) as TotalEmployees
 from tblEmployee
 join tblDepartment 
 on tblEmployee.DepartmentId = tblDepartment.ID
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

select * from tblEmployeeMgr
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
    from tblEmployeeMgr
    where ManagerId is null
    
    union all
    
    Select tblEmployeeMgr.EmployeeId, tblEmployeeMgr.Name, 
    tblEmployeeMgr.ManagerId, EmployeesCTE.[Level] + 1
    from tblEmployeeMgr
    join EmployeesCTE
    on tblEmployeeMgr.ManagerID = EmployeesCTE.EmployeeId
  )
Select EmpCTE.Name as Employee, Isnull(MgrCTE.Name, 'Super Boss') as Manager, 
EmpCTE.[Level] 
from EmployeesCTE EmpCTE
left join EmployeesCTE MgrCTE
on EmpCTE.ManagerId = MgrCTE.EmployeeId






-- PIVOT and UNPIVOT
/*
PIVOT -- you can certainly change the CELL values for columns and vice versa. Lets say in below table , currently we have values for SalesCountry
 as UK,US,INDIA. Then with help of pivoting , we can convert them in column values at run time. Beneficial only when you have few distinct values for a
 particular column. In this case we have only 3 distinct values for UK,US & INDIA
 */



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

--- Now, if you want to shocase , sales amount as country, you can use below PIVOT statement

Select SalesAgent,India, US, UK 
from tblpivot
Pivot -- SQL keyword
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


