----------- SET OPERATORS ---------------------||||-----------
--- UNION
---- UNION ALL
---- EXCEPT
---- INTERSECT

--- 1. column should have same data type in upper block and lower block
---- 2. number of column should be similar in upper block as well as in lower block
Create Table tblA
(
color varchar(100)
)
Create Table tblB
(
color varchar(100)
)

Insert into tblB
Values ('Black'),('Brown'),('Silver'),('Orange'),('Aqua')

select * from tblA
select * from tblB

--- UNION 

select color from tblA
union   --- will not consider the duplicates
select color from tblB

select 'abcd'
union
select 1   

--- union all
select color from tblA 
union All   --- will consider the duplicates 
select color from tblB

select 1
union
select 2
union 
select 3
union 
select 4


-------  EXCEPT OPERATOR -----------------------
------------- substraction-------
------------ A-B

select * from tblA
select * from tblB

select color from tblA
except
select color from tblB

select color from tblB
except
select color from tblA


---------- INTERSECT OPERATORS -----------

select color from tblA
INTERSECT 
select color from tblB

select color from tblB
INTERSECT 
select color from tblA
--------------------------------------------------------------------------------------------------------------

---------------------------------------------------MERGE STATEMENTS -----------------------------

Create table StudentSource
(
     ID int primary key,
     Name nvarchar(20)
)
GO

Insert into StudentSource values (1, 'Mike')
Insert into StudentSource values (2, 'Sara')
GO

Create table StudentTarget
(
     ID int primary key,
     Name nvarchar(20)
)
GO

Insert into StudentTarget values (1, 'Mike M')
Insert into StudentTarget values (3, 'John')
GO

select * from StudentSource
select * from StudentTarget

MERGE [TARGET] AS T
USING [SOURCE] AS S
   ON [JOIN_CONDITIONS]
 WHEN MATCHED THEN 
      [UPDATE STATEMENT]
 WHEN NOT MATCHED BY TARGET THEN
      [INSERT STATEMENT] 
 WHEN NOT MATCHED BY SOURCE THEN
      [DELETE STATEMENT]

MERGE StudentTarget AS T
USING StudentSource AS S
ON T.ID = S.ID
WHEN MATCHED THEN
     UPDATE SET T.NAME = S.NAME
WHEN NOT MATCHED BY TARGET THEN
     INSERT (ID, NAME) VALUES(S.ID, S.NAME)
WHEN NOT MATCHED BY SOURCE THEN
     DELETE;

-----------------------------------------------------------------------------------

--- DML --- Data Manipulation 
-- DDL   --- DAta Definition
--- select,insert,,update,delete,truncate
---- from,where,group by,having,order by,distinct,top, offset fetch,
--- case, iff
--- join, set 
-- identity 
--- constraints - pk,fk,uk,null,deffault,check
--- MERGE 
----------------------------------FUNCTIONS---------------------------------
--- system ffunctions
------  Aggregate 
-------- string  -- NULL
-------- datetime
-------- 
--- user defined functions


---- REPLACING THE NULL VALUEs 

use AdventureWorksDW2017

select distinct Title from DimCustomer
select title,firstname,MiddleName,LastName from DimCustomer


---- wherever the NULL is appearing in the middlename I wanted to replace it with a value as "XX"


select title,firstname, middlename,
		
		CASE when MiddleName is null then 'XX'
			else MiddleName end as New_Middlename,

		LastName
from DimCustomer

--- ISNULL --- is a function which helps you to replace the null values 


select  title,firstname,middlename, 
						ISNULL(middlename,'XX') as new_middlename , lastname from DimCustomer

-----------------------------------------------------------

---- STRING  ---- 

select firstname,UPPER(firstname)    from DimCustomer
select firstname,LOWER(firstname)    from DimCustomer
select firstname,REVERSE(firstname)    from DimCustomer


select emailaddress,REPLACE(emailaddress,'@','##') from DimCustomer

--LEFT 
-- RIGHT

select emailaddress,LEFT(emailaddress,10) from DimCustomer
select emailaddress,LEFT(emailaddress,10),RIGHT(emailaddress,10) from DimCustomer

--- substrings

select emailaddress, substring(emailaddress,10,5) from DimCustomer

select emailaddress, substring(emailaddress,15,3) from DimCustomer

-- LEN   -- gives you the length of the string 

select emailaddress, LEN(EmailAddress) from DimCustomer


--- charindex     ---- tells you about the poisition of a specific character 

