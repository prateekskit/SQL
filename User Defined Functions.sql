/* User Defined Functions*/


/* Scalar Functions  */
/* functions syntax*/
CREATE FUNCTION Function_Name(@Parameter1 DataType, @Parameter2 DataType,..@Parametern Datatype)
RETURNS @varriable <Return_Datatype>
AS
BEGIN
    Function Body
    RETURN @varriable
END


/*Calculate Age*/
/*Scaler Functions : Always returns a sinle value*/
ALTER FUNCTION fn_Age(@DOB Date)  
RETURNS INT  
AS  
BEGIN  
 DECLARE @Age INT  
 SET @Age = DATEDIFF(YEAR, @DOB, GETDATE()) - 
				CASE WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())) THEN 1 
				ELSE 0 END  
 RETURN @Age  
END

select dbo.fn_Age('1988/06/24')



select firstname,birthdate,datediff(year,birthdate,getdate()) as age,dateadd(year,10,getdate()) as tenyrsnw,
    datediff(year,birthdate,dateadd(year,10,getdate())) as tenyrsafter_AGE from dimcustomer order by age desc

select firstname,birthdate,dbo.fn_age(birthdate) as tenyrsnw,dbo.fn_age(birthdate) + 10 as tenyrsafter_AGE from dimcustomer 


select firstname,birthdate,dbo.fn_age(birthdate) as tenyrsnw,dbo.fn_age(birthdate) + 10 as tenyrsafter_AGE from dimcustomer 
WHERE dbo.fn_Age(birthdate) <35




/* Inline Table Valued Functions   -- this will return table/Select results 
directly use it in FROM clause , always returns table ( pre-defined)  */ 

select * from DimCustomer
ALTER FUNCTION fn_CustomerByOccupation(@EnglishOccupation nvarchar(50))
RETURNS TABLE
AS
RETURN (Select Firstname,Lastname,Gender,YearlyIncome,EnglishOccupation
      from DimCustomer
      where EnglishOccupation = @EnglishOccupation)


select * from fn_CustomerByOccupation('Skilled Manual')

select * from dimcustomer

/* Multi Valued Table Valued Functions -- almost similar to above one, but only difference is we can define schema of table */
/* Provide an real time example :  Lets say , before you select data via a function, but you wanted to do some 
insert or updation of value , then you can use the table valued function. I may sound contradicting that how can we 
perform DML in functions, but in case of table valued function, we are creating the table inside function and then 
performing DML only on that particular table. Not any other physical present object of database. so its allowed.             */


ALTER FUNCTION fn_CustomerByOccupationMVT(@EnglishOccupation nvarchar(10))
RETURNS @TABLE TABLE(Firstname nvarchar(100),LastName varchar(100),Gender char(1),YearlyIncome int, EnglishOccupation varchar(100))
AS
begin

insert into @TABLE
Select Firstname,Lastname,Gender,YearlyIncome,EnglishOccupation
      from DimCustomer
      where EnglishOccupation = @EnglishOccupation
	  /* this has changed the value of Gender for just temp table and providing you modified data. but in reality nothing
	  has been changed at underlying table values'   */
	  update @table
	  set gender = 'F'

	  return
END

select * from fn_CustomerByOccupationMVT('Clerical')





