Create Table tblMailingAddress
(
   AddressId int NOT NULL primary key,
   EmployeeNumber int,
   HouseNumber nvarchar(50),
   StreetAddress nvarchar(50),
   City nvarchar(10),
   PostalCode nvarchar(50)
)




select * from tblMailingAddress

insert into tblMailingAddress(AddressId,City,AGE)
values(6,'berlin',200)


ALTER TABLE tblMailingAddress alter column city varchar(100) not null

alter table tblMailingAddress add gender char(1) 

ALTER TABLE tblMailingAddress ADD constraint df_defaultvalue_gender DEFAULT 'M' FOR gender

alter table tblMailingAddress add AGE int 

ALTER TABLE tblMailingAddress ADD constraint df_check_age CHECK (AGE > 0 and AGE <125)

update tblMailingAddress
set age = 25





Create Table tblC
(
   AddressId int identity(100,10) NOT NULL primary key,
   EmployeeNumber int,
   City nvarchar(10)
)


insert into tblC
values(1103,'oslo')

select * from tblC

alter table tblC Add constraint unique_constraint unique(employeenumber)

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



