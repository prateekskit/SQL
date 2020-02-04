Create table tblDepartment
(
     ID int primary key,
     DepartmentName nvarchar(50),
     Location nvarchar(50),
     DepartmentHead nvarchar(50)
)
Go

Insert into tblDepartment values (1, 'IT', 'London', 'Rick')
Insert into tblDepartment values (2, 'Payroll', 'Delhi', 'Ron')

 
Insert into tblDepartment values (3, 'HR', 'New York', 'Christie')
Insert into tblDepartment values (4, 'Other Department', 'Sydney', 'Cindrella')
Go

Create table tblEmployee
(
     ID int primary key,
     Name nvarchar(50),
     Gender nvarchar(50),
     Salary int,
     DepartmentId int foreign key references tblDepartment(Id)
)
Go

Insert into tblEmployee values (1, 'Tom', 'Male', 4000, 1)
Insert into tblEmployee values (2, 'Pam', 'Female', 3000, 3)
Insert into tblEmployee values (3, 'John', 'Male', 3500, 1)
Insert into tblEmployee values (4, 'Sam', 'Male', 4500, 2)
Insert into tblEmployee values (5, 'Todd', 'Male', 2800, 2)
Insert into tblEmployee values (6, 'Ben', 'Male', 7000, 1)
Insert into tblEmployee values (7, 'Sara', 'Female', 4800, 3)
Insert into tblEmployee values (8, 'Valarie', 'Female', 5500, 1)
Insert into tblEmployee values (9, 'James', 'Male', 6500, NULL)
Insert into tblEmployee values (10, 'Russell', 'Male', 8800, NULL)
Go


-- CROSS JOIN -- CARTESIAN PRODUCT

select * from tblDepartment  -- 10
select * from tblEmployee  -- 4

SELECT Name, Gender, Salary, DepartmentName
FROM tblEmployee
CROSS JOIN tblDepartment 

--INNER JOIN

SELECT E.Name,D.DepartmentName,D.Location FROM tblEmployee E INNER JOIN tblDepartment D ON E.DepartmentId = D.ID

--LEFT OUTER 

SELECT E.Name,D.DepartmentName,D.Location FROM tblEmployee E LEFT OUTER JOIN tblDepartment D ON E.DepartmentId = D.ID

SELECT E.Name,D.DepartmentName,D.Location FROM tblDepartment D  LEFT OUTER JOIN tblEmployee E ON E.DepartmentId = D.ID


--RIGHT OUTER

SELECT E.Name,D.DepartmentName,D.Location FROM tblDepartment D  RIGHT OUTER JOIN  tblEmployee E ON E.DepartmentId = D.ID
-- FULL JOIN

SELECT E.Name,E.DepartmentId,D.ID,D.DepartmentName,D.Location 
FROM tblDepartment D  FULL OUTER JOIN  tblEmployee E ON E.DepartmentId = D.ID

-- SELF JOIN


create table relation
(
employeeID int,
name varchar(100),
managerid int
)

select * from relation
insert into relation
values(4,'Den',1)

select * from relation

Select E.Name as Employee, M.Name as Manager
from relation E
left Join relation M
On E.ManagerId = M.EmployeeId


select * from tblEmployee
update tblEmployee
set DepartmentId = NULL
where DepartmentId = 4

UPDATE tblEmployee
set DepartmentId = (select ID from tblDepartment where ID 
						not in (select DepartmentId from tblEmployee where DepartmentId is not null))
where DepartmentId is null

/* Problem :  update the department id for employees which does not have any department tagged, and it should be only that department
which is not assigned to any other employee) */


select * from tblEmployee

update tblEmployee
set DepartmentId = (select d.ID  from tblDepartment D left outer join tblEmployee E on d.id = e.DepartmentId where e.DepartmentId is null )
where DepartmentId is null

select d.ID  from tblDepartment D left outer join tblEmployee E on d.id = e.DepartmentId where e.DepartmentId is null
select * from tblEmployee
 update tblEmployee E
 from tblDepartment D right outer join tblDepartment d on d.id = e.DepartmentId
 set E.DepartmentId = select D.id
 from tblEmployee e  right outer join tblDepartment d on d.id = e.DepartmentId
 where e.DepartmentId is null 

select * from tblEmployee E left outer join tbldepartment D on (D.id <> ISNULL(e.DepartmentId,0))
where D.id <> ISNULL(e.DepartmentId,0)

select * from tblDepartment D  left outer join tblEmployee E on d.id = e.DepartmentId
 where e.DepartmentId is null 

 update tblEmployee
 set DepartmentId = null where DepartmentId = 4

 select * from tblEmployee
 select * from tblDepartment

