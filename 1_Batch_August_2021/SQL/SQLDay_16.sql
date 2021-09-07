---------- VIEWS -----------------------

--- its look like a table.
--- achieve row level and column level security
select * from tblEmployee
-- row level security
CREATE VIEW vw_tblemployeeforHR
AS
select * 
from tblEmployee
where DepartmentId = 3

select * from vw_tblemployeeforHR


-- column level security , where you are restricting the access
-- to certain columns
ALTER VIEW vw_tblemployeeforIT
AS
select ID,Name,Gender,DepartmentId 
from tblEmployee
where DepartmentId = 1


select * 
from vw_tblemployeeforIT 


-- column level security 
--- views can not take any parameters
--- views can be called with FROM clause only.

--- system specific views ----------------

select *
from INFORMATION_SCHEMA.TABLES

select *
from INFORMATION_SCHEMA.COLUMNS

sp_helptext [INFORMATION_SCHEMA.TABLES]


---------------------------------------------------------------------
--------------------------------- TRIGGERS -------------------------

/*
	Triggers are not good performance aspect
	they tend to slow down process like insert,update and delete operations
	trigger can be associated with insert,update or delete operations only
	triggers use the specific tables - called as intermediate table or magic tables.	
		INSERTED
		DELETED
	triggers are the table level objects.
	you can't call the triggers explicitly.
*/

--- for
--- instead of

insert into tblEmployee
values (40,'Ron','male',3400,1)

ALTER TRIGGER tr_EmployeeIns
ON tblEmployee
FOR INSERT
AS
BEGIN

	insert into tblaudit
	select 'INSERTION IS PERFORMED FOR ID as ' + cast(ID as varchar)
							+ ' Name as ' + name + ' gender as ' + gender
							+ ' salary as ' + cast(salary as varchar)
							+ ' department id ' + cast(departmentID as varchar)
	from inserted

END



ALTER TRIGGER tr_EmployeeDel
ON tblEmployee
FOR DELETE
AS
BEGIN

	insert into tblaudit
	select 'DELETION IS PERFORMED FOR ID as ' + cast(ID as varchar)
							+ ' Name as ' + name + ' gender as ' + gender
							+ ' salary as ' + cast(salary as varchar)
							+ ' department id ' + cast(departmentID as varchar)
	from deleted

END



delete from tblEmployee
where ID = 32

CREATE TABLE tblAudit
(
	ID int identity(1,1),
	summary nvarchar(max)
)

select * from tblAudit

select * from inserted
select * from deleted

ALTER TRIGGER tr_EmployeeUpd
ON tblEmployee
FOR UPDATE
AS
BEGIN

	select * from deleted
	select * from inserted

	 insert into tblaudit
 select 'Record has been updated with ID' + cast(I.id as varchar) 
	+ ' . Values changed from NAme ' + D.NAme + ' to ' + I.name
				+ ' . Values changed from Gender ' + D.Gender + ' to ' + I.GEnder
				+ ' . Values changed from Salary ' + cast(D.Salary as varchar) + ' to ' + cast(I.Salary as varchar)
				+ ' . Values changed from Department'  + cast(D.DepartmentId as varchar)
															 + ' to ' +  cast(I.DepartmentId as varchar)
		 from inserted I inner join deleted D on 
		 I.id = D.id



END


select * from tblEmployee

update tblEmployee
set Name = 'Perry',
	salary = 2100
where ID = 2


select * from tblaudit