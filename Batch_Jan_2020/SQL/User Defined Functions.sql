/* User Defined Functions*/
/* SCALAR FUNCTIONS - which returns always a value and only one value */

select DATEDIFF(MONTH,'2000-12-31',getdate())   --21 years

CREATE FUNCTION <Function_Name>(@Parameter1 DataType, @Parameter2 DataType,..@Parametern Datatype)
RETURNS Return_Datatype
AS
BEGIN
    Function Body
    Return Return_Datatype
END
use AdventureWorksDW2017


DECLARE @x int
set @x = 0
print @x

CREATE FUNCTION fn_Age(@DOB Date)  
RETURNS INT
AS  
BEGIN  
 DECLARE @Age INT  --varriable
 SET @Age = DATEDIFF(YEAR, @DOB, GETDATE()) - ---21
		CASE WHEN 
			(MONTH(@DOB) > MONTH(GETDATE())) OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())) THEN 1 ELSE 0 END  
 RETURN @Age  
END



select DATEDIFF(YEAR,'2000-12-31',getdate())   --21 years
select dbo.fn_Age('2000-12-31')



select firstname,birthdate,datediff(year,birthdate,getdate()) as age,dateadd(year,10,getdate()) as tenyrsnw,
    datediff(year,birthdate,dateadd(year,10,getdate())) as tenyrsafter_AGE from dimcustomer order by age desc

select firstname,birthdate,dbo.fn_age(birthdate) as tenyrsnw,dbo.fn_age(birthdate) + 10 as tenyrsafter_AGE from dimcustomer 


select firstname,birthdate,dbo.fn_age(birthdate) as tenyrsnw,dbo.fn_age(birthdate) + 10 as tenyrsafter_AGE from dimcustomer 
WHERE dbo.fn_Age(birthdate) <35




/* Inline Table Valued Functions   -- this will return a table always  */ 
select * from DimCustomer

CREATE FUNCTION fn_CustomerByOccupation(@EnglishOccupation nvarchar(10))
RETURNS TABLE
AS
RETURN (Select Firstname,Lastname,Gender,YearlyIncome,EnglishOccupation
      from DimCustomer
      where EnglishOccupation = @EnglishOccupation)

select * from fn_CustomerByOccupation('Manual') A inner join dimcustomer B
		ON	A.Firstname = B.Firstname
				

select distinct EnglishOccupation from dimcustomer

/* Multi Valued Table Valued Functions -- almost similar to above one, but only difference is we can define schema of table */

CREATE FUNCTION fn_CustomerByOccupationMVT(@EnglishOccupation nvarchar(10))
RETURNS @TABLE TABLE(Firstname nvarchar(100),LastName varchar(100),Gender char(1),YearlyIncome int, EnglishOccupation varchar(100))
AS
begin
insert into @TABLE  --- insertion of data in table varriable.
Select Firstname,Lastname,Gender,YearlyIncome,EnglishOccupation
      from DimCustomer
      where EnglishOccupation = @EnglishOccupation
	  return
END

select * from fn_CustomerByOccupationMVT('Clerical')





