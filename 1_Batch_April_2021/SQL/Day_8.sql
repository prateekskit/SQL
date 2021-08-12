--- unqiue key constraint 

Create Table tblC
(
   AddressId int identity(100,10) primary key,
   EmployeeNumber int,
   City nvarchar(10)
)

insert into tblC
VALUES(NULL,'Barcelona')

alter table tblC Add constraint unique_constraint unique(employeenumber)
select * from tblC

sp_help tblC
--- IDENTITY PROPERTY

delete from tblC where AddressId  = 120
drop table tblAddress



---- IDENTITY(BASE VALUE,SEED VALUE)
-- 
CREATE TABLE tblAddress
(
ID int primary key IDENTITY(1112,55),
Name varchar(100),
StateCode	varchar(10)
)

--1300 1400
-- 1300

insert into tblAddress
values('Sara','USA')

select * from tblAddress

delete from tblAddress where ID = 1200
truncate table tbladdress


--------------------------
--------Foreign Keys-------

Create table tblDepartment
(
     ID int primary key,
     DepartmentName nvarchar(50),
     Location nvarchar(50),
     DepartmentHead nvarchar(50)
)
Go
select * from tblDepartment
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
select * from tblEmployee
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
select * from tblDepartment
select * from tblEmployee
Insert into tblEmployee values (11, 'Valarie', 'Female', 5500, 4)

sp_help tbldepartment


