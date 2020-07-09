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

Insert into tblEmployee values (11, 'Reena', 'FeMale', 8800, 6)
GO

select * from tblDepartment
GO

/*

--Employee						Department
1, 'Tom', 'Male', 4000	1		
2, 'Jik', 'Male', 4000	1		1 IT,London,Rick
3, 'Jack', 'Male', 4000	IT,London,Rick		
4, 'Jill', 'FeMale', 4000	IT,London,Rick

INSERT INTO tblEmployee
VALUES(1,'jill','Female',4000,'IT','London','Rick')

*/

-- IDENTITY COLUMNS
--- IDENTITY ( BASE,SEEED) 
--- BASE -- values from which you wanted to start the numbering 
--- SEED -- increment values to previously used base value
Create table employee
(
     ID int identity(100,1000) primary key,
     Name nvarchar(50),
     Gender nvarchar(50),
     Salary int,
     DepartmentId int foreign key references tblDepartment(Id)
)

Insert into employee values ('Hitesh', 'Male', 8800, NULL)
drop table employee
select * from employee


--- GROUP BY, ORDER BY, CASE, IIF , HAVING 
-- CASE
use AdventureWorksDW2017

select FirstName,LastName,EmailAddress,BirthDate,
		CASE 
				WHEN YEARlyincome > 100000 then 'A' 
				WHEN  YEARlyincome >= 50000 and YEARlyincome <= 90000 then 'B'
				ELSE 'C' END AS IncomeGroups
 from DimCustomer


 ---- IIF(conditions,TRUE,FALSE)

select FirstName,LastName,EmailAddress,BirthDate as DOB,
IIF(YEARlyincome>100000,'A',IIF(YEARlyincome<50000,'C','B')) AS 'Income Groups'
 from DimCustomer
 

select distinct yearlyincome from dimcustomer ORDER BY YearlyIncome desc

---
 select * from DimCustomer


 -- Count of married and unmarried customers.
 --- COUNT,SUM,MIN,MAX,AVG
 SELECT count(*) FROM DIMCUSTOMER WHERE MARITALSTATUS = 'M' GROUP BY MARITALSTATUS
 
 select MaritalStatus,count(*) from DimCustomer group by MaritalStatus
 
 SELECT EnglishEducation,EnglishOccupation, count(*) AS 'count of customers',AVG(yearlyincome) as 'AvgIncome'
 FROM DimCustomer
 WHERE EnglishEducation IN ('Bachelors','Partial College','Partial High School')
 GROUP BY EnglishEducation,EnglishOccupation
 HAVING AVG(yearlyincome) > 50000
 ORDER BY EnglishEducation

 /*
 1. FROM DimCustomer

 2.  WHERE

 3. GROUP BY

 4. HAVING 

 5. SELECT 

 6. ORDERING


 */

