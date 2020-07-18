/* User Defined Functions*/

/* Scalar Functions  */

CREATE FUNCTION Function_Name(@Parameter1 DataType, @Parameter2 DataType,..@Parametern Datatype)
RETURNS Return_Datatype
AS
BEGIN
    Function Body
    Return Return_Datatype
END

DECLARE @x int
set @x = 1
select @x


CREATE FUNCTION fn_Age(@DOB Date)  --- parameters 
RETURNS INT  
AS  
BEGIN  
 DECLARE @Age INT  ---varriables
 SET @Age = DATEDIFF(YEAR, @DOB, GETDATE()) - CASE WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())) THEN 1 ELSE 0 END  
 RETURN @Age  
END


use AdventureWorksDW2017

select firstname,birthdate,dbo.fn_Age(BirthDate) as yearss from DimCustomer

select fn_Age('1988/12/24')



select firstname,birthdate,datediff(year,birthdate,getdate()) as age,dateadd(year,10,getdate()) as tenyrsnw,
    datediff(year,birthdate,dateadd(year,10,getdate())) as tenyrsafter_AGE from dimcustomer order by age desc

select firstname,birthdate,dbo.fn_age(birthdate) as tenyrsnw,dbo.fn_age(birthdate) + 10 as tenyrsafter_AGE from dimcustomer 


select firstname,birthdate,dbo.fn_age(birthdate) as tenyrsnw,dbo.fn_age(birthdate) + 10 as tenyrsafter_AGE from dimcustomer 
WHERE dbo.fn_Age(birthdate) <35




/* Inline Table Valued Functions   -- this will return  table/set of data */ 
select * from DimCustomer

ALTER FUNCTION fn_CustomerByOccupation_NEW(@EnglishOccupation nvarchar(20))
RETURNS TABLE
AS
RETURN (Select Firstname,Lastname,Gender,YearlyIncome,EnglishOccupation
      from DimCustomer
      where EnglishOccupation = @EnglishOccupation)


	  select * from fn_CustomerByOccupation_NEW('Professional') inner join 


select * from fn_CustomerByOccupation('Clerical')

select * from dimcustomer

/* Multi Valued Table Valued Functions -- almost similar to above one, but only difference is we can define schema of table */

ALTER FUNCTION fn_CustomerByOccupationMVT(@EnglishOccupation nvarchar(10))
RETURNS @TABLE TABLE(namee nvarchar(200),Gender char(1),YearlyIncome int, EnglishOccupation varchar(100))
AS
begin
insert into @TABLE
Select Firstname + Lastname,Gender,YearlyIncome,EnglishOccupation
      from DimCustomer
      where EnglishOccupation = @EnglishOccupation
	  return
END

select * from fn_CustomerByOccupationMVT('Clerical')





