Use jb_8

Create table Employee  
(  
    EmpID int,  
    EmpName varchar(30),  
    EmpSalary int  
) 

SELECT * FROM Employee

ALTER TABLE Employee ADD Gender varchar(100) 

UPDATE Employee
set Gender = 'FeMale' 
where EmpiD not between 1 and 5


INSERT INTO Employee
select ID,Name,Salary from janbask_6.dbo.tblEmployee_bkp

select Gender from Employee

SELECT * FROM ABC

SELECT Gender, SUM(EmpSalary) 
FROM Employee   
GROUP BY Gender 
HAVING SUM(EmpSalary) > 17000

-- Statement with GroupBY

select EmpName from Employee  
GROUP BY EmpName  
HAVING SUM(EmpSalary) <30000  




--- Having With Group by & Where Clause

select EmpName, SUM(EmpSalary) as EmpSalary from Employee  
WHERE EmpName='Smith' OR EmpName='Rahul' or EmpName ='Meths'  
GROUP BY EmpName  
HAVING SUM(EmpSalary) < 30000  


--- Having Clause with 

select EmpName, SUM(EmpSalary) as EmpSalary from Employee  
GROUP BY EmpName  
HAVING SUM(EmpSalary) < 30000  
order by EmpName desc 

--Having clause without Group By
-- select * from Employee
select  count(*) from Employee  
--WHERE EmpName='Smith' OR EmpName='Rahul' or EmpName ='Meths'  
HAVING SUM(EmpSalary) < 5000

/* If you use HAVING clause without group by, it can also refer any column but the index will not be used as opposed to 
WHERE clause. For example, the following have the same result set, however "where" will use the id index and having will do a table scan*/





