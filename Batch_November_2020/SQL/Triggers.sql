USE JB_08_2020

--TRIGGERS
-- Create a main table and log/audit table
-- DML TRiggers

--- FOR/AFTER TRIGGER
--- INSTEAD OF TRIGGERS

----- TRIGGER DEFINITIONS

CREATE TRIGGER <triggerName>
ON <table name>   -- mention the existing table
FOR INSERT,UPDATE,DELETE        -- mention the operation
AS
BEGIN
/*
 tasks to be performed
*/
END

select * from tblEmployee

drop trigger tr_empTbl

ALTER TRIGGER tr_empTbl
ON tblEmployee
INSTEAD OF INSERT,UPDATE,DELETE
AS
BEGIN

SELECT * from tblEmployee

END

SELECT * FROM tblEmployee

UPDATE tblEmployee
SET ID = 1000
WHERE NAME = 'Pam'

insert into tblEmployee(id,name)
values(10000,'hjk')

delete from tblEmployee

drop trigger tr_onEmpTable

ALTER TRIGGER tr_onEmpTable
ON tblEmployee
FOR INSERT,DELETE,UPDATE
AS
BEGIN
--- Magic Tables  1. INSERTED  2. DELETED
select * from inserted
select * from deleted
END



UPDATE tblEmployee
SET ID = 1000
WHERE NAME = 'Pam'



select * from tblEmployee
delete from tblEmployee where id = 10001
insert into tblEmployee(id,name)
values(10001,'hjk')

select * from inserted

------ this table will keep a log of operations.
CREATE TABLE tblEmployeeAudit
(
  Id int identity(1,1) primary key,
  AuditData nvarchar(1000)
)
select * from tblEmployeeAudit
select * from tblEmployee


--- intermediate tables called as INSERTED & DELETED
---- 
-- AFTER/FOR INSERT TRIGGER

Insert into tblEmployee values (15000,'Tan', 'Female',2300, 3)

select * from tblEmployee
select * from tblEmployeeAudit
CREATE TRIGGER tr_tblEMployee_ForInsert
ON tblEmployee
FOR INSERT
AS
BEGIN
--- Define certain varriables so that it can hold up the values
 Declare @Id int
 DECLARE @name nvarchar(100)
 --- fetch the values from intermediate tables / MAGIC TABLES
 Select @Id = Id from inserted
 select @name = name from inserted
--select * from inserted 
--select * from deleted 
 --print 'Data has been inserted'
 insert into tblEmployeeAudit 
 values('New employee with Id  = ' + Cast(@Id as nvarchar(5)) +   ' and name as ' + @name   + ' is added at ' + cast(Getdate() as nvarchar(20)))
END	

CREATE TRIGGER tr_tblEMployee_Fordel
ON tblEmployee
FOR DELETE
AS
BEGIN

Declare @Id int
DECLARE @name nvarchar(100)

SELECT @Id = Id from deleted
SELECT @name = name from deleted

insert into tblEmployeeAudit 
values('Employee with Id  = ' + Cast(@Id as nvarchar(5)) +   'and name as ' + @name   + ' is deleted at ' + cast(Getdate() as nvarchar(20)))

END	

drop trigger [tr_tblEMployee_ForDELETE]

Insert into tblEmployee values (33,'HAMMOND', 'Female',2598, 3)


select * from tblEmployee
delete from tblEmployee where id = 15000
select * from tblEmployeeAudit


select * from tblEmployee
select * from tblEmployeeAudit
delete from tblEmployeeAudit
Insert into tblEmployee values (29,'jeannie', 'Female',2598, 3)
delete from tblEmployee where id = 16

delete from tblEmployee where id = 32


update tblEmployee
set name = 'mark'
where id = 16

select * from inserted 

drop trigger tr_tblEMployee_ForInsert


select * from tblEmployee
select * from tblEmployeeAudit
Insert into tblEmployee values (15,'Tan', 'Female',2300, 3)


create






-- AFTER/FOR DELETE TRIGGER
CREATE TRIGGER tr_tblEMployee_ForDelete
ON tblEmployee
FOR DELETE
AS
BEGIN
 Declare @Id int
 Select @Id = Id from deleted
 
 insert into tblEmployeeAudit 
 values('An existing employee with Id  = ' + Cast(@Id as nvarchar(5)) + ' is deleted at ' + Cast(Getdate() as nvarchar(20)))
 print @id
END
-- showcase how the inserted and deleted tables are working
delete from tblEmployee where id = 27
select * from tblEmployeeAudit
select * from tblEmployee where 

--- AFTER UPDATE TRIGGER -- THERE is no magic tables for update 

Create trigger tr_tblEmployee_ForUpdate
on tblEmployee
for Update
as
Begin
 Select * from deleted
 Select * from inserted 
End
DROP TRIGGER tr_tblEmployee_ForUpdate
select * from tblEmployee


select * from tblEmployeeAudit


Update tblEmployee 
set Name = 'Todss', Salary = 20000, 
Gender = 'FeMale' where Id = 4




