/*  JOINS
	INNER JOIN / JOIN
outer joins --
	LEFT JOIN/LEFT OUTER JOIN
	RIGHT JOIN / RIGHT OUTER JOIN
	FULL JOIN / FULL OUTER JOIN
cross JOIN
SELF JOIN -- WHICH IS NOT Exactly a join, but some tweaks to inner or outer joins
 */

use JB_07_2020


SELECT * FROM tblEmployee
SELECT * FROM tblDepartment

--- inner join
select E.Name,E.Gender,E.Salary,D.DepartmentName,D.Location,D.DepartmentHead
						 from tblEmployee E inner join tblDepartment D
						ON E.DepartmentId = D.ID

select E.Name,E.Gender,E.Salary,D.DepartmentName,D.Location,D.DepartmentHead
						 from tblEmployee E inner join tblDepartment D
						ON D.ID = E.DepartmentId

--outer joins	

--LEFT OUTER JOIN				

select E.*,D.*
						 from tblEmployee E left outer join tblDepartment D
						ON D.ID = E.DepartmentId

select E.*,D.*
						 from tblDepartment D left outer join tblEmployee E
						ON D.ID = E.DepartmentId


select E.*,D.*
						 from tblEmployee E RIGHT outer join tblDepartment D
						ON D.ID = E.DepartmentId


use AdventureWorksDW2017

select * from FactInternetSales
select * from DimCustomer
select * from DimSalesTerritory

SELECT  DC.FirstName,DC.LastName,DST.SalesTerritoryCountry,FIS.SalesAmount
 FROM FactInternetSales FIS INNER JOIN DimCustomer DC 
									on FIS.CustomerKey = DC.CustomerKey
								INNER JOIN DimSalesTerritory DST
									ON FIS.SalesTerritoryKey = DST.SalesTerritoryKey


SELECT  DST.SalesTerritoryCountry,DC.GENDER,SUM(FIS.SalesAmount) AS AMT
 FROM FactInternetSales FIS INNER JOIN DimCustomer DC 
									on FIS.CustomerKey = DC.CustomerKey
								INNER JOIN DimSalesTerritory DST
									ON FIS.SalesTerritoryKey = DST.SalesTerritoryKey
GROUP BY DST.SalesTerritoryCountry,DC.Gender
ORDER BY DST.SalesTerritoryCountry

---- SELF JOIN

USE JB_07_2020

create table relation
(
employeeID int,
name varchar(100),
managerid int
)

select * from relation
insert into relation
values(5,'JOHN',2)

SELECT E.NAME AS EMPLOYEE, M.NAME AS MANAGER
	FROM relation E
		LEFT OUTER JOIN RELATION M
			ON E.managerid = M.employeeID


--- CROSS JOIN
SELECT * FROM tblEmployee
SELECT * FROM tblDepartment

SELECT * FROM tblEmployee,tblDepartment


--- SET OPERATORS
-- UNION
-- UNION ALL
-- EXCEPT
-- INTERSECT/SUBSTRACT

CREATE TABLE INFO_1
(SSN INT,
PHONE INT)

SELECT * FROM INFO_1

CREATE TABLE INFO_2
(SSN_2 INT,
PHONE_2 INT)

--- REMOVE DUPLICATES, AND MERGE THE RECORD SETS

SELECT * FROM INFO_1
UNION
SELECT * FROM INFO_2

SELECT SSN,PHONE FROM INFO_1
UNION
SELECT SSN_2,PHONE_2 FROM INFO_2

--- FETCH EVERYTHING FROM BOTH THE TABLES.
SELECT SSN,PHONE FROM INFO_1
UNION all
SELECT SSN_2,PHONE_2 FROM INFO_2

-- A-B

SELECT SSN,PHONE FROM INFO_1
EXCEPT
SELECT SSN_2,PHONE_2 FROM INFO_2


SELECT * FROM INFO_2
EXCEPT
SELECT * FROM INFO_1


SELECT * FROM INFO_2
INTERSECT
SELECT * FROM INFO_1

SELECT * FROM INFO_1
INTERSECT
SELECT * FROM INFO_2













