use AdventureWorksDW2017
-- functions 
-- System Functions
-- Aggregate Functions

-- MAX,MIN,AVG,SUM,COUNT
select * from DimCustomer
select count(*) from DimCustomer

--- it may or may not return a value
  --

--  Replace NULL Functions
-- one way to do it...
use AdventureWorksDW2017
select * from DimCustomer where MiddleName is null

select firstname, middlename,
case
					 when middlename is null then 'xxxxx' 
						else middlename end as middlenamenew, 
						lastname from DimCustomer

select firstname,middlename,ISNULL(MiddleName,'xxxxx') as middlenamenew,
lastname from DimCustomer
select ISNULL(


Select ISNULL(NULL,'Blank')
select ISNULL('It is a blank value',NULL)
select ISNULL(NULL,'Balnk')

select * from DimCustomer

select firstName,ISNULL(middleName,'No Middle NAme'),LastName from DimCustomer
select firstName+' '+ ISNULL(middleName,'') +' '+ LastName, * from DimCustomer


select middlename,title, coalesce(middlename,title,'XX')
 from DimCustomer where title is not null

select firstname,coalesce(middleName,'XX'),LastName from dimcustomer
--select firstname,coalesce(   from dimcustomer


/* String Functions    */
select * from DimCustomer

dimcustomer
select upper(emailaddress) from dimcustomer
select 'HELLo'
select LEN(RTRIM('HELLO                             '))
select RTRIM('HELLO                             ')
select ('HELLO                             ')   -- show output in notepad for more undestanding

select ('                                      jasnbask')
select LTRIM('                                      jasnbask')


select LEN('HELLO TEAM')


select firstname, LEN(firstname) from dimcustomer
select firstname, LEN(EmailAddress),EmailAddress from dimcustomer  --- very important when doing calculation over the length of string
select firstname,upper(REVERSE(firstname)) from DimCustomer

select LEFT('janbask',6)
select RIGHT('janbask',4)

select * from DimCustomer

select EmailAddress from DimCustomer
select CHARINDEX('a','abcdefha')
select emailaddress,CHARINDEX('@',emailaddress) from DimCustomer
select charindex('@','jessica29@adventure-works.com')

select emailaddress,LEFT(emailaddress,CHARINDEX('@',emailaddress) - 1) from DimCustomer
--jon24@adventure-works.com  
--123456

select SUBSTRING('janbask',2,4)
select SUBSTRING(customerAlternatekey,3,5) from DimCustomer
select SUBSTRING(




select * from DimCustomer where LEN(firstname) > 5

---- we are trying to get the domain names of each  emailID
---- substring ( expressions, startposition, length)
-- emailAddress 
--- index of '@' + 1
--- len(complete email) - 
--- jon24@gmail.com     ---------     len(email) = 15 
----- index (@) =--- 6 
----- 15 -6 = 9
select EmailAddress from DimCustomer


select emailaddress, substring(emailaddress,
									CHARINDEX('@',emailaddress,1)+1, 
												(len(emailaddress)- CHARINDEX('@',emailaddress,1))) as substrings
										   from DimCustomer where emailaddress like '%gmail%'

select '' substring('prateek@gmail.com',
									CHARINDEX('@','prateek@gmail.com',1) +1, 
							(len('prateek@gmail.com')- CHARINDEX('@','prateek@gmail.com',1))) as substring

							select CHARINDEX('@','prateek@gmail.com',1) --8
							select len('prateek@gmail.com')    -- 17

select emailaddress, substring(emailaddress,
			CHARINDEX('@',emailaddress,1) + 1, 
(len(emailaddress)- CHARINDEX('@',emailaddress,1) - CHARINDEX('.', REVERSE(EmailAddress) ))) 
as substrings   from DimCustomer 

select substring('prateek@gmail.com',9,9)

select * from DimCustomer
update DimCustomer
set EmailAddress = 'prateek@gmail.com'
where CustomerKey = 11000


										   
										   
CHARINDEX('@',emailaddress,1) from DimCustomer

/* DATE-TIME FUNCTIONS */

use db_2
CREATE TABLE [tblDateTime]
(
 [c_time] [time](7) NULL,
 [c_date] [date] NULL,
 [c_smalldatetime] [smalldatetime] NULL,
 [c_datetime] [datetime] NULL,
 [c_datetime2] [datetime2](7) NULL,
 [c_datetimeoffset] [datetimeoffset](7) NULL
)

select * from tblDateTime

select getdate()

INSERT INTO tblDateTime VALUES (GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE())
select * from tblDateTime

--ISDATE --- 

SELECT ISDATE('pragim') -- whether valid date or not  0 - false/invalid
SELECT ISDATE('2014-04-04') -- whether valid date or not 1- true/valid
SELECT ISDATE('2014-13-13') -- whether valid date or not 1- true/valid

select DAY(getdate()),getdate()   --- provides you the current date  
select month(getdate()),getdate() -- provide you current month
select year(getdate()),getdate()


select * from DimCustomer
use AdventureWorksDW2017
select YEAR(birthdate),birthdate from DimCustomer where year(birthdate) <= 1980

select datepart(day,'2020-08-30')
select datepart(dy,getdate()),getdate()  -- specicifc date part
select datepart(,getdate())  -- specicifc date part, quarter of date

select datename(weekday,getdate())
select datename(MONTH,getdate())


select firstname,birthdate,day(birthdate) as day,Month(birthdate) as month, 
year(birthdate) as year,datepart(WEEKDAY,birthdate) as wday,
						datename(weekday,birthdate) as weekday	 from dimcustomer
--DATEADD and dATEDIFF
-- calculate age and after 10 years what would be there age


select datediff(YEAR,getdate(),'2009-07-01')   --- date difference 
select datediff(WEEK,getdate(),'2030-01-01')

select dateadd(day,90,getdate())
select dateadd(year,-180,getdate())


select firstname,lastname,birthdate from DimCustomer

--- calcualte AGE , and AGE after 10 years
select firstname,lastname,birthdate,
			---- AGE as of today
			datediff(year,birthdate,getdate()) as age,
			---- what would be the date after 10 years.
			dateadd(year,10,getdate()) as tenyrsnw,
			----- what would be the age after 10 years.
    datediff(year,birthdate,dateadd(year,10,getdate())) as tenyrsafter_AGE 
	from dimcustomer order by age desc


/*Aggregate Functions - AVG,MIN,MAX,SUM,COUNT,row_num   --- give them as assignment */
use db_2


select * from tblemp


use JB_08_2020
select * from tblEmployee order by salary desc

UPDATE tblEmployee set salary = 4500 where id = 1


--ROW_NUMBER , RANK, DENSE_RANK

select *,
	ROW_NUMBER() OVER(order by salary desc) as 'row number',
	RANK() OVER(order by salary desc) as 'rank_1',
	DENSE_RANK() OVER(order by salary desc) as 'dense_rank_2'	
	from tblEmployee

	delete from tblEmployee where id = 11
	select * from tblEmployee
select *, ROW_NUMBER() over (partition by gender order by salary desc) as rownumber 
,rank() over(partition by gender order by salary desc) as rank_original
,DENSE_RANK() over (partition by gender order by salary desc) as rank_dense
from tblemployee

select * from DimCustomer


select id,gender,count(*) from tblemp group by gender,id

--ROW_NUMBER()---

select A.* from 
(
select Name,Gender,Salary,ROW_NUMBER() over ( ORDER BY SALARY desc) as rankk
,rank() over(order by salary desc) as rank_original
,DENSE_RANK() over (order by salary desc) as rank_dense
--,ROW_NUMBER() over (Partition by Gender ORDER BY SALARY desc) as rankk_new
--,rank() over(Partition by Gender  order by salary desc) as rank_original_new
--,DENSE_RANK() over (Partition by Gender  order by salary desc) as rank_dense_new
 from tblemployee) A where A.rank_dense_new = 3 and A.gender = 'Female'


 select Name,Gender,Salary,ROW_NUMBER() over ( ORDER BY SALARY desc) as rankk
,rank() over(order by salary desc) as rank_original
,DENSE_RANK() over (order by salary desc) as rank_dense
--,ROW_NUMBER() over (Partition by Gender ORDER BY SALARY desc) as rankk_new
--,rank() over(Partition by Gender  order by salary desc) as rank_original_new
--,DENSE_RANK() over (Partition by Gender  order by salary desc) as rank_dense_new
 from tblemployee


 update tblemployee
 set salary = 7000
 where name = 'Valarie'

 select * from tblemployee

select * from tblemployee
update tblemployee
set salary = 7000
where Name = 'James'

use AdventureWorksDW2017

select * from FactFinance
select * from DimOrganization
select O.OrganizationName,F.OrganizationKey,avg(amount),
ROW_NUMBER() over(partition by avg(amount) order by avg(amount) desc)  as ranknew from FactFinance F inner join DimOrganization O on F.OrganizationKey = O.OrganizationKey
group by F.OrganizationKey,O.OrganizationName


-- dense_rank, rank, lead, lag

select A.* from

 (select firstname,MaritalStatus,Gender,EnglishEducation,YearlyIncome,
			 row_number() over( order by YearlyIncome desc) as number
			,rank() over( order by YearlyIncome desc) as rankk
			,dense_rank() over(partition by gender order by YearlyIncome desc,gender desc) as ran_dense 
  from DimCustomer ) A where A.ran_dense = 1

  select * from #temp where ran_dense = 3






