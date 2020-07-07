--- Description about SQL CONSTRAINTs 

use AdventureWorksDW2017
select * from DimCustomer

--NULL CONSTRAINT 

use JB_07_2020

Create Table tblMailingAddress
(
   AddressId int ,
   EmployeeNumber int,
   HouseNumber nvarchar(50),
   StreetAddress nvarchar(50),
   City nvarchar(10),
   PostalCode nvarchar(50)
)

select * from tblMailingAddress where PostalCode is not null
-- NULL <> NULL
insert into tblMailingAddress(AddressId,City,PostalCode)
values(10,'NY','58964')
-- add the NULL constaint 
ALTER TABLE tblMailingAddress alter column addressID int not null
delete from tblMailingAddress where AddressId is null

sp_help tblMailingAddress

-- default value constraint 
use JB_07_2020
Create Table tblMailingAddress
(
   AddressId int not null primary key,
   EmployeeNumber int,
   HouseNumber nvarchar(50),
   StreetAddress nvarchar(50),
   City nvarchar(10),
   PostalCode nvarchar(50),
   gender char(1)
)
sp_help tblMailingAddress
insert into tblMailingAddress(AddressId,City,gender,AGE)
values(13,'NY','F',124)



select * from tblMailingAddress
--- default value constraint for the gender
ALTER TABLE tblMailingAddress ADD CONSTRAINT df_gender DEFAULT 'F' FOR gender

--- CHECK CONSTRAINT 
ALTER TABLE tblMailingAddress ADD CONSTRAINT df_check_gender CHECK (GENDER= 'M' OR GENDER = 'F')
ALTER TABLE tblMailingAddress ADD CONSTRAINT df_check_AGE CHECK (AGE > 0 AND AGE < 125)
alter table tblMailingAddress add AGE int 
-- REGULAR EXPRESSIONS

--- PRIMARY KEY
--- it should have a unique value always. 
--- primary key can't be NULL
--- there can be only 1 primary key in a table.

select * from tblMailingAddress
ALTER TABLE tblMailingAddress ADD PRIMARY KEY (ADDRESSID)

insert into tblMailingAddress(AddressId,City)
values(13,'NY')

--- UNIQUe KEY CONSTRAINT 
--- similar to primary key. only difference is that you can insert NULL VALUES but just 1
----alter table <TABLE NAME> Add constraint <CONSTRAINT NAME> unique(<COLUMN NAME>)

--alter table tblC Add constraint unique_constraint unique(employeenumber)

--- fOREIGN KEY 
--- read about the foreign key concepts..