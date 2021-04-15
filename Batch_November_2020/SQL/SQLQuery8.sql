/* User Defined Functions*/
/* Scalar Functions  */
--- Funtions can take parameters
--- Functions will always return a value to you
--- Inside Functions you can not perform the INSERT/UPDATE/DELETE Operations

DATEDIFF(YEAR,@DOB,GETDATE())-
		CASE WHEN (
					MONTH(@DOB) > MONTH( GETDATE() 
										)
				  )




DATEDIFF(YEAR, @DOB, GETDATE()) - 
				CASE WHEN (MONTH(@DOB) > MONTH(GETDATE())) 
				OR (MONTH(@DOB) = MONTH(GETDATE()) 
				AND DAY(@DOB) > DAY(GETDATE())) THEN 1 ELSE 0 END  


CREATE FUNCTION <Function_Name>(
	@Parameter1 DataType, @Parameter2 DataType,..@Parametern Datatype)
RETURNS Return_Datatype
AS
BEGIN
    Function Body
    Return Return_Datatype
END


select * from DimCustomerCopy
select BirthDate,
dbo.fn_Age(BirthDate) as 'Age_From_Function' 
from DimCustomerCopy
WHERE dbo.fn_Age(BirthDate) <35



order by BirthDate desc
select dbo.fn_Age('2000/09/1')
CREATE FUNCTION fn_Age(@DOB Date)  
RETURNS INT  
AS  
BEGIN  
 DECLARE @Age INT  
 SET @Age = DATEDIFF(YEAR, @DOB, GETDATE()) - 
				CASE WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())) THEN 1 ELSE 0 END  
 RETURN @Age  
END










select dbo.fn_Age('1988/06/24')



select firstname,birthdate,datediff(year,birthdate,getdate()) as age,dateadd(year,10,getdate()) as tenyrsnw,
    datediff(year,birthdate,dateadd(year,10,getdate())) as tenyrsafter_AGE from dimcustomer order by age desc

select firstname,birthdate,dbo.fn_age(birthdate) as tenyrsnw,dbo.fn_age(birthdate) + 10 as tenyrsafter_AGE from dimcustomer 


select firstname,birthdate,dbo.fn_age(birthdate) as tenyrsnw,dbo.fn_age(birthdate) + 10 as tenyrsafter_AGE from dimcustomer 
WHERE dbo.fn_Age(birthdate) <35




/* Inline Table Valued Functions -- this will return   */ 
select * from DimCustomerCopy

ALTER FUNCTION fn_CustomerByOccupation(@EnglishOccupation nvarchar(20))
RETURNS TABLE
AS
RETURN (Select Firstname,Lastname,Gender,YearlyIncome,EnglishOccupation
      from DimCustomerCopy
      where EnglishOccupation = @EnglishOccupation)


select * from fn_CustomerByOccupation('Professional')



select distinct EnglishOccupation from tbl_DimCustomer
select * from fn_CustomerByOccupation('Clerical')
select * from dimcustomer

/* Multi Valued Table Valued Functions -- almost similar to above one, but only difference is we can define schema of table */

ALTER FUNCTION fn_CustomerByOccupationMVT(@EnglishOccupation nvarchar(10))
RETURNS @TABLE TABLE(Firstname nvarchar(100),LastName varchar(100),Gender char(1),YearlyIncome int, EnglishOccupation varchar(100))
AS
begin
insert into @TABLE
Select Firstname,Lastname,Gender,YearlyIncome,EnglishOccupation
      from tbl_DimCustomer
      where EnglishOccupation = @EnglishOccupation
	  return
END

select * from fn_CustomerByOccupationMVT('Clerical')





