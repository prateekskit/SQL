use AdventureWorksDW2017

--- Pattern Matching 
--- LIKE  &  Not Like

--- First Name should always be start with "A"
select * from DimEmployee

select * from DimEmployee where firstname like 'A%'
--- First Name should always be start with "An"
select * from DimEmployee where firstname like 'An%'
----- First Name should always be start with "A" and ends with "K"
select * from DimEmployee where firstname like 'A%K'
----- First Name should always be ends with "s"
select * from DimEmployee where firstname   like '%S'

----- First Name should not ends with either "K" or "S"
select * from DimEmployee where firstname  not like '%S' AND  firstname not like '%K'

----- First Name should always have "S" at the second position 
select * from DimEmployee where firstname   like '_S%'


----- First Name should always have "S" at the third position 
select * from DimEmployee where firstname   like '__S%'


----- First Name should always have "S" at the first position & "A" at the third position
select * from DimEmployee where firstname   like 'S_A%'

----- First Name should always have "A" at the second position & "N" at the last position
select * from DimEmployee where firstname   like '_A%N'


--- first name should either starts with Y or Z
select * from DimEmployee where firstname   like '[YZ]%'
-- should not ends up with K & N
select * from DimEmployee where firstname  not  like '%[KN]'

-- should start with Either A OR B OR C OR D Or E Or F OR G
select * from DimEmployee where firstname  like '[A-G]%'

-- should NOT start with Either A OR B OR C OR D Or E Or F OR G
select * from DimEmployee where firstname  like '[^A-G]%'

select lastname,firstname,MiddleName
 from DimEmployee where firstname  like 'A%' and lastname like '%A' 

					



-------  Compare Operators
---- =,>,<,>=,<=,<>
select * from DimEmployee where VacationHours >= 50 order by VacationHours

select * from DimEmployee where VacationHours >= 50 OR SickLeaveHours < 100 order by VacationHours


--- List Operators In , NOT IN

--- RANGE OPERATORS
----  BETWEEN AND 

--- all the employees who has taken leave between 50 to 100 hours 

select * from DimEmployee where VacationHours between 50 and 90 order by VacationHours
select * from DimEmployee where VacationHours not between 50 and 90 order by VacationHours

----- Arthimetic Opertors 
---  

select * from DimEmployee

select firstname,lastname,vacationhours,sickleavehours from DimEmployee

select firstname,lastname,vacationhours,sickleavehours,
		 VacationHours + SickLeaveHours AS 'Total Leave Hours'
 from DimEmployee

 
select firstname,lastname,vacationhours,sickleavehours,
		firstname + ' ' +lastname as 'Full Name',
		 VacationHours + SickLeaveHours AS 'Total Leave Hours'
 from DimEmployee


 
 select firstname,lastname,vacationhours,sickleavehours,
		firstname + ' ' +lastname as 'Full Name',
		 VacationHours + SickLeaveHours AS 'Total Leave Hours'
 from DimEmployee
 WHERE (VacationHours + SickLeaveHours) > 150

 
 select FirstName,LastName from DimEmployee

 select firstname,lastname,VacationHours,SickLeaveHours from DimEmployee