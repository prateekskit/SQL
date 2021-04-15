--- TEMP TABLES
--- local temp tables
SELECT * FROM DimCustomer
SELECT * INTO #TEMP_CUSTOMER FROM DimCustomer
			WHERE TotalChildren = 5

SELECT * FROM #TEMP_CUSTOMER

update #TEMP_CUSTOMER
SET YearlyIncome = 25000