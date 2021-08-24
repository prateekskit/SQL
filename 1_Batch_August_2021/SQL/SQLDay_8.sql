use jb_2021
--------------------------
--------Foreign Keys-------
-- Normalization

/*

"1. There should be no comma separated values and one value per cell

2. Uniquelly identify the entities and there should not be any duplicacy of records

3. Each column should have a specific primary column based on that they can be uniquely identified and appear only once."		

*/

--- it is a process to define the tables or entities in sql with minimal storage and minimal duplicacy




Create table tblDepartment
(
     ID int primary key,
     DepartmentName nvarchar(50),
     Location nvarchar(50),
     DepartmentHead nvarchar(50)
)
Go

select * from tblDepartment

Insert into tblDepartment values (1, 'IT', 'London', 'Rick')
Insert into tblDepartment values (2, 'Payroll', 'Delhi', 'Ron') 
Insert into tblDepartment values (3, 'HR', 'New York', 'Christie')
Insert into tblDepartment values (4, 'Other Department', 'Sydney', 'Cindrella')
Go

Create table tblEmployee
(
     ID int primary key,
     Name nvarchar(50),
     Gender nvarchar(50),
     Salary int,
     DepartmentId int foreign key references tblDepartment(Id)
)
Go
select * from tblEmployee
Insert into tblEmployee values (1, 'Tom', 'Male', 4000, 1)
Insert into tblEmployee values (2, 'Pam', 'Female', 3000, 3)
Insert into tblEmployee values (3, 'John', 'Male', 3500, 1)
Insert into tblEmployee values (4, 'Sam', 'Male', 4500, 2)
Insert into tblEmployee values (5, 'Todd', 'Male', 2800, 2)
Insert into tblEmployee values (6, 'Ben', 'Male', 7000, 1)
Insert into tblEmployee values (7, 'Sara', 'Female', 4800, 3)
Insert into tblEmployee values (8, 'Valarie', 'Female', 5500, 1)
Insert into tblEmployee values (9, 'James', 'Male', 6500, NULL)
Insert into tblEmployee values (10, 'Russell', 'Male', 8800, NULL)
Go
select * from tblDepartment
select * from tblEmployee
Insert into tblEmployee values (11, 'Valarie', 'Female', 5500, 4)

sp_help tbldepartment

Insert into tblEmployee values (11, 'Sara', 'FeMale', 8800, 5)


---------------------- JOINS ----------------------------------------------

--- inner join
--- Outer join
		 --Left outer join
----	 -- right outer join
		  -- full outer join
--- cross join
--- self join ( this is just a varriation of inner or left join)

 -- inner join --

 --- I WANT EMPNAME,DEPARTNAME,LOCATION,HEAD,EMPID,DEPTID
 --- YOU CAN PUT ALIAS TO YOUR TABLES. 
 SELECT tblEmployee.ID,tblDepartment.ID,E.Name,D.DepartmentName,D.DepartmentHead,D.Location
 FROM tblEmployee E INNER JOIN tblDepartment D ON E.DepartmentId = D.ID
 
 SELECT EMP.ID,DPT.ID,Name,DepartmentName,DepartmentHead,Location
 FROM tblEmployee eMP INNER JOIN tblDepartment dPT ON DepartmentId = DPT.ID
 

 SELECT * FROM tblEmployee
 SELECT * FROM tblDepartment


 ---4 
 --- 3

