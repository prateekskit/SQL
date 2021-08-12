--String Functions 


select LEN('Janbask') --- length of particular string

select LEFT('Janbask',4)   ---- specified characters from the left hand side of the string

select RIGHT('Janbask',4)   ---- specified characters from the left hand side of the string

--JOHN
-- LTRIM, RTRIM 
SELECT ('      JOHN                    ')
SELECT RTRIM(LTRIM('      JOHN                    '))

use AdventureWorksDW2017
select CHARINDEX(' ','I am in the Room',3)

select EmailAddress,LEFT(emailaddress,CHARINDEX('@',emailaddress,1)-1) from dimcustomer

select substring('This wall is GREEN',5,10)

select REPLACE('This is RED','i','******')

select REPLACE(customeralternatekey,'AW','***') from DimCustomer


---- CAST functions

select cast(1 as varchar) + cast(2 as varchar)
select 'abc'
select cast('abc' as int)
select 1 + 'abc'
select 'abc' + 'def'
select CAST(1 as varchar) + '_abc'
select CAST(CustomerKey as varchar) + LastName from DimCustomer


select * from DimCustomer where LEN(lastname) > 7
-----

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

select getdate()

INSERT INTO tblDateTime VALUES (GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE())
select * from tblDateTime


---  date time functions
-- 0 false , 1 - true
select ISDATE(NULL)
select ISDATE('2020-03-03')
select ISDATE('2020-03-31')
select ISDATE('2020-03-32')
select ISDATE('2020-02-29')
select ISDATE('2021-02-29')

--- DAY,MONTH, YEAR

select DAY(getdate())
select MONTH(getdate())
select YEAR(getdate())

select * from DimCustomer
select * from DimCustomer where year(birthdate) > 1985

select datepart(day,getdate())
select datepart(MONTH,getdate())
select datepart(YEAR,getdate())

select datepart(Q,getdate())
select datepart(WEEKDAY,getdate())
select datepart(WEEK,getdate())
select datepart(M,getdate())

select datepart(M,'2020-03-03')

select year(birthdate) from DimCustomer where year(birthdate) > 1985


select DAY(getdate()) + 'abc'
select datename(day,getdate()) + 'abc'