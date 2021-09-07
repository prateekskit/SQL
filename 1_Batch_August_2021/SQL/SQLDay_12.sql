----- STRING FUNCTIONS

use AdventureWorksDW2017

select firstname,middlename,title,suffix,lastname
	 ,Firstname + ' '+  COALESCE(MiddleName,title,suffix,'xx') 	 + ' ' + Lastname 
	 from DimCustomer 
	 

select firstname,middlename,title,suffix,lastname,
	 Firstname + ' '+  COALESCE(MiddleName,title,suffix,'xx')
	 + ' ' + Lastname from DimCustomer 
	 where MiddleName is not null and title is not null --and Suffix is not null



select firstname,middlename,title,suffix,lastname,
	 Firstname + ' '+  COALESCE(MiddleName,title,suffix,'xx')
	 + ' ' + Lastname from DimCustomer 
	 where MiddleName is not null and title is not null --and Suffix is not null

	 select firstname,UPPER(firstname) from DimCustomer
	 select firstname,LOWER(firstname) from DimCustomer

	 --String Functions 


select LEN('Janbask') --- length of particular string

select LEFT('Janbask',4)   ---- specified characters from the left hand side of the string

select RIGHT('Janbask',4)   ---- specified characters from the left hand side of the string

--JOHN
-- LTRIM, RTRIM 



SELECT ('      JOHN                    ')
SELECT RTRIM(LTRIM('      JOHN                    '))

use AdventureWorksDW2017


select CHARINDEX(' ','I am in the Room')

select CHARINDEX(' ','I am in the Room',3)


select CHARINDEX('#','I#am#in#the#Room',6)

select CHARINDEX('.','M.Sharma Jr.',3)

I#am#in#the#Room

am#in#the#Room

in#the#Room

select EmailAddress from DimCustomer

select EmailAddress,CHARINDEX('@',emailaddress,1),
		LEFT(emailaddress,CHARINDEX('@',emailaddress,1)-1)
 from dimcustomer



select substring('My Invoice number is #1234567 for the item container',
						CHARINDEX('#','My Invoice number is #1234567 for the item container')+1,7)

select REPLACE('This is RED','i','******')

select customeralternatekey,
		REPLACE(customeralternatekey,'AW','#') 
from DimCustomer


---- CAST functions

select 1 +2
select 'a' + 'b'
select cast(1 as varchar) + 'ab'
select 1 + 'ab'

select cast(1 as varchar) + cast(2 as varchar)
select 'abc'
select cast('abc' as int)
select 1 + 'abc'
select 'abc' + 'def'
select CAST(1 as varchar) + '_abc'
select CustomerKey + LastName from DimCustomer
select CAST(CustomerKey as varchar)+ ' ' + LastName from DimCustomer


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

INSERT INTO tblDateTime 
VALUES (GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE())

select * from tblDateTime
