select * 
from DimCustomer
where customerkey  = 11000

--- it gives you the distcint records for the selected column or column combinations
select distinct englisheducation from DimCustomer

-- in clause takes input as list of elements/values and filter on
-- you can also apply NOT IN to negate the conditions
select *
from DimCustomer
where EnglishEducation IN ('Bachelors','Graduate Degree')

select *
from DimCustomer
where EnglishEducation NOT IN ('Bachelors','Graduate Degree')

--- comparison

select * from DimCustomer where YearlyIncome > 50000
select * from DimCustomer where YearlyIncome <= 50000

-- AND & OR conditions
--- all the rows, where marital status is SINGLE and GENDER is FEMALE
select * from DimCustomer
WHERE MaritalStatus = 'S' AND GENDER = 'F'

--- ALL THE ROWS, where marital  status is single or gender is female

select * from DimCustomer
where MaritalStatus = 'S' OR GENDER = 'F'

select * from DimCustomer
where MaritalStatus = 'Y' OR GENDER = 'Fem'

---- between and and
select * from DimCustomer
where CustomerKey between 11111 and 11122

--- LIKE OPERATORS
-- 
select * from DimCustomer where FirstName like 'z%Y'
select * from DimCustomer where FirstName like '%ay%'
select * from DimCustomer where FirstName like '%A'






