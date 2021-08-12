use JB_2021_April
-- TRANSACT SQL 
-- IF-ELSE & WHILE CLAUSES , DECLARE A VARRIABLE 
---- TEMP TABLES , CTES, 

-- DECLARE VARRIABLE
--- DECLARE <varriable_name> <data_type>

DECLARE @x int 
set @x = 1
select @x
select @x =  CustomerKey from DIMCUSTOMER_REPLICA where CustomerKey = 11000
select @x

/*------------------------------------------------------------------
if-else
----------------------------------------------------------------- */

DECLARE @str varchar(100)
set @str = 'My name is Janbask'

IF(LEN(@str) > 10)
	print 'string is passed'
ELSE
	print 'string is failed'


	
--- I wanted to fetch all the records for the education which has the highest yearlyincome 

--select * from DIMCUSTOMER_REPLICA where EnglishEducation in (select top 1 EnglishEducation from DIMCUSTOMER_REPLICA order by YearlyIncome desc )

DECLARE @str varchar(100)  --- declare a varriable 

select top 1  @str =  EnglishEducation from DIMCUSTOMER_REPLICA order by YearlyIncome desc

IF(@str = 'Graduate Degree')
	print 'education is Gradute Degree'
ELSE IF (@str = 'Partial High School')
	print 'Partial High School'
ELSE
	select * from DIMCUSTOMER_REPLICA 


	use AdventureWorksDW2017

	select color,count(*) from DimProduct group  by color

--------------------
-- change the value in the table with color mentioned in the 
-------------------
DECLARE @color varchar(1000)
set @color = 'PINK'

if exists(select * from DimProduct where color = @color)
	print 'color is present'
else
	update DimProduct
	set color = @color
	where color = 'NA'

---- WHILE BLOCK

select * from tblA

declare @id int
set @id = 1

WHILE EXISTS(select * from tblA)
	BEGIN
			delete from tblA where id = @id
			set @id = @id + 1
	END
print @id



DECLARE @x int     --- declare a varraible
SET @x = 10			---- initialize a varriable
WHILE (@x > 0)			---- define a condition 
	BEGIN
			print @x
			SET @x = @x - 1			---- increment the value
	END

print 'Loop is ended'






	








