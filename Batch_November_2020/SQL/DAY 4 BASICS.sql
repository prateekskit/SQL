/*   
what is NULL  
constraints 
primary keys and Foreign keys
IDENITYT PROPERTY 
*/


select * from DimCustomerCopy where CustomerKey = 21430

select * from DimCustomerCopy where title is not null

select * from DimCustomerCopy where title is null

--- default means column can have a NULL value. so you have to sepecifically define that columns should not be null
-- while creating a table or later on.
--- NULL Constraint
Create Table tblMailingAddress
(
   AddressId int NOT NULL ,
   EmployeeNumber int,
   HouseNumber nvarchar(50),
   StreetAddress nvarchar(50),
   City nvarchar(10),
   PostalCode nvarchar(50)
)

select * from tblMailingAddress


sp_help tblMailingAddress


insert into tblMailingAddress(EmployeeNumber,HouseNumber,StreetAddress)
VALUES(250,'A-652','st louis rd')


--- Add constraint on existing column --- EXPLICITLY Change THE BEHAVIOUR OF THE COLUMNS OR ADD THE CONSTRAINT.
ALTER TABLE tblMailingAddress ALTER COLUMN EmployeeNumber INT NOT NULL


----- DEFAULT CONSTRAINT

SELECT * FROM tblMailingAddresS


--ALTER TABLE tblMailingAddresS ADD CONSTRAINT <CONSTRAINT NAME>  DEFAULT('LONDON') FOR <COLUMN YOU WANTED TO PLACE DEFAULT>

ALTER TABLE tblMailingAddresS ADD CONSTRAINT DF_CITYNAME DEFAULT('LONDON') FOR CITY

insert into tblMailingAddress(AddressId,EmployeeNumber,HouseNumber,StreetAddress)
VALUES(1,250,'A-652','st louis rd')

SP_HELP tblMailingAddress
select * from tblMailingAddress

insert into tblMailingAddress(AddressId,EmployeeNumber,HouseNumber,StreetAddress,age)
VALUES(1,250,'A-652','st louis rd',124)


---- CHECK CONSTRAINT 
ALTER TABLE tblMailingAddress ADD AGE INT 


ALTER TABLE tblMailingAddress ADD CONSTRAINT CHK_AGERANGE CHECK(AGE > 0 AND AGE < 125) 

select * from tblMailingAddress

--- PRIMARY KEY CAN NOT HAVE THE NULL VALUES
---- UNIQUE KEY CAN HAVE ONLY ONE ROW AS NULL

--------- key PRIMARY KEY , UNIQUE KEY,
 
 CREATE TABLE TBL_EMP
 (
 EMPID INT PRIMARY KEY,
 SALRY DECIMAL,
 GENDER VARCHAR(10)
 )

 ALTER TABLE TBL_EMP ADD PHONE INT 

 ALTER TABLE TBL_EMP ADD CONSTRAINT UQ_KEY UNIQUE(PHONE)

 INSERT INTO TBL_EMP
 VALUES(3,300,'m',45678)

 SELECT * FROM TBL_EMP


 UPDATE TBL_EMP
 SET PHONE = 256489
 WHERE EMPID = 1

 
 --- IDENTITY COLUMN


 ---- IDENTITY PROPERY DEFINES A UNIQUE NUMBER SEQUENCE FOR YOUR COLUMN
 CREATE TABLE info_name
 (
 ID INT IDENTITY(10000,500) PRIMARY KEY,
 FIRSTNAME VARCHAR(100),
 LASTNAME NVARCHAR(100),
 DOB DATE  
 )

 INSERT INTO info_name(FIRSTNAME,LASTNAME,DOB)
 VALUES('E','R','1901-09-09')
 SELECT * FROM info_name
 info_name
 DROP TABLE info_name

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



