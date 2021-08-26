--- CTEs --- common table Expressions

/*
WITH <cte_name> [(optional columns)]
AS
(

Query statement


)

select * from <cte_name>
*/

select T.EnglishProductName, FIS.SalesAmount  
FROM 
		( select ProductKey,Color,EnglishProductName from DimProduct inner join	DimProductSubcategory
							on DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
						where EnglishProductSubcategoryName = 'Mountain Bikes'
			) AS T

			inner join FactInternetSales FIS
				ON T.ProductKey = FIS.ProductKey

---- step 1 --- get all the products where subcategory is mountain bike
---- step 2 --- 

with cte_mountainbikes
AS
(
select ProductKey,Color,EnglishProductName from DimProduct inner join	DimProductSubcategory
							on DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
						where EnglishProductSubcategoryName = 'Mountain Bikes'
)
select T.EnglishProductName, FIS.SalesAmount 
	from cte_mountainbikes T
					inner join FactInternetSales FIS ON T.ProductKey = FIS.ProductKey

select * from cte_mountainbikes
-------------------- TEMP TABLES ------------------------
---- local temp table	
select ProductKey,Color,EnglishProductName into #temp_table
from DimProduct inner join	DimProductSubcategory
							on DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
						where EnglishProductSubcategoryName = 'Mountain Bikes'				


select * from #temp_table

select T.EnglishProductName, FIS.SalesAmount 
	from #temp_table T
					inner join FactInternetSales FIS ON T.ProductKey = FIS.ProductKey


--------------------------------------------------------------------------
--- Global Temp Table



select ProductKey,Color,EnglishProductName into ##temp_Global
from DimProduct inner join	DimProductSubcategory
							on DimProduct.ProductSubcategoryKey = DimProductSubcategory.ProductSubcategoryKey
						where EnglishProductSubcategoryName = 'Mountain Bikes'				

		
		
		
select * from ##temp_Global			

----------------------------------------------------------------------
----------------------FUNCTIONS------------------------------------


--------------------------------FUNCTIONS--------------------------------------- 

---- It takes 0 or more values/parameter to perform some operations as per the need.
--- it always returns you a value

---  system functions
---- user defined functionss

----- SYSTEM FUNCTIONS
-- AGGREGATE FUNCTIONS -- MAX,MIN,SUM,AVG,COUNT
select * from FactInternetSales 
select orderdate,sum(salesamount) 
from FactInternetSales 
group  by OrderDate


--- REPLACING NULL VALUES

select * from DimCustomer

select firstname,middlename,lastname,
	 Firstname + ' '+ Middlename + ' ' + Lastname AS 'Full Name' 
from DimCustomer 

	 select firstname,middlename,lastname,
	 Firstname + ' '+  
	 CASE WHEN Middlename is null then 'X'
		ELSE MiddleName END
	 + ' ' + Lastname from DimCustomer 

	 select firstname,middlename,lastname,
	 Firstname + ' '+  ISNULL(middlename,'X')
	 + ' ' + Lastname from DimCustomer 

	 sales-tax-initiacost = profit
----- COALESCE -- COALESCE(a,b,c,d)

select * from DimCustomer

 select firstname,middlename,title,suffix,lastname,
	 Firstname + ' '+  COALESCE(MiddleName,title,suffix,'xx')
	 + ' ' + Lastname from DimCustomer 
	 where MiddleName is not null and title is not null --and Suffix is not null

----- STRING FUNCTIONS

select firstname,middlename,title,suffix,lastname,
	 Firstname + ' '+  COALESCE(MiddleName,title,suffix,'xx')
	 + ' ' + Lastname from DimCustomer 
	 where MiddleName is not null and title is not null --and Suffix is not null

	 select firstname,UPPER(firstname) from DimCustomer
	 select firstname,LOWER(firstname) from DimCustomer

	 --- UPPER LOWER REVERSE LEN REPLACE LEFT RIGHT
