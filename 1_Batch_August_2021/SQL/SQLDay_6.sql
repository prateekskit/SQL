-- TOP CLAUSE

use AdventureWorksDW2017
-- top keyword will give you the top elements from the table.

select top 10 CustomerKey,FirstName,YearlyIncome,EnglishEducation 
from DimCustomer 
ORDER BY YearlyIncome 


select CustomerKey,FirstName,YearlyIncome,EnglishEducation 
from DimCustomer 
ORDER BY YearlyIncome 

select TOP 10 WITH TIES CustomerKey,FirstName,YearlyIncome,EnglishEducation 
from DimCustomer 
ORDER BY YearlyIncome 


-------- CASE STATEMENTS or IIF CLAUSE
select FirstName,Gender,YearlyIncome,
		CASE 
			WHEN MaritalStatus = 'M' then 'Married'
			Else 'Single' END	AS 'Marital Status',
		CASE 
			WHEN YearlyIncome < 60000 then CAST(YearlyIncome as varchar)
			WHEN YearlyIncome >= 60000 AND YearlyIncome <= 150000 then 'GOLD'
			WHEN YearlyIncome >150000 THEN 'Premium' 
			ELSE YearlyIncome 	END AS 'Customer Segments'
from DimCustomer
ORder by YearlyIncome
----------------------------------------------------------------------




--- GROUP BY & HAVING 

use JB_2021

Create table tblEmployee
(
     ID int primary key,
     Name nvarchar(50),
     Gender nvarchar(50),
     Salary int,
     DepartmentId int --foreign key references tblDepartment(Id)
)
Go

Insert into tblEmployee values (1, 'Tom', 'Male', 4000, 1)
Insert into tblEmployee values (2, 'Pam', 'Female', 3000, 3)
Insert into tblEmployee values (3, 'John', 'Male', 3500, 1)
Insert into tblEmployee values (4, 'Sam', 'Male', 4500, 2)
Insert into tblEmployee values (5, 'Todd', 'Male', 2800, 2)
Insert into tblEmployee values (6, 'Ben', 'Male', 7000, 1)
Insert into tblEmployee values (7, 'Sara', 'Female', 4800, 3)
Insert into tblEmployee values (8, 'Valarie', 'Female', 5500, 1)
Insert into tblEmployee values (9, 'James', 'Male', 6500, NULL)
Insert into tblEmployee values (10, 'Russell', 'Male', 8800, NULL)
Go

-- aggregate functions - SUM,MAX,MIN,AVG,COUNT
select * from tblEmployee

SELECT GENDER,sum(SALARY) AS 'TOTAL SALARY'
FROM tblEmployee
GROUP BY GENDER

SELECT GENDER,max(SALARY) AS 'MAX SALARY'
FROM tblEmployee
GROUP BY GENDER


SELECT GENDER,avg(SALARY) AS 'AVG SALARY'
FROM tblEmployee
GROUP BY GENDER

SELECT GENDER,COUNT(*) AS 'count'
FROM tblEmployee
GROUP BY GENDER


SELECT gender,MaritalStatus,count(*) as 'count'
FROM dimcustomer_Bakcup
group  by gender,MaritalStatus

SELECT gender,MaritalStatus,avg(yearlyincome) as 'avg income'
FROM dimcustomer_Bakcup
group  by gender,MaritalStatus


select distinct gender,MaritalStatus from dimcustomer_Bakcup
select distinct MaritalStatus from dimcustomer_Bakcup

SELECT gender,MaritalStatus,avg(yearlyincome) as 'avg income'
FROM dimcustomer_Bakcup
--where avg income > 60000
group  by gender,MaritalStatus
having avg(yearlyincome)>60000


----- diff between having vs where

select * 
from dimcustomer_Bakcup 
where customerkey = 11000


------------------------------------------
-- WHAT IS THE ORDER OF A QUERY EXECUTION

SELECT gender,MaritalStatus,avg(yearlyincome) as 'avg income'		-------------5
FROM dimcustomer_Bakcup                                           ------------ 1
WHERE TotalChildren > 2												-------------2	
GROUP  BY gender,MaritalStatus										--------------3
HAVING avg(yearlyincome)>60000										---------------4	
ORDER BY GENDER														-----------------6					


