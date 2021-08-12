--- UPDATE CLAUSE

use JB_2021

select * from dimcustomer_Bakcup

/*
UPDATE <table name>
SET   < col1 = <value>, col2 = <val> ..... coln = <val>
WHERE <condition>
*/

UPDATE dimcustomer_Bakcup
SET GeographyKey = 37,
	FirstName = 'John'
WHERE CustomerKey = 11000



---- ALTER TABLE STATEMENTS





---- DML --- DATA MANIPLATION   --- SELECT, INSERT, UPDATE, DELETE
---- DDL ---- DATA DEFINITION    --- CREATE,ALTER,DROP,TRUNCATE

--- wanted to delete/remove a column from the table
--- 
--- drop an existing column
ALTER TABLE Emp 
DROP column DOB

select * from Emp

--- add a new column in existing table
ALTER TABLE Emp 
ADD AGE int

-- alter an existing column
ALTER TABLE Emp 
ALTER column EmpName varchar(1000)

--------- TRUNCATE 
--- complete data from table 
TRUNCATE TABLE EMP  

DELETE FROM EMP

-- what is the differnce between truncate and delete?

------ WHERE CLAUSE ---------------

select * 
from dimcustomer_Bakcup 
where TotalChildren = 2


-- IN clause helps you to define a list as a filter condition - its akin to  multi select in excel
select * 
from dimcustomer_Bakcup 
where TotalChildren IN (2,3)

-- NOT will always exclude values.
select * 
from dimcustomer_Bakcup 
where TotalChildren NOT IN (2,3)

select * 
from dimcustomer_Bakcup 
where EnglishEducation IN ('High School','Graduate Degree')


--- BETWEEN AND - helps you to filter based on the range of a column data

select * 
from dimcustomer_Bakcup 
WHERE CustomerKey between 11005 and 11015

select * 
from dimcustomer_Bakcup 
WHERE CustomerKey not between 11005 and 11015

select * 
from dimcustomer_Bakcup 
WHERE BirthDate  between '1980-01-01' and '1985-01-01'



--- Comparison Operator
--- greater than 50000
select * 
from dimcustomer_Bakcup
where YearlyIncome > 50000 


select * 
from dimcustomer_Bakcup
where YearlyIncome >= 50000 


select * 
from dimcustomer_Bakcup
where YearlyIncome <= 50000 

select * 
from dimcustomer_Bakcup
where YearlyIncome != 50000 

select * 
from dimcustomer_Bakcup
where YearlyIncome <> 50000



--- ARTHIMETIC OPERATORS

select 1+2
select 1-2
select 1*2
select 1/2



select TotalChildren + NumberChildrenAtHome 
from dimcustomer_Bakcup
 

select Firstname,lastname, FirstName + LastName
from dimcustomer_Bakcup


select LastName + ', ' +FirstName AS  'Full Name'
		,YearlyIncome,EnglishEducation,EnglishOccupation
from dimcustomer_Bakcup

---- LIKE

--- Pattern Matching 
--- LIKE  &  Not Like

--- First Name should always be start with "A"
select * from dimcustomer_Bakcup

select * from dimcustomer_Bakcup where firstname like 'A%'
--- First Name should always be start with "An"
select * from dimcustomer_Bakcup where firstname like 'AN%'
----- First Name should always be start with "A" and ends with "K"
select * from dimcustomer_Bakcup where firstname like 'A%S'
----- First Name should always be ends with "s"
select * from dimcustomer_Bakcup where firstname   like '%S'

----- First Name should not ends with either "K" or "S"
select * from dimcustomer_Bakcup where firstname  not like '%S' AND  firstname not like '%K'

----- First Name should always have "S" at the second position 
select * from dimcustomer_Bakcup where firstname   like '_S%'


----- First Name should always have "S" at the third position 
select * from dimcustomer_Bakcup where firstname   like '__S%'


----- First Name should always have "S" at the first position & "A" at the third position
select * from dimcustomer_Bakcup where firstname   like 'S_A%'

----- First Name should always have "A" at the second position & "N" at the last position
select * from dimcustomer_Bakcup where firstname   like '_A%N'


--- first name should either starts with Y or Z
select * from dimcustomer_Bakcup where firstname   like '[YZ]%'
-- should not ends up with K & N
select * from dimcustomer_Bakcup where firstname  not  like '%[KN]'

-- should start with Either A OR B OR C OR D Or E Or F OR G
select * from dimcustomer_Bakcup where firstname  like '[A-G]%'

-- should NOT start with Either A OR B OR C OR D Or E Or F OR G
select * from dimcustomer_Bakcup where firstname  like '[^A-G]%'

select lastname,firstname,MiddleName
 from dimcustomer_Bakcup where firstname  like 'A%' and lastname like '%A' 