select emailaddress, charindex('@',EmailAddress) from DimCustomer


select 'My name is #john# ticker tape #',charindex('#','My name is #john# ticker tape #',13)

select emailaddress, charindex('@',EmailAddress),
			
			LEFT(emailaddress,charindex('@',EmailAddress) - 1 )
			
 from DimCustomer

 ------- TRIM FUNCTIONS ----

 select '                                            JANBASK                                                                  '
 select RTRIM('JANBASK                                                                  ')
 select LTRIM('JANBASK                                                                  ')


 --------------
 ---------------CAST--------------------------
 
 
 select 1 + 1   --
 
 select 'Jan' +  'Bask'

 select  CAST(CustomerKey as varchar) + '_' + FirstName from DimCustomer

 select CAST(1 as varchar) + '_Bask'
   

 select 1 + CAST('Bask' as int)   --


 select * from DimCustomer where LEN(firstname) > 8

 select * from DimCustomer where LEFT(BirthDate,4) > 1985



 --------------------------- date time functions ---------------------
 use JB_2021_April
CREATE TABLE tblDateTime
(
 c_time time(7) NULL,
 c_date date NULL,
 c_smalldatetime smalldatetime NULL,
 c_datetime datetime NULL,
 c_datetime2 datetime2(7) NULL,
 c_datetimeoffset datetimeoffset(7) NULL
)


select * from tblDateTime
----  Get the current system date
select getdate()
select SYSDATETIME()

INSERT INTO tblDateTime 
VALUES (GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE())
select * from tblDateTime
--- it tells you wheter the data is in correct format or not.
ISDATE
-- 1 Correct & 0 - Incorrect
SELECT ISDATE('2020-12-03')   --- 1
SELECT ISDATE('2020-20-03')   ---- 0
SELECT ISDATE('Pragim')   ---- 0

SELECT ISDATE('2020-02-29')   ---- 1

-- EOMONTH()  --- 
  
select EOMONTH(GETDATE())
select EOMONTH('2021-06-02')

------ DAY,MONTH,YEAR
select DAY(getdate())
select YEAR(getdate())
use AdventureWorksDW2017
select BirthDate,YEAR(BirthDate) from DimCustomer

select distinct YEAR(BirthDate) from DimCustomer order by YEAR(birthdate)

select distinct YEAR(BirthDate) from DimCustomer 
WHERE YEAR(birthdate) between 1975 and 1982
order by YEAR(birthdate)

----- DATEADD -----  it helps you to add specific components.
select GETDATE()


select GETDATE() + 10

SELECT DATEADD(YEAR,10,getdate())
SELECT DATEADD(MONTH,12,getdate())
SELECT DATEADD(MONTH,-12,getdate())

select distinct YEAR(BirthDate), YEAR(DATEADD(YEAR,10,BirthDate)) from DimCustomer 
WHERE YEAR(birthdate) between 1975 and 1982
order by YEAR(birthdate)

----- DATE DIFFERENCE    ---- 


select birthdate,
		 DATEDIFF(DAY,BirthDate,getdate()) as Day_Diff
		 ,DATEDIFF(MONTH,BirthDate,getdate()) as Month_Diff
		 ,DATEDIFF(YEAR,BirthDate,getdate()) as YEAR_Diff from DimCustomer


select datepart(day,getdate())
select datepart(MONTH,getdate())
select datepart(YEAR,getdate())

select datepart(Q,getdate())   -- quarter 
select datepart(WEEKDAY,getdate())   -- weekday number
select datepart(WEEK,getdate())           --- week number 
select datepart(M,getdate())            ---- Month number


select DATENAME(MONTH,getdate())   --- name
select DATENAME(WEEKDAY,getdate())   --- name
select DATENAME(QUARTER,getdate())   --- name



--------------------------------WINDOWS FUNCTION or RANKING FUNCTIONS----------------


--- sub-qeuries 

select firstname,gender,yearlyincome into table_customer
from DimCustomer where customerkey IN (select MAx(customerkey) from DimCustomer where YearlyIncome is not null group by YearlyIncome )
select * from table_customer



---- ROW_NUMBER() , RANK(), DENSE_RANK()

---  highest salary to be 1st 


SELECT FIRSTNAME,GENDER,YEARLYINCOME, ROW_NUMBER() OVER(order by yearlyincome desc)
from table_customer

SELECT FIRSTNAME,GENDER,YEARLYINCOME, ROW_NUMBER() OVER(order by yearlyincome desc,Firstname )
from table_customer

