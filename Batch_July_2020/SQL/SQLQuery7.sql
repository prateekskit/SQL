use JB_07_2020

select * from tblEmployee
select * into tblDeptName from tblDepartment


SELECT E.Name,D.DepartmentName,D.Location,E.DepartmentId,E.Gender,E.Salary 
FROM tblEmployee E LEFT OUTER JOIN tblDepartment D ON E.DepartmentId = D.ID
WHERE D.DepartmentName = 'IT' AND E.Gender = 'Male' and E.Salary > 5000

--- 
SELECT E.Name,D.DepartmentName,D.Location,E.DepartmentId,E.Gender,E.Salary 
FROM tblEmployee E 
LEFT OUTER JOIN tblDepartment D ON E.DepartmentId = D.ID
WHERE D.DepartmentName = (SELECT DepartmentName from tblDeptName where DepartmentName = 'IT')
AND E.Gender = 'Male' and E.Salary > 5000

---- I want to know about the 2nd,3rd,4th highest salary
--- 18965th  896578

   select NAme,row_num
   FROM (
   select *, ROW_NUMBER() over (order by salary desc) as row_num from tblEmployee 
   ) as T
   where row_num IN (2,3,4)





USE AdventureWorksDW2017

--- CUSTOMERS NAME WHO IS RESIDING IN EUROPE
--- lIST SALES AMOUNT
--- CUSTOMERS SHOULD HAVE 2 CHILDREN

SELECT * FROM FactInternetSales
SELECT * FROM DimCustomer
SELECT * FROM DimSalesTerritory

--- SUB QUERY IN WHERE CLAUSE

SELECT FirstName,LastName,TotalChildren,SalesAmount
FROM FactInternetSales INNER JOIN DimCustomer 
		ON FactInternetSales.CustomerKey = DimCustomer.CustomerKey
WHERE 
TotalChildren = 2 or FactInternetSales.SalesTerritoryKey IN (SELECT SalesTerritoryKey FROM DimSalesTerritory
														WHERE SalesTerritoryGroup = 'EUROPE')

---- SUB QUERY IN FROM

SELECT FirstName,LastName,TotalChildren,SalesAmount

FROM FactInternetSales INNER JOIN DimCustomer 
		ON FactInternetSales.CustomerKey = DimCustomer.CustomerKey
WHERE 
TotalChildren = 2 and
FactInternetSales.SalesTerritoryKey IN (SELECT SalesTerritoryKey FROM DimSalesTerritory
														WHERE SalesTerritoryGroup = 'EUROPE')


SELECT * FROM FactInternetSales
SELECT * FROM DimCurrency


SELECT DimCurrency.CurrencyName,T.AMT,t.SalesTerritoryGroup
FROM
(
	SELECT FIS.CurrencyKey,FIS.SalesTerritoryKey,DimSalesTerritory.SalesTerritoryGroup,
				SUM(SALESAMOUNT) AS AMT FROM FactInternetSales fis
	INNER JOIN DimSalesTerritory on FIS.SalesTerritoryKey = DimSalesTerritory.SalesTerritoryKey
													WHERE SalesTerritoryGroup = 'EUROPE'
	GROUP BY FIS.CurrencyKey,FIS.SalesTerritoryKey,DimSalesTerritory.SalesTerritoryGroup
) as T

INNER JOIN 

(

	SELECT FIS.CurrencyKey,FIS.SalesTerritoryKey,DimSalesTerritory.SalesTerritoryGroup,
				SUM(SALESAMOUNT) AS AMT FROM FactInternetSales fis
	INNER JOIN DimSalesTerritory on FIS.SalesTerritoryKey = DimSalesTerritory.SalesTerritoryKey
													WHERE SalesTerritoryGroup = 'EUROPE'
	GROUP BY FIS.CurrencyKey,FIS.SalesTerritoryKey,DimSalesTerritory.SalesTerritoryGroup
) as v



INNER JOIN DimCurrency ON t.CurrencyKey = DimCurrency.CurrencyKey


SELECT SalesAmount,TotalProductCost, 
	(SELECT DimCurrency.CurrencyName FROM DimCurrency WHERE CurrencyKey = FactInternetSales.CurrencyKey) AS CURR_NAME
 FROM FactInternetSales

SELECT * FROM DimCurrency

SELECT * FROM FactInternetSales

US Dollar  -- $
EURO -- 

--- CTE --- COMMON TABLE EXPRESSIONS

WITH <CTE_NAME>
AS
(
SELECT * FROM <TABLENAME>
)
SELECT * FROM <CTE_name>


WITH CTE_1
AS
(
SELECT SalesTerritoryKey,SalesAmount,DimCustomer.FirstName,DimCustomer.LastName,FactInternetSales.CurrencyKey
 FROM FactInternetSales INNER JOIN DimCustomer
	ON FactInternetSales.CustomerKey = DimCustomer.CustomerKey
),
CTE_2
AS
(
SELECT Sum(SalesAmount) AS 'COUNTR_SALEaMOUNT',DST.SalesTerritoryCountry,DST.SalesTerritoryKey
 FROM FactInternetSales INNER JOIN DimSalesTerritory dst
	ON FactInternetSales.SalesTerritoryKey = DST.SalesTerritoryKey
	GROUP BY DST.SalesTerritoryCountry,DST.SalesTerritoryKey
)
SELECT cte_1.*,DimCurrency.CurrencyName,CTE_2.* 
FROM CTE_1 INNER JOIN DimCurrency ON CTE_1.CurrencyKey = DimCurrency.CurrencyKey
			INNER JOIN CTE_2 ON CTE_1.SalesTerritoryKey = CTE_2.SalesTerritoryKey



  select NAme,row_num
   FROM (
   select *, ROW_NUMBER() over (order by salary desc) as row_num from tblEmployee 
   ) as T 
   inner join 
   (select *, ROW_NUMBER() over (order by salary desc) as row_num from tblEmployee ) as Q
   ON t.row_num = q.row_num

   where row_num IN (2,3,4)



with T (EmpID,EmpName,Gender,Enumeration,DeptID,Ranking)
AS
(
select *, ROW_NUMBER() over (order by salary desc) as row_num from tblEmployee 
)
,
Q
AS
(
select *, ROW_NUMBER() over (order by salary desc) as row_num from tblEmployee 
)
select * from T inner join Q on t.Ranking = Q.row_num where T.Ranking IN (2,3,4)






--- temp tables
select *, ROW_NUMBER() over (order by salary desc) as row_num into #temp from tblEmployee 

select * from #temp where row_num IN (2,3,4)


select TOP 5 * from tblemployee order by Name 

select distinct gender from tblemployee

use AdventureWorksDW2017

select * from DimCustomer 
select distinct englisheducation from DimCustomer



SELECT SalesAmount,TotalProductCost, 
	(SELECT DimCurrency.CurrencyName FROM DimCurrency WHERE CurrencyKey = FactInternetSales.CurrencyKey) AS CURR_NAME
 FROM FactInternetSales

SELECT * FROM DimCurrency

SELECT SalesAmount,TotalProductCost,CurrencyName
 FROM FactInternetSales inner join DimCurrency on FactInternetSales.CurrencyKey = DimCurrency.CurrencyKey

 SELECT SalesAmount,TotalProductCost, 
			(select CurrencyName FROM DimCurrency where FactInternetSales.CurrencyKey = DimCurrency.CurrencyKey )
FROM FactInternetSales 