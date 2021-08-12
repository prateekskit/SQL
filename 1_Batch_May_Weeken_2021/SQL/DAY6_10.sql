--- ORDER BY CLAUSE

SELECT Firstname,Lastname,YearlyIncome from DimCustomer 
ORDER by FirstName desc , LastName 
-- 
SELECT Firstname,Lastname,YearlyIncome from DimCustomer 
ORDER by FirstName desc , LastName 


--- TOP CLAUSE
--- I want to get all the top 10 rows having highest yearly income for the customer 

SELECT TOP 10 Firstname,Lastname,YearlyIncome FROM DimCustomer order by YearlyIncome desc
-- top 10 based on firstname
SELECT TOP 10 Firstname,Lastname,YearlyIncome FROM DimCustomer order by FirstName desc

SELECT TOP 10 WITH TIES  Firstname,Lastname,YearlyIncome  FROM DimCustomer order by FirstName desc

SELECT TOP 10 WITH TIES  Firstname,Lastname,YearlyIncome  FROM DimCustomer order by YearlyIncome desc

SELECT Firstname,Lastname,YearlyIncome FROM DimCustomer where firstname = 'Zoe' order by FirstName desc

SELECT TOP 5 PERCENT  Firstname,Lastname,YearlyIncome  FROM DimCustomer order by YearlyIncome desc


---------------- DISTINCT CLAUSE

select DISTINCT TotalChildren from DimCustomer

select distinct EnglishEducation  from  DimCustomer
select distinct EnglishOccupation from DimCustomer

select distinct EnglishEducation,EnglishOccupation FROM  DimCustomer
select englisheducation from DimCustomer order by EnglishEducation

select distinct yearlyincome from DimCustomer order by YearlyIncome
-------------------- 

----- OFFSET-FETCH  ----


SELECT TOP 100 customerkey,Firstname,Lastname,YearlyIncome FROM DimCustomer order by YearlyIncome desc

SELECT CustomerKey,FirstName,LastName,YearlyIncome 
FROM DimCustomer order by YearlyIncome desc
OFFSET 100 ROWS FETCH NEXT 10 ROWS ONLY

---

-------------CASE & IIF Statements-------------------
-- firstname,lastname,maritalstatus
---  M = Married, S= Single
SELECT Firstname,lastname,maritalstatus FROM DimCustomer

SELECT Firstname,lastname,
		CASE WHEN MaritalStatus = 'M' THEN 'MARRIED'
			ELSE 'SINGLE' END AS statusDescription
 FROM DimCustomer

 SELECT Firstname,lastname,
		IIF(maritalstatus = 'M','MARRIED','SINGLE') as StatusDescription
 FROM DimCustomer

 ----- YEARLYINCOME PART ----------------  
 ---- YI > 0 AND <60000 'BRONZE'    , YI >=60k and <120 -- SILVER and REST GOLD


 SELECT Firstname,lastname,YearlyIncome,
					CASE
						WHEN YearlyIncome > 0 AND YearlyIncome < 60000  THEN 'BRONZE'
						WHEN YearlyIncome >=60000 AND YearlyIncome < 120000  THEN 'SILVER'
						ELSE 'GOLD'
					END AS 'Income Category',
					MaritalStatus,
					gender,
					EnglishEducation
 FROM DimCustomer

 ---- 

 ------------ GROUP BY & HAVING CLAUSE  ----



 select * from DimCustomer

 --- how many total children I have in each english cateogry 

 SELECT ENGLISHEDUCATION,SUM(TOTALCHILDREN) AS 'SumofChild' 
 FROM DimCustomer 
 GROUP BY ENGLISHEDUCATION

 select gender,Avg(yearlyincome) as 'avg income'
 FROM DimCustomer 
 group  by Gender

 ----      SUM of yearlyincome, based on gender and marital status

SELECT GENDER,MaritalStatus,SUM(YEARLYINCOME) AS YRLYiNCOME
FROM DimCustomer
GROUP BY GENDER

SELECT MaritalStatus,GENDER,SUM(YEARLYINCOME) AS YRLYiNCOME
FROM DimCustomer
GROUP BY MaritalStatus, GENDER


 ---- AVG,SUM,MAX,MIN,COUNT
 --- HAVING will always come AFTER group by  -- they will go hand in hand


SELECT EnglishEducation,COUNT(*) AS countt
FROM DimCustomer
GROUP BY EnglishEducation
HAVING COUNT(*) > 3500

--------
select distinct  ENGLISHEDUCATION from DimCustomer
---https://www.tutorialgateway.org/
--https://www.hackerrank.com/
---------------------------------------------------------
--- order of SQL Execution 
SELECT ENGLISHEDUCATION,ENGLishoccupation, AVG(YEARLYINCOME) as YI              ----5th 
FROM DimCustomer                                                    ----- 1st statement gets processed 
WHERE  EnglishEducation IN ('Partial High School','High School','Graduate Degree')   --- 2nd statement 
GROUP BY ENGLISHEDUCATION,ENGLishoccupation                                         ---- 3rd
HAVING SUM(YEARlyincome) > 9080000.00												 ---- 4th 			
ORDER BY EnglishEducation																		---- 6th 


------------------------------------ CONSTRAINTS ------------------------------------
--- put it ona column
 --- NULL, DEFAULT, CHECK, PK, UK, FK

 use JB_May_2021

 CREATE TABLE tblEmp
 (
 ID int not null,
 FName varchar(100),
 City varchar(100)
 )

 drop table tblEmp

 select * from tblEmp
 INSERT INTO tblEmp(ID,Fname,City)
 VALUES(1,'Jack','Oslo')

  INSERT INTO tblEmp(ID,City)
 VALUES(4,'Hmaburg')

 select * from tblemp where Fname = ''
 select * from tblemp
 select * from tblemp where Fname IS NULL


 sp_help tblEmp

 select * from Customer_Replica

 select * from tblEmp
