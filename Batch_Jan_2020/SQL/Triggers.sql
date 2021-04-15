--TRIGGERS
-- Create a main table and log/audit table
-- DML TRiggers

CREATE TRIGGER <triggerName>
ON <table name>   -- mention the existing table
FOR INSERT        -- mention the operation AFTER OR INSTEAD OF
AS
BEGIN
/*
 tasks to be performed
*/
END

select * from tblEmployee
select * from tblDepartment

ALTER TRIGGER tr_tblEmployeeForInsert
ON tblEmployee
FOR INSERT,DELETE
AS
BEGIN
	
if exists(select * from deleted)
	begin
		insert into tblEmp_Audit(id,name,gender,salary,departmentid,operation,inserted_on)
		select *,'D',getdate() from deleted
	end
else 
	begin
		insert into tblEmp_Audit(id,name,gender,salary,departmentid,operation,inserted_on)
		select *,'I',getdate() from inserted
	end
END

select * from tblEmp_Audit

ALTER table tblEmp_Audit add operation varchar(10)
ALTER table tblEmp_Audit add inserted_on datetime
ALTER table tblEmp_Audit add id_new int identity(1,1)

alter table tblEmp_Audit add constraint df_date default(getdate()) on inserted_on

insert into tblEmployee
values(22,'Mrs. Ron','Male',5500,5)
delete from tblEmployee where id = 22



sp_help tblEmp_Audit
select * from tblEmployee
select * from tblemployeeaudit

select * into tblEmp_Audit from tblEmployee
delete  from tblEmp_Audit

drop table tblEmployeeAudit

insert into tblDepartment
values(5,'Finance','NYC','Mr. Rick')
select * from tblEmployee
insert into tblEmployee
values(13,'Zia','FeMale',2500,5)
delete from tblEmployee where id = 13

CREATE TABLE tblEmployeeAudit
(
  Id int identity(1,1) primary key,
  AuditData nvarchar(max)
)
select * from tblEmployeeAudit

-- AFTER/FOR INSERT TRIGGER

ALTER TRIGGER tr_tblEMployee_ForInsert
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
 
 select * from inserted 
 --select * from deleted 

 insert into tblEmployeeAudit 
 values('New employee with Id  = ' + Cast(@Id as nvarchar(5)) +   'and name as ' + @name   + ' is added at ' + cast(Getdate() as nvarchar(20)))
END	

select * from tblEmployee
select * from tblEmployeeAudit
delete from tblEmployeeAudit
Insert into tblEmployee values (29,'jeannie', 'Female',2598, 3)
delete from tblEmployee where id = 16




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



select * from tblEmployeeAudit


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

select * from tblEmployee

select * from tblEmployeeAudit 


update tblEmployee
set salary = 5600 , name = 'Malina',gender = 'Female'
where id = 5


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
Instead Of Insert
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



