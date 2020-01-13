----- Constraints-----

-- What is NULL


select * from Employee

INSERT INTO Employee(EmpID,EmpName,EmpSalary)
values(1,'John','')


INSERT INTO Employee(EmpID,EmpName,Gender)
values(1,'John','')

select * from Employee where gender = ''

Create Table tblMailingAddress
(
   AddressId int NOT NULL,
   EmployeeNumber int,
   HouseNumber nvarchar(50),
   StreetAddress nvarchar(50),
   City nvarchar(10),
   PostalCode nvarchar(50)
)

select * from tblMailingAddress

insert into tblMailingAddress(City,PostalCode)
values('berlin',201302)




-- NULL


-- DEFAULT
-- Check 

-- Unique
-- Primary Key
-- Foreign Key Constraint


select * from tblMailingAddress

insert into tblMailingAddress(AddressId,City,Postalcode,country,AGE)
values(10,'berlin',123456,'France',130)

sp_help tblMailingAddress

UPDATE tblMailingAddress
set country = 'USA'

ALTER TABLE tblMailingAddress add country varchar(100)

ALTER TABLE tblMailingAddress ADD constraint df_tblMailing_country DEFAULT 'USA' for country

ALTER TABLE tblMailingAddress alter column city varchar(100) not null

alter table tblMailingAddress add gender char(1) 

ALTER TABLE tblMailingAddress ADD constraint df_defaultvalue_gender DEFAULT 'M' FOR gender

alter table tblMailingAddress add AGE int 

ALTER TABLE tblMailingAddress ADD constraint ck_check_age CHECK (AGE > 0 and AGE <125)

update tblMailingAddress
set age = 25


--- Primary key will have unique records.
-- Primary key can not contain NULL values. 

use jb_8

Create Table tblC
(
   EmployeeID int primary key,
   EmployeeName varchar(100),
   City nvarchar(10)
)

drop table tblC
sp_help tblC


insert into tblC
values(1104,'Jack','oslo')

update tblC
set employeeID = NULL
where EmployeeID = 1103

select * from tblC
delete from tblC where employeeID = 1103

alter table tblC Add constraint unique_constraint unique(EmployeeName)

insert into tblC(employeeID,city)
values(1107,'oslo')

--- Primary key does not allow the NULL values & unique key allows NULL. and UK allows only one null value in a particular table.
-- PK invokes Clustered index while UK invokes non-clustered index.


create table gender
(
id int identity(1,1) primary key,
value char(10)
) 
select * from gender
insert into gender 
values('none')


Create Table tblD
(
   AddressId int identity(100,10) NOT NULL primary key,
   EmployeeNumber int,
   City nvarchar(10),
   gndr int,
   constraint fk_foreignkey foreign key (gndr) references  gender(id)
)

insert into tblD
values(1102,'oslo',4)

select * from tblD



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
     EmpID int primary key,
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

select * from tblEmployee
select * from tblDepartment

update tblEmployee
set DepartmentId = 4
where EmpID = 9


--identity (base   -- from where you wanted to start
	--		seed ( increment values) )


create table transaction_new
(
tran_id int identity(100,10) primary key,
type_of_tran varchar(100),
amount int
)

select * from transaction_new
drop table transaction_new
insert into transaction_new
values('Credit',200)

insert into transaction_new
values('Debit',400)



