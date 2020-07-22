----VIEWS 


use JB_07_2020

--- column level security  -- restricting specific columns to be exposed
---- row level security    ---- restricting rows to be exposed
-- hiding complexity of 
/* 


*/
ALTER VIEW vw_employyaddeptbyIT
AS
	select E.ID as empId,D.ID as deptID,E.Name,e.Gender
	,D.DepartmentName,D.DepartmentHead
	from tblEmployee E
	inner join tblDepartment D on E.DepartmentId = D.ID
	where d.DepartmentName = 'IT'

select * from vw_employyaddeptbyIT where 
 inner join tblDeptName 


select * from tblDepartment

update vw_employyaddeptbyIT
set departmentHead = 'Noel'
where empid = 1

select * from #temp


CREATE VIEW vw_Employee
as
select * from tblEmployee

select * from vw_Employee

UPDATE vw_Employee
set Name = 'Sam'
where id = 2

select * from tblEmployee