-----------------------------------------------------------
------------------ DEFAULT CONSTRAINT -------------------

ALTER TABLE tblEmp Add Country	varchar(100) 

-- ALTER TABLe <table_name> ADD CONSTRAINT <cnstraint name> DEFAULT ('value') for <column>

ALTER TABLE tblEmp Add constraint df_name_country DEFAULT('USA') for country

INSERT INTO tblemp(ID,Fname,City)
VALUES(5,'Rob','Washington')


 select * from tblEmp

 sp_help tblEmp

 
 ----- CHECK CONSTRAINT --------------------------

 ALTER TABLE tblEmp Add AGE	INT

 ALTER TABLE tblEmp Add Constraint df_check_age CHECK(AGE > 0 and AGE <120)

  select * from tblEmp

INSERT INTO tblemp(ID,Fname,City,AGE)
VALUES(5,'Rob','Washington',-10)

---------------------------------------------------------------------------------------

--- Primary Key and Foreign Key Concepts.......

-- Primary Key Constraint

delete from tblEmp where id = 5
select * from tblemp
ALTER TABLE tblemp ADD CONSTRAINT pk_tblAddress_ID primary key (ID)


CREATE TABLE tblX
(
ID int primary key,
salary int
)

INSERT INTO tblX
VALUES(3,5500)
select * from tblX
INSERT INTO tblX(salary)
VALUES(2500)

---------------------------------------- FOREIGN KEY --------------------------
Create table tblDepartment
(
     ID int primary key,
     DepartmentName nvarchar(50),
     Location nvarchar(50),
     DepartmentHead nvarchar(50)
)
Go
select * from tblDepartment
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
select * from tblEmployee
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
select * from tblDepartment
select * from tblEmployee
Insert into tblEmployee values (11, 'Valarie', 'Female', 5500, 4)

select * from tblDepartment

select * from tblEmployee

insert into tblEmployee
values(11,'Jackson','M',9000,5)
sp_help tblEmployee

------ IDENTITY PROPERTY
--- identity property helps you to generate a number sequnctially during insert operations.
-----  IDENTITY (BASE,SEED)
-----    Base - from where you wanted to start your numbering 
-------- SEED - by what lenght you wanted to increase the values after every new insertion

CREATe TABLE tblY
(
ID int IDENTITY(1,1) ,
Salary  int
)

insert into tblY
VALUES(4500)

select * from tblY

CREATe TABLE tblZ
(
ID int IDENTITY(10,100) ,
Salary  int
)

insert into tblZ
VALUES(2500)

select * from tblZ

--------------------------------------------------------------------

 ---------------------   JOINS -------------------------------------
	
----  INNER JOIN, 
-- LEFT JOIN or LEFT OUTER JOIN, 
-- RIGHT JOIN OR RIGHT OUTER JOIN, 
-- FULL OUTER JOIN

SELECT E.ID,D.ID,E.NAME,E.GENDER,E.SALARY,D.DepartmentName,D.Location, e.DepartmentId,d.ID
FROM tblEmployee E INNER JOIN tblDepartment D ON E.DepartmentId = d.ID 



CREATe TABLE tblB
(
Id_b int
)

insert into tblB
values(1),(2),(3),(NULL)

SELECT * FROM TblA
SELECT * FROM TblB

select A.* ,B.* from tblA  A inner join tblB B ON A.id = B.Id_b


 ----- LFET JOIN OR LFET OUTER JOIN

 select * from tblEmployee
 select * from tblDepartment

 
SELECT E.ID,D.ID,E.NAME,E.GENDER,E.SALARY,D.DepartmentName,D.Location, e.DepartmentId,d.ID
FROM tblEmployee E INNER JOIN tblDepartment D ON E.DepartmentId = d.ID 

 SELECT E.ID,D.ID,E.NAME,E.GENDER,E.SALARY,D.DepartmentName,D.Location, e.DepartmentId,d.ID
	 FROM tblEmployee E LEFT JOIN tblDepartment D
							ON E.DepartmentId = d.ID

----- set OPERATORS
							
 select * from tblEmployee
 select * from tblDepartment

SELECT E.ID,D.ID,E.NAME,E.GENDER,E.SALARY,D.DepartmentName,D.Location, e.DepartmentId,d.ID
	 FROM tblDepartment D  LEFT JOIN tblEmployee E
							ON E.DepartmentId = d.ID


SELECT E.ID,D.ID,E.NAME,E.GENDER,E.SALARY,D.DepartmentName,D.Location, e.DepartmentId,d.ID
	 FROM tblDepartment D  right JOIN tblEmployee E
							ON E.DepartmentId = d.ID


 SELECT E.ID,D.ID,E.NAME,E.GENDER,E.SALARY,D.DepartmentName,D.Location, e.DepartmentId,d.ID
	 FROM tblEmployee E LEFT JOIN tblDepartment D
							ON E.DepartmentId = d.ID


---- full outer jOIN 


SELECT E.ID,D.ID,E.NAME,E.GENDER,E.SALARY,D.DepartmentName,D.Location, e.DepartmentId,d.ID
	 FROM tblEmployee E full OUTER JOIN tblDepartment D
							ON E.DepartmentId = d.ID
