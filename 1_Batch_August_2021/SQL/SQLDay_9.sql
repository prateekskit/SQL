select * from DimProductCategory
select * from DimProductSubcategory
select * from DimProduct 

SELECT DPC.EnglishProductCategoryName,DPS.EnglishProductSubcategoryName,DP.EnglishProductName
FROM DimProductCategory DPC INNER JOIN DimProductSubcategory DPS 
							ON DPC.ProductCategoryKey = DPS.ProductCategoryKey
							INNER JOIN DimProduct DP
							ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
ORDER BY	DPC.EnglishProductCategoryName,DPS.EnglishProductSubcategoryName,DP.EnglishProductName

--------------- LEFT JOIN ----------------------------

USE JB_2021


SELECT EMP.ID,DPT.ID,Name,DepartmentName,DepartmentHead,Location
FROM tblEmployee eMP INNER JOIN tblDepartment dPT ON DepartmentId = DPT.ID


SELECT * FROM tblEmployee
SELECT * FROM tblDepartment
 

--- I want details about all the employess whether they are part of any department or not 
SELECT EMP.ID,Name,gender,salary,DPT.ID,DepartmentName,DepartmentHead,Location
FROM tblEmployee eMP LEFT JOIN tblDepartment dPT 
					ON DepartmentId = DPT.ID


SELECT EMP.ID,DPT.ID,Name,DepartmentName,DepartmentHead,Location
FROM tblEmployee eMP LEFT JOIN tblDepartment dPT 
					ON DepartmentId = DPT.ID


-- 4 
-- 4 
-- 10
-- 9
--- I need all details about my department and their corresponding employess
SELECT DPT.ID,DepartmentName,DepartmentHead,Location,EMP.ID,Name,gender,salary
FROM tblDepartment dPT LEFT JOIN 
								tblEmployee eMP
					ON emp.DepartmentId = DPT.ID


					 --is
					 -- equivalent to
					 -- below query

SELECT DPT.ID,DepartmentName,DepartmentHead,Location,EMP.ID,Name,gender,salary
FROM  tblEmployee eMP  RIGHT JOIN 
								tblDepartment dPT
					ON emp.DepartmentId = DPT.ID


--------------------------------------------------------------------------------------------
SELECT EMP.ID,DPT.ID,Name,DepartmentName,DepartmentHead,Location
FROM tblEmployee eMP LEFT JOIN 
							 tblDepartment dPT 
					ON DepartmentId = DPT.ID

					 --is
					 -- equivalent to
					 -- below query

SELECT DPT.ID,DepartmentName,DepartmentHead,Location,EMP.ID,Name,gender,salary
FROM tblDepartment dPT RIGHT JOIN 
								tblEmployee eMP
					ON emp.DepartmentId = DPT.ID


					sp_help tblEmployee

SELECT * FROM tblEmployee
SELECT * FROM tblDepartment


------------------------- Full Join---------------------------
SELECT EMP.ID,DPT.ID,Name,DepartmentName,DepartmentHead,Location
FROM tblEmployee eMP FULL JOIN 
							 tblDepartment dPT 
					ON DepartmentId = DPT.ID

--10
-- 11 Rows

---------- self join--------------



