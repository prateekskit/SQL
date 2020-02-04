---- Views 

-- system views
SELECT * FROM [INFORMATION_SCHEMA].[TABLES]
select * from [INFORMATION_SCHEMA].[ROUTINES]
-- user defined views


CREATE TABLE tblEmp
(
  Id int Primary Key,
  Name nvarchar(30),
  Salary int,
  Gender nvarchar(10),
  DepartmentId int
)

CREATE TABLE tblDept
(
 DeptId int Primary Key,
 DeptName nvarchar(20)
)

select * from tblEmp
select * from tblDept

Insert into tblDept values (1,'IT')
Insert into tblDept values (2,'Payroll')
Insert into tblDept values (3,'HR')
Insert into tblDept values (4,'Admin')

Insert into tblEmp values (1,'John', 5000, 'Male', 3)
Insert into tblEmp values (2,'Mike', 3400, 'Male', 2)
Insert into tblEmp values (3,'Pam', 6000, 'Female', 1)
Insert into tblEmp values (4,'Todd', 4800, 'Male', 4)
Insert into tblEmp values (5,'Sara', 3200, 'Female', 1)
Insert into tblEmp values (6,'Ben', 4800, 'Male', 3)

---


select * from vWEmployeesByDepartment

CREATE VIEW vWEmployeesByDepartment
AS
Select Id, Name, Salary, Gender, DeptName
from tblEmp
join tblDept
on tblEmp.DepartmentId = tblDept.DeptId

--- security - row level security & column level security


-- column level security
create view vWEmployeesName
AS
Select Id, Name, Gender, DeptName
from tblEmp
join tblDept
on tblEmp.DepartmentId = tblDept.DeptId

select * from vWEmployeesName



select * from vWEmployeesByDepartment where gender = 'Male'
select * from vWEmployeesByDepartmentHR

--
CREATE VIEW vWEmployeesByDepartmentHR
AS
Select Id, Name, Salary, Gender, DeptName
from tblEmp
join tblDept
on tblEmp.DepartmentId = tblDept.DeptId
WHERE DeptName = 'HR'


select * from vWEmployeesByDepartmentHR where id = 1


CREATE VIEW vWEmployeesByDepartmentIT
AS
Select Id, Name, Gender, DeptName
from tblEmp
join tblDept
on tblEmp.DepartmentId = tblDept.DeptId
WHERE DeptName = 'IT'

select * from vWEmployeesByDepartmentIT


--updatable Views

ALTER view vWEmployeesUpdDataForHR
as
Select Id, Name, Gender
from tblEmployee

select * from vWEmployeesUpdDataForHR

select * from tblEmployee
update vWEmployeesUpdDataForHR
set salary = 10000
--where id = 1

select * from vWEmployeesDataExceptSalary

select * from tblEmployee

update vWEmployeesDataExceptSalary
set name = 'Jack'
where id = 1


--- with check options

CREATE TABLE dbo.tb1(Col1 int);
CREATE TABLE dbo.tb2(Col2 int);
INSERT INTO dbo.tb1 VALUES(1);
INSERT INTO dbo.tb2 VALUES(1);
GO

CREATE VIEW dbo.ViewWithCheckOption
AS
SELECT tb1.Col1, tb2.Col2
FROM dbo.tb1
JOIN dbo.tb2 ON tb1.Col1 = tb2.Col2
WITH CHECK OPTION;
GO

CREATE VIEW dbo.ViewWithoutCheckOption
AS
SELECT tb1.Col1, tb2.Col2
FROM dbo.tb1
JOIN dbo.tb2 ON tb1.Col1 = tb2.Col2;
GO

SELECT Col1, Col1 FROM dbo.ViewWithoutCheckOption; --returns 1 row
INSERT INTO dbo.ViewWithoutCheckOption(Col1) VALUES(2); --succeeds
SELECT Col1, Col1 FROM dbo.ViewWithoutCheckOption; --still returns 1 row

SELECT Col1, Col1 FROM dbo.ViewWithCheckOption; --returns 1 row
INSERT INTO dbo.ViewWithCheckOption(Col1) VALUES(2); -- fails with error



create table vendordata
(id int
,name varchar(100)
,city varchar(100)
,state varchar(100)
)

insert into vendordata
values(1,'jackson','bristol','uk')

select * from vendordata

CREATE VIEW vendors
AS
select * from vendordata where id = 1


CREATE VIEW vw_vendorsdata
AS
select * from vendordata where id = 1

select * from vendordata
select * from vw_vendorsdata

insert into vw_vendorsdata values(3,'netmeds','st.joseph','USA')


ALTER VIEW vw_vendorsdata
AS
select * from vendordata where name = 'bikl'
with check option

insert into vw_vendorsdata values(1,'netmeds','st.joseph','USA')

select * from vendordata
select * from vw_vendorsdata


--- schema 

sp_helptext vw_vendorsdata