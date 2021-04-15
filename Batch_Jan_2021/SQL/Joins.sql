sp_help dimcustomer
-------- INNER JOIN
use JB_2021

select * from tblEmployee  -- 10
select * from tblDepartment   --- 4

select * from tblEmployee E inner join tblDepartment D
							ON E.DepartmentId = D.ID
					
use AdventureWorksDW2017

-- site address , gpn values
select * from DimProduct  ---606
select * from DimProduct where ProductSubcategoryKey is not null  ---606
select * from DimProductCategory
select * from DimProductSubcategory



select DPC.EnglishProductCategoryName,DPS.EnglishProductSubcategoryName,
	DP.EnglishProductName	
 from DimProductCategory DPC inner join DimProductSubcategory DPS
						ON DPC.ProductCategoryKey =  DPS.ProductCategoryKey
						inner join DimProduct DP 
						ON DPS.ProductSubcategoryKey = DP.ProductSubcategoryKey




---- LFET JOIN or LEFT OUTER JOIN
use JB_2021

select * from tblEmployee  -- 10 
select * from tblDepartment   --- 4


select * from tblEmployee E inner join tblDepartment D
							ON E.DepartmentId = D.ID

select * from tblEmployee E LEFT OUTER join tblDepartment D
							ON E.DepartmentId = D.ID

select * from tblDepartment D LEFT OUTER join tblEmployee E
							ON E.DepartmentId = D.ID


select * from tblDepartment D RIGHT OUTER join tblEmployee E
							ON E.DepartmentId = D.ID

---FULL OUTER JOIN

select * from tblDepartment D FULL OUTER join tblEmployee E
							ON E.DepartmentId = D.ID
--- matching rows
--- 14 rows

CREATE TABLE tblA
(
ID int
)
INSERT INTO TBLA
VALUES(NULL)
INSERT INTO TBLB
VALUES(NULL)

CREATE TABLE tblB
(
ID int
)

select * from tblA
select * from tblB
-- 6
--6
--- inner join
-- 2  
select * from tblA inner join tblB on tblA.id = tblB.id 
select * from tblA LEFT OUTER join tblB on tblA.id = tblB.id 
select * from tblA FULL OUTER join tblB on tblA.id = tblB.id 

--- CROSS JOIN --- cartesian product

use jb_2021
select * from tblEmployee   --- 10 rows
select * from tblDepartment   --- 4 rows 
---40 

select * from tblEmployee,tblDepartment

--- self join
use AdventureWorksDW2017

select * from DimEmployee order by ParentEmployeeKey

select E.FirstName as 'Manager',M.FirstName as 'Employee',E.EmployeeKey,M.EmployeeKey
	 from DimEmployee E left join dimemployee M
				ON E.employeekey = M.ParentEmployeeKey

---- UNION , UNION ALL, INTERSECT, EXCEPT --- SET OPERATIONS

use JB_2021
select *  from tblEmployee

select * from tblEmployee
UNION ALL   -- it will always give you the duplicate values
select * from tblRepliace_emp



select NAme,Gender from tblEmployee
UNION ALL   -- it will always give you the duplicate values
select Gender,NAme from tblRepliace_emp


select DepartmentId from tblEmployee
UNION    -- uNIQUE VALUES IN OUTPUT
select DepartmentId from tblRepliace_emp

SELECT * FROM tblEmployee
except			-----  A-B
SELECT * FROM tblRepliace_emp

update tblRepliace_emp
set salary = 25000
where id = 1

5
INTERSECT			-----  common values between table A & B
SELECT * FROM tblRepliace_emp