select * from tblEmployee
Update tblEmployee set Name = 'Todss', Salary = 20000, 
Gender = 'FeMale' where Id = 4

drop trigger tr_tblEmployee_ForUpdate





CREATE trigger tr_tblEmployee_ForUpdate_Logging
on tblEmployee
for Update
as
Begin
      -- Declare variables to hold old and updated data
      Declare @Id int
      Declare @OldName nvarchar(20), @NewName nvarchar(20)
      Declare @OldSalary int, @NewSalary int
      Declare @OldGender nvarchar(20), @NewGender nvarchar(20)
      Declare @OldDeptId int, @NewDeptId int
      -- Variable to build the audit string
      Declare @AuditString nvarchar(1000)
      
      -- Load the updated records into temporary table
      Select *
      into #TempTable
      from inserted
     
      -- Loop thru the records in temp table
      While(Exists(Select Id from #TempTable))
      Begin
            --Initialize the audit string to empty string
            Set @AuditString = ''
           
            -- Select first row data from temp table
            Select Top 1 @Id = Id, @NewName = Name, 
            @NewGender = Gender, @NewSalary = Salary,
            @NewDeptId = DepartmentId
            from #TempTable
           
            -- Select the corresponding row from deleted table
            Select @OldName = Name, @OldGender = Gender, 
            @OldSalary = Salary, @OldDeptId = DepartmentId
            from deleted where Id = @Id
   
     -- Build the audit string dynamically           
            Set @AuditString = 'Employee with Id = ' + Cast(@Id as nvarchar(4)) + ' changed'
            if(@OldName <> @NewName)
                  Set @AuditString = @AuditString + ' NAME from ' + @OldName + ' to ' + @NewName
                 
            if(@OldGender <> @NewGender)
                  Set @AuditString = @AuditString + ' GENDER from ' + @OldGender + ' to ' + @NewGender
                 
            if(@OldSalary <> @NewSalary)
                  Set @AuditString = @AuditString + ' SALARY from ' + Cast(@OldSalary as nvarchar(10))+ ' to ' + Cast(@NewSalary as nvarchar(10))
                  
     if(@OldDeptId <> @NewDeptId)
                  Set @AuditString = @AuditString + ' DepartmentId from ' + Cast(@OldDeptId as nvarchar(10))+ ' to ' + Cast(@NewDeptId as nvarchar(10))
           
            insert into tblEmployeeAudit values(@AuditString)
            -- Delete the row from temp table, so we can move to the next row
            Delete from #TempTable where Id = @Id
      End
End

CREATE trigger tr_tblEmployee_insteadofInsert
on tblEmployee
INSTEAD OF INSERT
as
Begin
print 'you can not insert the data in this table. please connect with your system admin'
END


Insert into tblEmployee values (15,'Tan', 'Female',2300, 3)

select * from tblEmployee


update tblEmployee
set salary = 54000 , name = 'Sariak',gender = 'Male'
where id = 7


---- INSTEAD OF TRIGGERS


select * from tblEmp
select * from tblDept

Create view vWEmployeeDetails
as
Select Id, Name, Gender, DeptName
from tblEmp 
join tblDept
on tblEmp.DepartmentId = tblDept.DeptId

-- view with multiple join of table will not insert data
select * from vWEmployeeDetails
Insert into vWEmployeeDetails values(30, 'Valarie', 'Female', 'IT')

select * from tblEmp
select * from tbldept

---- INSTEAD OF INSERT TRIGGER ON THE VIEW, means instead of doing insertion on view what else we can do
Create trigger tr_vWEmployeeDetails_InsteadOfInsert
on vWEmployeeDetails
Instead Of Insert   ---- it will do opertaions apart from insert 
as
Begin
 Declare @DeptId int
 
 --Check if there is a valid DepartmentId
 --for the given DepartmentName
 Select @DeptId = DeptId 
 from tblDept 
 join inserted
 on inserted.DeptName = tblDept.DeptName
 
 --If DepartmentId is null throw an error
 --and stop processing
 if(@DeptId is null)
 Begin
  Raiserror('Invalid Department Name. Statement terminated', 16, 1)
  return
 End
 
 --Finally insert into tblEmployee table
 Insert into tblEmp(Id, Name, Gender, DepartmentId)
 Select Id, Name, Gender, @DeptId
 from inserted
End

-- INSTEAD OF DELETE TRIGGER

CREATE TRIGGER tr_vWEmployeeDetails_InsteadOfDelete
on vWEmployeeDetails
instead of delete
as
Begin
 Delete tblEmp 
 from tblEmp
 join deleted
 on tblEmp.Id = deleted.Id

 --Subquery
 Delete from tblEmployee 
 where Id in (Select Id from deleted)
End
select * from vWEmployeeDetails
delete from vwemployeedetails where id = 30
select * from tblEmp


--- CREATE  A TRIGGER with INSTEAD OF UPDATE -- ASSIGNMENT -- will discuss tomorrow. 



