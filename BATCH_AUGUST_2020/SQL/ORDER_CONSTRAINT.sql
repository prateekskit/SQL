---- ORDER OF THE SELECT STATEMENTS. 
SELECT EnglishEducation,EnglishOccupation,count(*)      ---STEP 6
FROM DimCustomer    ----- STEP 1
WHERE EnglishOccupation IN ('','') --- STEP 2
GROUP BY EnglishEducation,EnglishOccupation    --- sTEP 3
HAVING count(*) > 500                     --STEP 4
ORDER BY EnglishEducation              ----STEP 5

-- constraints 

--- null/NOT NULL CONTRAINTS 
Create Table tblMailingAddress
(
   AddressId int NOT NULL ,
   EmployeeNumber int,
   HouseNumber nvarchar(50),
   StreetAddress nvarchar(50),
   City nvarchar(10),
   PostalCode nvarchar(50)
)

sp_help tblMailingAddress

insert into tblMailingAddress(AddressId,City,HouseNumber,PostalCode)
values(7,'Paris',200,'258789')
SELECT * FROM tblMailingAddress
insert into tblMailingAddress(City,HouseNumber,PostalCode)
values('berlin',200,'258789')

SELECT * FROM tblMailingAddress
--drop table tblMailingAddress

--- default constraint 
--ALTER table <tablename>	ADD CONSTRAINT <constraint name> DEFAULT <default value> FOR <columnname>
ALTER table tblMailingAddress ADD CONSTRAINT default_Constraint_city DEFAULT 'NYC' FOR CITY 

insert into tblMailingAddress(AddressId,HouseNumber,PostalCode)
values(8,300,'128789')
SELECT * FROM tblMailingAddress

alter table tblMailingAddress add age int

select * from tblMailingAddress

-- CHECK Constraints
insert into tblMailingAddress(AddressId,HouseNumber,PostalCode,AGE)
values(8,300,'128789',124)

alter table tblMailingAddress add constraint df_check_age check (AGE > 0 and AGE < 125)

--- Primary key

-- primary key
Create Table tblMailingAddress
(
   AddressId int primary key ,
   EmployeeNumber int,
   HouseNumber nvarchar(50),
   StreetAddress nvarchar(50),
   City nvarchar(10),
   PostalCode nvarchar(50)
)

insert into tblMailingAddress(HouseNumber,PostalCode)
values(600,'858789')

select * from tblMailingAddress
delete from tblMailingAddress
-- unique key
alter table tblMailingAddress add constraint unique_constraint unique(EmployeeNumber)


-- unique keys can have only one null value
insert into tblMailingAddress(AddressId,EmployeeNumber,HouseNumber,PostalCode)
values(8,258788,300,'128789')
insert into tblMailingAddress(AddressId,HouseNumber,PostalCode)
values(10,500,'227789')
select * from tblMailingAddress


select * into tblmailingaddr_backup from tblMailingAddress
delete from tblMailingAdress

--- identity (base value, seed value)

Create Table tblC
(
   AddressId int identity(10000,1500) not null,
   EmployeeNumber int,
   City nvarchar(10)
)




-- delete is a DML syntax in the line of SELECT,UPDATE,INSERT
delete from tblC
-- DDL syntax in the line of CREATE, ALTER, DROP
truncate table tblC
drop table tblC
insert into tblC
values(1104,'Norebro')

select * from tblC