use AdventureWorksDW2017

select * from DimEmployee


-- Range Operator always consider the boundry values


select * from DimEmployee WHERE Employeekey between 11 and 20

-- If you wanted to exclude the items, please use NOT operator as in
-- always look how boundary values are behaving

select * from DimEmployee WHERE Employeekey not between 10 and 20


-- In Operator

select * from DimEmployee where EmployeeKey in (1,10,20,40)

select * from DimEmployee where firstname not in ('Guy','Ruth')



--- Like Operator
-- starting with spacific character or string
select firstname from DimEmployee order by firstname

select * from DimEmployee where FirstName like 'z%'
-- ending with spacific character or string
select * from DimEmployee where FirstName like '%er'
-- in between character or string
select * from DimEmployee where FirstName like '%ma%'
select * from DimEmployee where FirstName like 't%a%'



--starting with a single charcter
select * from DimEmployee where FirstName like '_a%'   -- starting with one charcter
select * from DimEmployee where FirstName like '__Y%'  -- starting with two character

--The [list of characters] wildcard example 
select * from DimEmployee where firstname like '[YZ]%' -- starts with A or C
select * from DimEmployee where firstname like '%[YZ]' -- ends with A or C

--The [character-character] wildcard example
select * from DimEmployee where firstname like '%[A-D]' -- ends with A to D any character
select * from DimEmployee where firstname like '[A-D]%' -- starts with A to D any character
select * from DimEmployee where firstname like '[BZ]%' -- starts with B or Z any character

-- specificy character which is not required
select * from DimEmployee where firstname like '%[^A-T]' -- not ends with A to T any character
select * from DimEmployee where firstname like '[^A-Y]%' -- not starts with A to Y any character
select * from DimEmployee where firstname like '[^BZ]%' -- not starts with B or Z any character
-- Utlimately you can have the not like operator. but not good for performance to fetch the result sets
select * from DimEmployee where FirstName not like '_a%'   -- starting with one charcter 