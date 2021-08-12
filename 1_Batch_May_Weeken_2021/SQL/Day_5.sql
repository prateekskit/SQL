use AdventureWorksDW2017

-- DISTINCT   --- it fetches the distinct values from a column or set of column

SELECT distinct YearlyIncome FROM DimCustomer order by YearlyIncome

SELECT distinct Maritalstatus,YearlyIncome FROM DimCustomer order by YearlyIncome

--- CASE STATEMENTS & IIF CLAUSE

select distinct  yearlyincome, 
		CASE 
			WHEN YearlyIncome <= 60000 THEN 'BRONZE' 
			WHEN YearlyIncome > 60000 AND YearlyIncome < 130000 THEN 'SILVER'
			WHEN YearlyIncome >= 130000 then 'GOLD' 
		END  AS 'Financial Category'
 from DimCustomer
 order by YearlyIncome

 select Firstname+ ' ' + Lastname,Emailaddress,
		CASE 
			WHEN YearlyIncome <= 60000 THEN 'BRONZE' 
			WHEN YearlyIncome > 60000 AND YearlyIncome < 130000 THEN 'SILVER'
			WHEN YearlyIncome >= 130000 then 'GOLD' 
		END  AS 'Financial Category'
 from DimCustomer
 order by YearlyIncome
 ---- IIF(<conditions>,TRUE REUSLTS,FALSE RESULTS)
 select distinct MaritalStatus,IIF(MAritalStatus = 'M','Married','Single')  FROM DimCustomer

 ----- TOP KEYWORD
 
 select TOP 100 * 
 from DimCustomer 
 order by YearlyIncome 
 
 select TOP 100 * from DimCustomer order by YearlyIncome desc

 -------------------------------------------------------------

 use JB_2021_April

 Create table tblDepartment
(
     ID int primary key,
     DepartmentName nvarchar(50),
     Location nvarchar(50),
     DepartmentHead nvarchar(50)
)
Go

Insert into tblDepartment values (1, 'IT', 'London', 'Rick')
Insert into tblDepartment values (2, 'Payroll', 'Delhi', 'Ron')

 
Insert into tblDepartment values (3, 'HR', 'New York', 'Christie')
Insert into tblDepartment values (4, 'Other Department', 'Sydney', 'Cindrella')
Go

Create table tblEmployee
(
     ID int primary key,
     Name nvarchar(50),
     Gender nvarchar(50),
     Salary int,
     DepartmentId int foreign key references tblDepartment(Id)
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


select * from tblEmployee

select top 3  Name,salary from tblEmployee ORDER BY salary 

select * from tblEmployee order by Name,Salary desc

------- GROUP BY & HAVING CLAUSE

use AdventureWorksDW2017

select GENDER,YearlyIncome from DimCustomer

SELECT GENDER,SUM(YEARLYINCOME),AVG(YearlyIncome),MAX(yearlyincome),MIN(yearlyincome),count(*) 
FROM DimCustomer
GROUP BY GENDER

select count(*) from DimCustomer  -- how many rows are there in a table
select count(distinct CustomerKey) from DimCustomer  --- how many distinct  genders we have in table
select count(GENDER) from DimCustomer  --- how many genders we have in table
select count(distinct GENDER) from DimCustomer  --- how many distinct  genders we have in table

---- Please fetcht the total income for the customers according to gender with their marital status
SELECT GENDER,Maritalstatus,SUM(YEARLYINCOME)
FROM DimCustomer
GROUP BY GENDER,Maritalstatus

--- 3, 2 rows, 2, 4, 3 

select distinct GENDER,Maritalstatus from DimCustomer


