---- FOR/AFTER TRIGGERS
ALTER TRIGGER [dbo].[tr_EmployeeIns]
ON [dbo].[tblEmployee]
FOR UPDATE
AS
BEGIN
		
		 --- this will store the newly inserted record for a temp period
		 --select * from inserted
		 --- this will store the recently deleted record for a temp period
		 --select * from deleted
		 
 insert into tblEmployeeAudit(descr)
 select 'Record has been updated with ID' + cast(I.id as varchar) 
	+ ' . Values changed from NAme' + D.NAme + ' to ' + I.name
				+ ' . Values changed from Gender' + D.Gender + ' to ' + I.GEnder
				+ ' . Values changed from Salary' + cast(D.Salary as varchar) + ' to ' + cast(I.Salary as varchar)
				+ ' . Values changed from Department' + cast(D.DepartmentId as varchar)
															 + ' to ' +  cast(I.DepartmentId as varchar)
		 from inserted I inner join deleted D on 
		 I.id = D.id

insert into tblEmployeeAudit_1
select *,1 from inserted

insert into tblEmployeeAudit_1
select *,2 from deleted


END

select * from tblEmployeeAudit_1

select * from tblEmployee
select * from tblEmployeeAudit

CREATE TABLE tblEmployeeAudit_1
(
ID int,
Empname varchar(100),
Gender varchar(10),
salary int,
departmentID int,
operation int,
date datetime,
)

select top 1 * into 

UPDATE tblEmployee
set Name = 'Sara J',
	Gender = 'Female',
	salary = 2000,
	DepartmentID = 2
where ID =12


--Record has been updated with ID12 . Values changed from NAmeCena to Sara J . Values changed from GenderFemale to Female . Values changed from Salary2500 to 2000 . Values changed from Department3 to 2

---- instead of triggers
ALTER TRIGGER [dbo].[tr_EmployeeDel]
ON [dbo].[tblEmployee]
INSTEAD OF DELETE
AS
BEGIN

--print 'You are not authorize to perform delete operations on this table. Please contact to your sys admin'

delete from tblemp_replicate where ID in (select id from deleted)

END


select * from tblEmployee
select * from tblemp_replicate
select * from tblEmp
delete from tblEmployee where ID = 1

------------------------------------------------ INDEX -----------------------------

. MDF - Primary file system 

sp_help tblEmployee