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







			