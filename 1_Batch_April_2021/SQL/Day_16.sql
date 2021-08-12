---stored procedure-------
-- function will always returns a value and its mandatory.
--- SP its not mandatory to return a value

--- function will only  support select operations while SP can support any operations which is in SQL


---- system procedure

exec sp_help dimcustomer 
exec sp_helptext [dbo.CalculateAge]    --- definition of SP,views,functions


---  user defined stroed procedure
--- Create a procedure
CREATE PROCEDURE getCustomerData
AS
BEGIN

	select * from DimCustomer
		

END

--- Alter the same procedure
ALTER PROCEDURE getCustomerData
	@englishEducation varchar(100), @gender varchar(10)
AS
BEGIN

IF(@gender = 'Male')
	SET @gender = 'M'
Else 
	SET @gender = 'F'

	select * from DimCustomer WHERE EnglishEducation = @englishEducation and gender  = @gender
		

END

----- select the territory based on the passed parameter, if no value is identified then insert the data 
---- in table.
CREATE PROCEDURE GetInsTerritory
	@Region varchar(100),@country varchar(100), @group varchar(100)
AS
BEGIN
	
	-- this if blocks check if any rows are coming from table based on the query
	IF EXISTS(select * from DimSalesTerritory where SalesTerritoryRegion = @Region
													AND SalesTerritoryCountry = @country
													AND  SalesTerritoryGroup = @group )
		BEGIN

			select * from DimSalesTerritory where SalesTerritoryRegion = @Region
													AND SalesTerritoryCountry = @country
													AND  SalesTerritoryGroup = @group 
		END
	ELSE
		BEGIN

			--DECLARE @pk int   --- this a new varriable which will store the recently entered key value from table
			--- this query will give me recently entered PK from table
			--select top 1  @pk = SalesTerritoryKey from DimSalesTerritory order by SalesTerritoryKey desc
			--SET @pk = @pk + 1

			INSERT INTO DimSalesTerritory
			VALUES(NULL,@Region,@country,@group,NULL)

		END




END


END

--- get the country information based on paramtere ppassed.  -- SELECT
--- if values is not matching with any country, then insert that as a new reecord.  -- INSERT

ALTER PROCEDURE GetInsTerritory
	@Region varchar(100),@country varchar(100), @group varchar(100)
AS
BEGIN
	
	-- this if blocks check if any rows are coming from table based on the query
	IF EXISTS(select * from DimSalesTerritory where SalesTerritoryRegion = @Region
													AND SalesTerritoryCountry = @country
													AND  SalesTerritoryGroup = @group )
		BEGIN

			select * from DimSalesTerritory where SalesTerritoryRegion = @Region
													AND SalesTerritoryCountry = @country
													AND  SalesTerritoryGroup = @group 
		END
	ELSE
		BEGIN

			DECLARE @pk int   --- this a new varriable which will store the recently entered key value from table
			---this query will give me recently entered PK from table
			select top 1  @pk = MAX(SalesTerritoryAlternateKey) from DimSalesTerritory  -- @pk = 14
			SET @pk = @pk + 1

			INSERT INTO DimSalesTerritory
			VALUES(@pk,@Region,@country,@group,NULL)

			select * from DimSalesTerritory where SalesTerritoryRegion = @Region
													AND SalesTerritoryCountry = @country
													AND  SalesTerritoryGroup = @group 

		END

END
select * from DimSalesTerritory



declare @pk int
select * from DimSalesTerritory
select  top 1 @pk =  SalesTerritoryKey from DimSalesTerritory order by SalesTerritoryKey desc
print @pk

sp_help DimSalesTerritory
exec getCustomerData 'Bachelors','Male'
getCustomerData


exec GetInsTerritory 'Nordics','Denmark','Europe'