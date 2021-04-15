-- by default order by is ascending
select * from DimCustomer 
ORDER BY FirstName 

select * from DimCustomer 
ORDER BY FirstName desc

select * 
from DimCustomer 
where firstname like '%ay%'
ORDER BY FirstName desc,lastname desc

----- TOP clause

SELECT TOP 3 CUSTOMERKEY,FIRSTNAME,LASTNAME,YEARLYINCOME 
FROM DimCustomer
ORDER BY YearlyIncome DESC

--- case Statements
SELECT  CUSTOMERKEY,FIRSTNAME,LASTNAME,
		CASE 
			WHEN YearlyIncome > 0 and YearlyIncome <= 50000 then 'Bronze'
			WHEN YearlyIncome > 50000 and YearlyIncome <= 150000 then 'SILVER'
			ELSE 'GOLD' END AS 'INCOME_GROUP'
FROM DimCustomer
order by YearlyIncome







