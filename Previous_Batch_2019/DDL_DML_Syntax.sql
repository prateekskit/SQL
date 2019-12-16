-- to rename existing created objects. However not agood practice because 
-- names should be cautiously defined at begining. Changing at later stage during live environment 
-- can cause trouble at different ends

sp_RENAME '[OldTableName]' , '[NewTableName]'
sp_RENAME 'TableName.[OldColumnName]' , '[NewColumnName]', 'COLUMN'

USE janbask_session2



--- DATA DEFINITION LANGUAGE SYNTAX --  
CREATE DATABASE db_session3

-- DDL 

CREATE TABLE tblAddress
(
   AddressId int NOT NULL primary key,
   EmployeeNumber int,
   HouseNumber nvarchar(50),
   StreetAddress nvarchar(50),
   City nvarchar(10),
   PostalCode nvarchar(50)
)


-- DML -- DATA MANIPULATION LANGUAGE -- SYNTAX
--insert some records into tables 

INSERT INTO tblAddress
VALUES (1, 101, '#10', 'King Street', 'Londoon', 'CR27DW') 

update tblAddress
SET HouseNumber = '#20'


select * from tblAddress

-- insert data into selected columns
INSERT INTO tblAddress(AddressId,EmployeeNumber,city,PostalCode,Gender)
VALUES (3, 102,'Minneapolis', '201301','Female') 
INSERT INTO tblAddress(AddressId,EmployeeNumber,city,PostalCode,Gender)
VALUES (4, 103,'Mogadishu', '201312','Female') 

-- Add new column in existing table
ALTER TABLE tblAddress ADD gender varchar(10)
ALTER TABLE tblAddress ALTER COLUMN city nvarchar(50)


select * from tblAddress

-- truncate & drop are DDL syntax and there is difference between truncate & delete

truncate table tblAddress
drop table tblAddress
--delete is a DML syntax
delete from tblAddress where gender is null 

UPDATE tblAddress
SET POSTALCODE = '312546'
WHERE AddressID = 4







