--TRIGGERS
-- Create a main table and log/audit table

select * from tblEmployee

CREATE TABLE tblEmployeeAudit
(
  Id int identity(1,1) primary key,
  AuditData nvarchar(1000)
)
select * from tblEmployeeAudit

-- AFTER/FOR INSERT TRIGGER

CREATE TRIGGER <tr_tblEmployee_ForInsert>
ON <table>
FOR <INSERT,DELETE,UPDATE>
AS 
BEGIN

/* scripting component */

END

--- AFTER/FOR INSERT TRIGGER
ALTER TRIGGER tr_tblEMployee_ForInsert
ON tblEmployee
FOR INSERT
AS
BEGIN
--- Define certain varriables so that it can hold up the values
 Declare @Id int   ---- to hold up newly created ID
 DECLARE @name nvarchar(100)   ---- to hold up newly inserted name
 
 --- fetch the values from intermediate tables / MAGIC TABLES   --- fixed name tables
 ---- INSERTED & DELETED
 ---- by default these tables will pick up the schema of table on which you wanted to create a TRIGGER 
 
  Select @Id = Id from inserted
  select @name = name from inserted
  select * from inserted 
 --select * from deleted 

 insert into tblEmployeeAudit 
 values('New employee with Id  = ' + Cast(@Id as nvarchar(5)) +   'and name as ' + @name   + ' is added at ' + cast(Getdate() as nvarchar(20)))

END	

select * from tblEmployee
select * from tbldepartment
select * from tblEmployeeAudit
delete from tblEmployeeAudit
Insert into tblEmployee values (31,'Hughie', 'Male',5500, 3)
INSERT INTO tbldepartment values(6,'security','Frankfurt',NULL)
delete from tblEmployee where id = 16

select 'My Age is' + CAST( 5 as varchar(3))

--select * from inserted 


update tblEmployee
set name = 'mark'
where id = 16

select * from inserted 

drop trigger tr_tblEMployee_ForInsert


select * from tblEmployee
select * from tblEmployeeAudit
Insert into tblEmployee values (15,'Tan', 'Female',2300, 3)

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
delete from tblEmployee where id = 31
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

select * from tblEmployeeAudit
select * from tblEmployee

update 

select * from tblEmployee
Update tblEmployee set Name = 'TOM', Salary = 20000, 
Gender = 'FeMale' where Id = 1

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

	  -- EXISTS -- check the boolean values, whether record exists or not in a particular table.
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






select * from tblEmployee

UPDATE tblEmployee
set Salary = 25000,
	Gender = 'Male'	
	WHERE ID IN (13,15)


select * from tblEmployeeAudit 


update tblEmployee
set salary = 5600 , name = 'Malina',gender = 'Female'
where id = 5


---- INSTEAD OF TRIGGERS
/*
If you want to execute DML syntax on another object/table instead of the designated object, you can use the INSTEAD OF triggers
*/

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


Insert into vWEmployeeDetails values(32, 'Valarie', 'Female', 'IT')

select * from tblEmp
select * from tbldept

---- INSTEAD OF INSERT TRIGGER ON THE VIEW, means instead of doing insertion on view what else we can do
ALTER trigger tr_vWEmployeeDetails_InsteadOfInsert
on vWEmployeeDetails
Instead Of Insert
as
Begin
 /*Declare @DeptId int
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
 from inserted*/
 print ' you are not allowed to insert the data via this object or view  '

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







