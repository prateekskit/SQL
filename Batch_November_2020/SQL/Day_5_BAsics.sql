use JB_Nov_11

--------------- DEPT (1 : Many) EMP


CREATE TABLE tblEmp
(
  Id int Primary Key,
  Name nvarchar(30),
  Salary int,
  Gender nvarchar(10),
  DepartmentID_FK int,
  foreign key (DepartmentID_FK) references  tblDept(DeptId)
)

CREATE TABLE tblDept
(
 DeptId int Primary Key,
 DeptName nvarchar(20),
 Dept_HOD	nvarchar(20),
 city	nvarchar(20)
)


sp_help tblEmp


-- constraint fk_foreignkey foreign key (gndr) references  gender(id)

select * from tblEmp
select * from tblDept

Insert into tblDept values (1,'IT','Mr.XYX','jj')
Insert into tblDept values (2,'Payroll','Mr.YX','oslo')
Insert into tblDept values (3,'HR','Mr.X','helsinki')
Insert into tblDept values (4,'Admin','Mr.yyy','london')
Insert into tblDept values (5,'sECURITY','Mr.ZZZ','london')

Insert into tblEmp values (1,'John', 5000, 'Male', 3)
Insert into tblEmp values (2,'Mike', 3400, 'Male', 2)
Insert into tblEmp values (3,'Pam', 6000, 'Female', 1)
Insert into tblEmp values (4,'Todd', 4800, 'Male', 4)
Insert into tblEmp values (5,'Sara', 3200, 'Female', 1)
Insert into tblEmp values (6,'Ben', 4800, 'Male', NULL)

select * from tblEmp


--- join conditions



----- INNER JOIN OR JOIN
SELECT E.Name,D.DeptName
FROM tblemp E JOIN tbldept D 
				ON E.DepartmentID_FK = d.DeptId
			

				

------ LEFT JOIN OR LEFT OUTER JOIN

SELECT E.*,D.*
FROM tblemp E LEFT JOIN tbldept D 
				ON E.DepartmentID_FK = d.DeptId




------- RIGHT JOIN   OR RIGHT OUTER JOIN

SELECT E.*,D.*
FROM tblemp E RIGHT JOIN tbldept D 
				ON E.DepartmentID_FK = d.DeptId



------- FULL OUTER JOIN

SELECT E.*,D.*
FROM tblemp E FULL OUTER JOIN tbldept D 
				ON E.DepartmentID_FK = d.DeptId

CREATE TABLE a
(
ID INT
)

CREATE TABLE B
(
ID INT
)

INSERT INTO A
VALUES(null)


INSERT INTO b
VALUES(NULL)

SELECT * FROM B
SELECT * FROM A

--- APPLY A INNER JOIN, WHAT IS THE OUTCOME
-----  A null VALUES CAN NOT BE EQUALL TO ANOTHER null VALUE



SELECT * FROM A
SELECT * FROM B
SELECT * FROM A INNER JOIN B ON A.ID = B.ID
SELECT * FROM A LEFT JOIN B ON A.ID = B.ID
SELECT * FROM A right JOIN B ON A.ID = B.ID
SELECT * FROM A FULL OUTER  JOIN B ON A.ID = B.ID


SELECT * FROM [dbo].[FactInternetSales]   --- SALESAMOUNT
SELECT * FROM DimCustomer					--- FIRSTNAME + LAST NAME
SELECT * FROM DimSalesTerritory				--- SALESTERIRRORITY


SELECT FIS.SalesAmount,DC.FirstName,DC.LastName,DST.SalesTerritoryRegion FROM
			FactInternetSales fis INNER JOIN DimCustomer DC ON FIS.CustomerKey = DC.CustomerKey
								  INNER JOIN DimSalesTerritory	DST ON FIS.SalesTerritoryKey = DST.SalesTerritoryKey		