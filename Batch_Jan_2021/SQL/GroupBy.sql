---- GROUP BY and HAVING CLAUSE

select * from tblEmployee

---- wanted to know salary based on gender or sum of salarries for gender


SELECT GENDER,SUM(SALARY)
	FROM tblEmployee
	GROUP BY GENDER 

SELECT COUNT(*) FROM tblEmployee

SELECT GENDER,COUNT(*)
	FROM tblEmployee
	GROUP BY GENDER 

	
SELECT GENDER,max(SALARY)
	FROM tblEmployee
	GROUP BY GENDER 

SELECT DepartmentId,GENDER,SUM(SALARY) FROM tblEmployee
		GROUP BY DepartmentId,GENDER

USE AdventureWorksDW2017

SELECT * FROM DimCustomer

SELECT MaritalStatus,sum(TOTALCHILDREN) FROM DimCustomer
		GROUP BY MaritalStatus


SELECT MaritalStatus,GENDER,EnglishEducation, sum(TOTALCHILDREN) FROM DimCustomer
		GROUP BY MaritalStatus,GENDER,EnglishEducation
		ORDER BY MaritalStatus,GENDER



SELECT EnglishEducation,		MaritalStatus,GENDER
		, sum(TOTALCHILDREN) FROM DimCustomer
gROUP BY EnglishEducation,MaritalStatus,GENDER
ORDER BY EnglishEducation



SELECT *

SELECT distINCT EnglishEducation,MaritalStatus,GENDER,sum(TOTALCHILDREN) --- LAST OPERATION
FROM DimCustomer      ------------------------------------------- 1
WHERE GENDER = 'M'		------------------------------------------ 2
GROUP BY EnglishEducation,MaritalStatus,GENDER   ------------------3 
HAVING SUM(TOTALCHILDREN) > 1500				---------------- 4
ORDER BY EnglishEducation						------------- 5


SELECT * 
FROM DimCustomer
WHERE GENDER = 'm'



USE JB_2021

SELECT DepartmentName,GENDER,SUM(SALARY) FROM tblEmployee INNER JOIN
		tblDepartment ON tblEmployee.DepartmentId = tblDepartment.ID
		GROUP BY DepartmentName,GENDER


		