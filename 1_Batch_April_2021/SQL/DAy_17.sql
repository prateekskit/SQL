use AdventureWorksDW2017

CREATE PROCEDURE getSampleData
as
BEGIN

	SELECT * FROM DIMCustomer;  ---- fetching all data


	SELECT * into #temp_table 	from DimCustomer where EnglishEducation = 'Bachelors';  --- inserting in temp

	with cte 
	as
	(
		select *,row_number() OVER(order by AYI desc) as 'ranking'
		FROM
				(
					select EnglishEducation,AVG(yearlyincome) as 'AYI'
					from dimcustomer
					group by EnglishEducation
				)
					 AS T
		
	)
	select * from cte where ranking = 2;


	select * from #temp_table;

END

exec getSampleData

------------------   VIEWS -----------------------------------
--- select statements and it does not have any parameters as well.
select distinct EnglishOccupation from DimCustomer

select * from DimCustomer

Professional
Clerical
Manual
Management
Skilled Manual


CREATE VIEW vwGetProfessional
AS
select * from dimcustomer where EnglishOccupation = 'Professional'

---- ROW LEVEL SECURITY
select * from vwGetProfessional



--- column level security
ALTER VIEW GetClericCustomer
AS
select CustomerKey,FirstName,LastName,EmailAddress from dimcustomer where EnglishOccupation = 'Clerical'


select *  from GetClericCustomer

------------------------------------------------------- TRIGGERS -------------------------------

use JB_2021_April

--- associated with insert,update, delete operations
---- 
---- AFTER/FOR & INSTEAD OF

---- MAGIC TABLE

select * from tblEmployee


CREATE TABLE tblEmployeeAudit
(
ID int identity(1,1),
CurrentDate date constraint df_ddefualt default(GETDATE()),
descr varchar(max)
)

insert into tblEmployeeAudit(descr)
values('test')

select * from tblEmployeeAudit
----- AFTER or FOR Triggers

ALTER TRIGGER tr_EmployeeIns
ON tblemployee
FOR INSERT
AS
BEGIN
		
		--select * from tblEmployee	
		 select * from inserted

		 --DECLARE @id int
		 --DECLARE @name varchar(100)

		 --Select @id = id from inserted
		 --select @name = name from inserted 

		 insert into tblEmployeeAudit(descr)
		 select 'New data has been inserted with ID' + cast(id as varchar) + ' AND name' + NAme
		 from inserted

		 --insert into tblEmployeeAudit(descr)
		 --VALUES('New data has been inserted with ID' + cast(@id as varchar) + ' AND name' + @name)

END


---- sepecific tables only used and accessed innside triggeeers
---- called up as MAGIC TABLES
---- INSERTED & DELETED


select * from tblEmployee	

insert into tblEmployee
values(14,'MCena','Female',2500,3)


select * from tblEmployeeAudit



select * from inserted

 select * from tblEmployee	
 select * from tblEmp

 insert into tblEmployee
 select 15,EmpName,salary,NULL,NULL from tblEmp



 select * into tbl from tblEmployee 