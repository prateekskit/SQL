/*
4.	Give me Profit details for all the products according to their salesterritoryregion & currency type.
 Final output should list, productsubcategory,productcategory,region,currency,
 and profit ( salesAmount-totalproductcost-taxamount-freightamount). 
 
 Please use below methods to produce output. You have to form query with each of below way,
 
 so ultimately there will be 3 query, producing same output.

a.	CTE   ---- to write this query
b.	Subquery
c.	Joins
*/

select * from DimProductCategory
select * from DimProductSubcategory
select * from dimproduct
select * from DimSalesTerritory
select * from DimCurrency
select * from FactInternetSales where ProductKey is null

sp_help dimproduct
select * from DimProductSubcategory

with CTE_PROD
AS
(
select DP.ProductKey,dps.EnglishProductSubcategoryName,dpc.EnglishProductCategoryName
FROM dimproduct DP inner join DimProductSubcategory DPS on dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
				    inner join DimProductCategory DPC on dps.ProductCategoryKey = DPC.ProductCategoryKey
)
select CTE.EnglishProductCategoryName,CTE.EnglishProductSubcategoryName
		,DT.SalesTerritoryRegion,DC.CurrencyName,
		SUM(FIS.SalesAmount - (FIS.TotalProductCost + FIS.TaxAmt + FIS.Freight)) AS TotalProfit
 FROM CTE_PROD CTE inner join FactInternetSales FIS on CTE.ProductKey = FIS.ProductKey
					   inner join DimSalesTerritory DT on DT.SalesTerritoryKey = FIS.SalesTerritoryKey
					   inner join DimCurrency  DC on DC.CurrencyKey = FIS.CurrencyKey
					 GROUP BY 	CTE.EnglishProductCategoryName,CTE.EnglishProductSubcategoryName
		,DT.SalesTerritoryRegion,DC.CurrencyName				   