SELECT FIRSTNAME,GENDER,YEARLYINCOME, 
							ROW_NUMBER() OVER(order by yearlyincome desc ) AS 'ROW NUMBER',
								RANK() OVER(order by yearlyincome desc )  AS 'RANK',
								DENSE_RANK() OVER(order by yearlyincome desc )  AS 'DENSE_RANK'
from table_customer

----  partitioning during the ranking functions.


SELECT FIRSTNAME,GENDER,YEARLYINCOME, 
							ROW_NUMBER() OVER(partition by GENDER order by yearlyincome desc ) AS 'ROW NUMBER',
								RANK() OVER(partition by GENDER order by yearlyincome desc )  AS 'RANK',
								DENSE_RANK() OVER( partition by GENDER order by yearlyincome desc )  AS 'DENSE_RANK'
from table_customer
WHERE [ROW NUMBER] = 1



-----  USER DEFINED FUNCTIONS --------------------------
	--- 1. SCALAR VALUE
	---- 2. TABLE VALUED


1991-02-03

2021-02-02    -- 29 years 

select DATEDIFF(YEAR,'1991-01-01','2021-02-02')

select birthdate,
		 DATEDIFF(DAY,BirthDate,getdate()) as Day_Diff
		 ,DATEDIFF(MONTH,BirthDate,getdate()) as Month_Diff
		 ,DATEDIFF(YEAR,BirthDate,getdate()) as YEAR_Diff from DimCustomer

---- SCALAR VALUED FUNCTIONS ----------

/*
CREATE FUNCTION <FUNCTION_NAME>(PARAMETERS 1 DATATYPE, PARAMETERS 2 DATAYPE .... PARAMETERS n DATATYPE)
RETURNS INT,VARCHAR <DATATYPE>
AS
	BEGIN

		WRITE DOWN YOUR LOGIC

		RETURN VALUE;

	END
*/

31-05-1991
31 > 30
30 - 0 = 30
30 - 1= 29

CREATE FUNCTION fn_Age(@DOB Date)  
RETURNS INT  
AS  
BEGIN  
	 DECLARE @X INT  ---- VARRIABLE DECLARATION
	 SET @X = DATEDIFF(YEAR, @DOB, GETDATE()) - 
					CASE 
						WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())) THEN 1 
						ELSE 0 
					END  
	 RETURN @X  
END

select birthdate,dbo.fn_age(birthdate) as age from DimCustomer
where dbo.fn_Age(birthdate) < 50

select dbo.fn_age('2020-03-03')

ALTER FUNCTION fn_Age(@DOB Date)  
RETURNS INT  
AS  
BEGIN  
	 DECLARE @X INT  ---- VARRIABLE DECLARATION
	 SET @X = DATEDIFF(YEAR, @DOB, GETDATE()) - CASE WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())) THEN 1 ELSE 0 END  
	 RETURN @X  
END



---- table valued 

/*
CREATE FUNCTION <FUNCTION_NAME>(PARAMETERS 1 DATATYPE, PARAMETERS 2 DATAYPE .... PARAMETERS n DATATYPE)
RETURNS TABLE
AS
RETURN (select * from tabl)
*/

select distinct EnglishOccupation from DimCustomer

CREATE FUNCTION fn_CustomerByOccupation(@EnglishOccupation nvarchar(10))
RETURNS TABLE
AS
RETURN (Select Firstname,Lastname,Gender,YearlyIncome,EnglishOccupation
      from DimCustomer
      where EnglishOccupation = @EnglishOccupation)

select * from dbo.fn_CustomerByOccupation('Manual')


------------------------------------- SUB QUERIES OR NESTED QUERY ----------------------
--- query inside a query

---- utilize the sub query or inner query with WHERE clause
select * from DimCustomer
		where FirstName IN (select firstname from DimEmployee )


--- query result with FROM Clause

select  * FROM
				(
							SELECT FIRSTNAME,GENDER,YEARLYINCOME, 
							ROW_NUMBER() OVER(order by yearlyincome desc ) AS 'ROW NUMBER',
							RANK() OVER(order by yearlyincome desc )  AS 'RANK',
							DENSE_RANK() OVER(order by yearlyincome desc )  AS 'DENSE_RANK'
							from table_customer
				) AS T
WHERE RANK IN (3,4,5)

--- with select clause ---

select * from DimCustomer

select CustomerKey,  
		(select city from DimGeography DG where DG.GeographyKey = DC.GeographyKey)
from DimCustomer DC
----------------------- CTE----























