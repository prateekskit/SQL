use AdventureWorksDW2017


--- SUM,MAX,MIN,AVG,COUNT   --- Aggregation Functions.

select * from DimCustomer




select EnglishEducation,EnglishOccupation,AVG(yearlyincome) as sumofYearlyIncome   --- final distinct,TOP
from DimCustomer				------------   1st statement
WHERE EnglishOccupation IN ('Professional','Management') ---- 2 nd Statement 
group by EnglishEducation,EnglishOccupation				---- 3rd Statement 
Having AVG(yearlyincome) > 75000						----- 4th stemement 
order by EnglishEducation,EnglishOccupation				----5th state






select distinct EnglishEducation,EnglishOccupation from DimCustomer
order by EnglishEducation desc,EnglishOccupation desc



select *, (SickLeaveHours + VacationHours) as 'total leave hours' from DimEmployee where baserate < 20.00 and 
(VacationHours + SickLeaveHours) > 50

---- know the total leave hours based on the gender
select gender,AVG(VacationHours + SickLeaveHours)
from DimEmployee
where baserate < 20.00
group  by gender 
having AVG(VacationHours + SickLeaveHours) > 100

---------------------------------------------------------
---------------------------------------------------------


-----constraints -----
--- restrict the entry of records in the table.

--- NULL CONSTRAINT 

create table tblemp
(
id int ,
name varchar(100) not null
)

sp_help tblemp
select * from tblemp
insert into tblemp(id,name)
values(1,'JAcob')

delete from tblemp
drop table tblemp
select * into dimemployee_bkp from DimEmployee where EmployeeKey IN (3,4,5)

select * from dimemployee_bkp where MiddleName = ''

select * from dimemployee_bkp where MiddleName is  NULL

select * from dimemployee_bkp where MiddleName = 'NULL'

update DimEmployee
set MiddleName = ''
where EmployeeKey = 3


