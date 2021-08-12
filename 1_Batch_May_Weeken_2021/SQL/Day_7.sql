use JB_2021_April


---- DEFAULT CONSTRAINT 
CREATE TABLE tblAddress
(
ID int not null,
Name varchar(100),
StateCode	varchar(10)
)


insert into tblAddress
values(1,'JAck','USA')

insert into tblAddress
values(2,NULL,NULL)

select * from tblAddress

--ALTER TABLE <tableName> add constraint <constraint_name> DEFAULT <default value> FOR <columname>

ALTER TABLE tbladdress add constraint DF_default_StateCode DEFAULT 'USA' FOR StateCode

insert into tblAddress(id,name,StateCode)
values(2,'Ryan','GERMANY')

---- check constraint 

select * from tblAddress

update tblAddress
set StateCode = 'USA'
where StateCode is null
--- stored procedure
sp_help tblAddress


--- check constraints

alter table tblAddress add AGE int 

select * from tblAddress

ALTER TABLE tbladdress ADD CONSTRAINT df_check_age CHECK (AGE > 0 AND AGE <125)

INSERT INTO tblAddress
values(4,'Sara','USA',18)



-- RDBMS -- RELATIONAL DATABASE MANAGEMENT SYSTEM
-- PRIMARY KEY or PRIMARY key contraint

drop table tblAddress


CREATE TABLE tblAddress
(
ID int primary key,
Name varchar(100),
StateCode	varchar(10)
)

sp_help tblAddress

insert into tblAddress
values(2,'Ryan','USA')
select * from tblAddress

ALTER TABLE tblAddress ADD CONSTRAINT pk_tblAddress_ID primary key (ID)

ALTER TABLE tblAddress DROP CONSTRAINT pk_tblAddress_ID 