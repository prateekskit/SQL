use JB_2021


select GETDATE()

CREATE FUNCTION fn_Age(@DOB Date) --- parameter  
RETURNS INT  
AS  
BEGIN  
	 DECLARE @X INT  ---- VARRIABLE DECLARATION
	 SET @X =   DATEDIFF(YEAR, @DOB, GETDATE()) - 
				CASE    
				WHEN (MONTH(@DOB) > MONTH(GETDATE()))  -- FALSE
				OR 
				(MONTH(@DOB) = MONTH(GETDATE())  --true
				 AND DAY(@DOB) > DAY(GETDATE())  -- false
				 )   --- FALSE
				 THEN 1 ELSE 0 END  
	 RETURN @X  
	 --- '1991-08-30'
	 --Return DATEDIFF(YEAR, @DOB, GETDATE()) - 
		--		CASE WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR (MONTH(@DOB) = MONTH(GETDATE())
		---		AND DAY(@DOB) > DAY(GETDATE())) THEN 1 ELSE 0 END 

END

--- DATEDIFF(YEAR, @DOB, GETDATE()) = 30 year
--- (MONTH('1991-09-01') > MONTH(GETDATE())) = true   = 1
--- 30 - 1 = 29
select
CASE 
				WHEN (MONTH('1991-09-01') > MONTH(GETDATE())) OR 
				(MONTH('1991-08-31') = MONTH(GETDATE()) AND DAY('1991-08-30') > DAY(GETDATE()))

select dbo.fn_age('1991-08-30')

-- 2 * 3 - 2 + 5
--- (2*3) - (2+5+9) = -1
--- 2* (3 - 2) +5 = 7
--  (1+2) + (-3) 


BRACKET 
select firstname,lastname,birthdate,dbo.fn_Age(birthdate) as 'Age',dbo.fn_Age(birthdate) + 10 as 'Age'
from dimcustomer_Bakcup
order by dbo.fn_age(birthdate)

------------------- Table Functions -----------------------

select * from dimcustomer_Bakcup

ALTER FUNCTION fn_tableValue(@email nvarchar(100)) --- parameter  
RETURNS TABLE  
AS  
  
			RETURN  
			(  select FirstName,LastName,EmailAddress,EnglishEducation,EnglishOccupation 
				from dimcustomer_Bakcup
				where EmailAddress like '%@email%' )


select * from fn_tableValue('50')

declare @email nvarchar(100)
set @email = '@'
select FirstName,LastName,EmailAddress,EnglishEducation,EnglishOccupation 
				from dimcustomer_Bakcup
				where EmailAddress like '%@email%'

---------------- while and if and else conditions ----------------------


declare @x int
set @x = 99

if(@x > 100)
	begin
		print @x
		print 'first condition is true'
	end
else if (@x < 100)
	begin
		print @x
		print 'second condition is true'
	end
else
	begin
		print @x
		print 'default condition is true'
	end

------------------------------ while loop -------------------


DECLARE @x int       ---- declare a varriable
set @x = 0           ----  initialize a varriable with a specific value

WHILE(@x > -1)			------ putting a RIGHT condition
	BEGIN
		
		PRINT @x
		set @x = @x + 1  ----- increment operations

	END

