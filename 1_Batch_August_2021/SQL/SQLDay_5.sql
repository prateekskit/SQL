use JB_2021

----- First Name should not ends with either "K" or "S"
select * from dimcustomer_Bakcup where firstname  not like '%S' AND  firstname not like '%K'

-- I want all  customer whose Yearly Income is greater than 100000 and educationsDegree s BAchleors
select * 
from dimcustomer_Bakcup
where YearlyIncome > 100000 AND EnglishEducation = 'Bachelors'
/*
	AND					OR	
A	B	OP			A	B	OP
1	1	1			1	1	1
1	0	0			1	0	1
0	1	0			0	1	1
0	0	0			0	0	0
*/


select * 
from dimcustomer_Bakcup
where YearlyIncome > 1000000 AND EnglishEducation = 'Bachelors'


select * 
from dimcustomer_Bakcup
where YearlyIncome > 100000 AND EnglishEducation = 'Bachelorss'


select * 
from dimcustomer_Bakcup
where YearlyIncome > 100000 AND EnglishEducation = 'Bachelors' AND EnglishOccupation = 'Professional'


select * 
from dimcustomer_Bakcup
where YearlyIncome > 100000 AND EnglishEducation = 'Bachelors'


select * 
from dimcustomer_Bakcup
where YearlyIncome > 100000 OR EnglishEducation = 'Bachelors'


select * 
from dimcustomer_Bakcup
where YearlyIncome > 1000000 OR EnglishEducation = 'Bachelorss'



select * 
from dimcustomer_Bakcup
where YearlyIncome > 100000 OR (EnglishEducation = 'Bachelors' AND TotalChildren = 3)


-------------------------------------------------------------------------------------

-- DISTINCT --- unique values
--- get all the different english educations from my system
select DISTINCT EnglishEducation from dimcustomer_Bakcup

select DISTINCT YearlyIncome from dimcustomer_Bakcup

select DISTINCT EnglishEducation from dimcustomer_Bakcup
select DISTINCT EnglishOccupation from dimcustomer_Bakcup

select  EnglishEducation,EnglishOccupation
from dimcustomer_Bakcup
order by EnglishEducation


select DISTINCT EnglishEducation,EnglishOccupation
from dimcustomer_Bakcup
order by EnglishEducation

---order by---













