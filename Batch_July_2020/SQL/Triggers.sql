select * from tblEmployee

---  After/For Trigger
---- Instead of Trigger
---  trigger specifically attached to a table and specific to operations like INSERT/UPDATE/DELETE
---  UPDATE 

ALTER TRIGGER tr_tblEmployee
ON tblEmployee
INSTEAD OF UPDATE
AS
BEGIN
declare @id int
declare @empName varchar(100)
set @id = 0
	-- magic tables
	--select * from inserted   --- deleted
	
	select @id = id from inserted
	select @empName = name from inserted

	if @id = 0
	print 'no insertion' 
	else
	INSERT INTO tblemployeeAudit
	VALUES('A new employee with employee Id' + CAST(@id as varchar(10)) + ' and name as' + @empName + ' is inserted into tblEmployee' )

	select @id = id from deleted
	select @empName = name from deleted

	INSERT INTO tblemployeeAudit
	VALUES('An employee with employee Id' + CAST(@id as varchar(10)) + ' and name as' + @empName + ' is removed from system' )
END

CREATE TABLE tblEmployeeAudit
(
  Id int identity(1,1) primary key,
  AuditData nvarchar(1000)
)

select * from tblEmployeeAudit

INSERT into tblEmployee
values(13,'Rick','Male',5800,2)

select * from tblEmployee

delete from tblEmployee where id = 12

update tblEmployee
set name = 'jojo'
where id = 2


select 1 + 2

select 'A' + '    '  +cast(2 as varchar(10))





CREATE TRIGGER tr_tblEmployeeInsteadOf
ON tblEmployee
INSTEAD OF DELETE
AS
BEGIN
declare @id int
declare @empName varchar(100)


print ' You can not delete anything from this table. Connect with your system Admins'


END

select * from tblEmployee
delete from tblEmployee where id = 2 