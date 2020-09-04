-- subqueries -- queries inside a query -- 
-- important when you wanted to write some complex calculations

---functions or way to write the queries with help of CASE,IIF,CHOOSE


-- group all employees based on the salary -- > 5000 group 1 and < 2
select * from tblEmployee order by Salary 

select name,CASE 
			WHEN salary > 5000 then 2
			ELSE 1 END as groups
			from tblEmployee order by Salary

select CHOOSE(2,'India','USA','UK')

--IIF Function/Condition 
--IIF(<conditions>,in case of true, in case of false)
select name,
IIF(salary > 5000,2,1) as iffgroup,
 CASE 
			WHEN salary > 5000 then 2
			ELSE 1 END as groups
			from tblEmployee order by Salary


			if a= 1 then 'abc'
			else 'def'


			SELECT NAME,GENDER, CASE 
								WHEN SALARY > 5000 THEN 'A' 
								ELSE 'B' END
								AS 'BandLevel'					
			FROM tblEmployee

			SELECT NAME,GENDER,IIF(salary>5000,'A','B') AS 'BandLelve' from tblEmployee

			use AdventureWorksDW2017


			select FirstName,LastName,
			CASE
				WHEN YearlyIncome>125000 then 'A'
				WHEN YearlyIncome > 50000 and YearlyIncome <= 125000 then 'B'
				else 'C' end as 'category'			
			 from DimCustomer order by YearlyIncome

			 select FirstName,LastName,
			CASE
				WHEN YearlyIncome>125000 then 'A'
				WHEN YearlyIncome > 50000 and YearlyIncome <= 125000 then 'B'
				else 'C' END AS  ,
				
				IIF(YearlyIncome>125000,'A',
						(IIF(YearlyIncome > 50000 and YearlyIncome <= 125000,'B','C' )))
							
			 from DimCustomer order by YearlyIncome


			 select * from DimCustomer

			 use JB_08_2020

			 insert into tblEmployee
			 values(11,'klj','M',2500,1)
			 go

			 select LOWER(name) from tblEmployee
			 

