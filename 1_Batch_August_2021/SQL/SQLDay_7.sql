--Constraints

use JB_2021_April


--- NULL 
use JB_2021

select * from tblEmployee

insert into tblEmployee(ID,Name,Salary)
values(11,'Randy',2500)


insert into tblEmployee(ID,Name,Gender,Salary)
values(12,'Randy','   ',2500)

--- get all the emp which are part of no department 
--- get all the emp where no department is assigned.

select * from tblEmployee where DepartmentId is null

use AdventureWorksDW2017

select top 10 * INTO DimCust from DimCustomer

select * from DimCust where MiddleName is null
select * from DimCust where MiddleName is not null

select * from DimCust

update DimCust
set MiddleName = ''
where CustomerKey = 11000




---------- by default all columns are nullable or having property null enabled for them

CREATE TABLE tblEx
(
ID int not null,
FName varchar(100)
)

insert into tblEx(ID)
values(2)

insert into tblEx(ID,FName)
values(3,'A')

select * from tblEx

---- DEFAULT CONSTRAINT 
CREATE TABLE tblAddress
(
ID int not null,
Name varchar(100),
country	varchar(10)
)


insert into tblAddress
values(1,'JAck','USA')

insert into tblAddress
values(2,NULL,NULL)

select * from tblAddress

--ALTER TABLE <tableName> add constraint <constraint_name> DEFAULT <default value> FOR <columname>

ALTER TABLE tbladdress add constraint DF_default_StateCode DEFAULT 'USA' FOR Country
insert into tblAddress(id,name)
values(2,'Ryan')
insert into tblAddress(id,name,country)
values(3,'JackRyan','UT.State')


sp_help tbladdress

---- check constraint 

select * from tblAddress

update tblAddress
set StateCode = 'USA'
where StateCode is null
--- stored procedure
sp_help tblAddress


--- check constraints
-- check the rrange of values defined in the system

alter table tblAddress add AGE int 

select * from tblAddress

ALTER TABLE tbladdress ADD CONSTRAINT df_check_age CHECK (AGE > 0 AND AGE <125)

INSERT INTO tblAddress
values(4,'Sara','USA',120)



-- RDBMS -- RELATIONAL DATABASE MANAGEMENT SYSTEM
-- PRIMARY KEY or PRIMARY key contraint
--- Primary Key always take unique values and does not allow null values.
drop table tblAddress


CREATE TABLE tblAddress
(
ID int primary key,
Name varchar(100),
StateCode	varchar(10)
)

sp_help tblAddress

insert into tblAddress
values(1,'Ryan','USA')

insert into tblAddress
values(2,'RyanJC','USA')

insert into tblAddress
values(3,'Snoopy','USA')

sp_help tblAddress

select * from tblAddress

ALTER TABLE tblAddress ADD CONSTRAINT pk_tblAddress_ID primary key (ID)

ALTER TABLE tblAddress DROP CONSTRAINT pk_tblAddress_ID 


---------- unique key

ALTER TABLE tblAddress ADD SSN int 
select * from tblAddress
delete from tblAddress

insert into tblAddress
values(1,'Ryan','USA',1234567)

insert into tblAddress
values(2,'RyanJC','USA',1234568)

insert into tblAddress
values(3,'Snoopy','USA',1234569)

--- diff between primary key and unique key 

alter table tblAddress Add constraint unique_constraint unique(SSN)


-- identity property

CREATE TABLE tbltran
(
tran_id int,
tran_date datetime,
account_nbr int
)















