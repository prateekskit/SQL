
SELECT E.Name,D.DepartmentName,D.Location,E.DepartmentId,E.Gender,E.Salary 
FROM tblEmployee E LEFT OUTER JOIN tblDepartment D ON E.DepartmentId = D.ID
WHERE D.DepartmentName = 'IT' AND E.Gender = 'Male' and E.Salary > 5000

-- sub queries 
select * from tblEmployee

SELECT E.Name,D.DepartmentName,D.Location,E.DepartmentId,E.Gender,E.Salary 
FROM tblEmployee E 

LEFT OUTER JOIN tblDepartment D ON E.DepartmentId = D.ID

WHERE D.DepartmentName = (SELECT DepartmentName from tblDepartment where DepartmentName = 'IT')
AND E.Gender = 'Male' and E.Salary > 5000

/* Problem :  update the department id for employees which does not have any department tagged, and it should be only that department
which is not assigned to any other employee) */

select * from tblEmployee WHERE DepartmentId IN 
											(SELECT distinct id from tblDepartment where DepartmentName = 'IT')

select * from tblEmployee
update tblEmployee
set DepartmentId = NULL
where DepartmentId = 4

--- Update department of employess which is not assigned to any department and department should be one which is
-- not having any employees


select * from tblDepartment

UPDATE tblEmployee
set DepartmentId = (select distinct ID from tblDepartment where ID 
						not in (select DepartmentId from tblEmployee where DepartmentId is not null))
where DepartmentId is null	
					
select * from tblEmployee 

select distinct ID from tblDepartment where ID 
						not in (select DepartmentId from tblEmployee where DepartmentId is not null)

select * from tblEmployee where DepartmentId is null


select * from tblEmployee

select DepartmentName, 
		(select COUNT(GENDER) from tblEmployee) as SubSalary from tblDepartment 


--- purpose 
--- outcome 
--- date 
--- createdby 
SELECT E.* FROM 
			(select * from tblEmployee where salary < 5000) as E



select * from tblPhysicalAddress
select * from tblMailingAddress



update M
set M.HouseNumber = ISNULL(P.HouseNumber,0)
from tblPhysicalAddress M inner join tblPhysicalAddress P on M.AddressId = P.AddressId


CREATE TABLE Table1
(
Id INT,
FruitName Varchar( 100)
);

CREATE TABLE Table2
(
Id INT,
FruitName Varchar( 100)
);

Insert into Table1 Values ( 6,'Litchi' );
Insert into Table2 Values  (6, 'Orange');

SELECT * FROM Table1 ;
SELECT * FROM Table2 ;


SELECT *
FROM   Table1 T1 Inner Join Table2 T2
ON     T1.Id = T2.Id;

UPDATE  T2
SET    T2.FruitName = T1.FruitName
FROM   Table2 as T2 INNER JOIN Table1 as T1
ON     T1.Id = T2.Id;





