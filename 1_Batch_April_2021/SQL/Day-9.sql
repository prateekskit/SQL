----------JOINS------------
/*
inner join
outer join
	left outer 
	right outer 
	full outer
Self join ---- join with table itself
Cross Join
*/
ADVISOR  --- 1000 
ADVIOSR LOCATION
ADVISOR TITLE 
ADVISOR LICENSE
-----------CROSS JOIN --- cartesian producct---------

select * from tblEmployee   --11
select * from tblDepartment  -- 4

select * from tblEmployee,tblDepartment  ---44 Rows

-------------- INNER JOIN ----------------
select * from tblEmployee   --11    -- 9 rows 
select * from tblDepartment  -- 4    --- 3 rows

select E.name,E.salary,D.DepartmentName,D.DepartmentHead 
from tblEmployee E	 INNER JOIN tblDepartment D
							ON DepartmentId = D.ID
							WHERE D.ID = 1 AND E.Salary > 3500



sp_help tblEmployee


----- OUTER JOIN----------

--------LEFT OUTER JOIN OR LEFT JOIN--------------

select * from tblEmployee   --11    -- 9 rows 
select * from tblDepartment  -- 4    --- 3 rows

select * from tblEmployee E	 LEFT OUTER JOIN  tblDepartment D
							ON DepartmentId = D.ID

select * from  tblDepartment D	 LEFT OUTER JOIN tblEmployee E
							ON DepartmentId = D.ID


select * from tblEmployee E	 LEFT OUTER JOIN  tblDepartment D
							ON DepartmentId = D.ID
							where DepartmentId is null

-------- RIGHT OUTER JOIN OR RIGHT JOIN


select * from tblEmployee E	 RIGHT OUTER JOIN  tblDepartment D
							ON DepartmentId = D.ID

select * from  tblDepartment D	 RIGHT OUTER JOIN tblEmployee E
							ON DepartmentId = D.ID


---- self join 

CREATE TABLE tblManagerReln
(
ID int,
EmpName varchar(100),
MgrID int
)


INSERT into tblManagerReln
values(5,'Reena',3)

select * from tblManagerReln

select  M.EmpName as 'ManagerName', E.EmpName as 'EmployeeName'
		 from tblManagerReln E inner join tblManagerReln M
							ON E.ID = M.MgrID

					
select   E.EmpName as 'EmployeeName',M.EmpName as 'ManagerName'
		 from tblManagerReln as E left outer join tblManagerReln as M
							ON E.MgrID = M.ID

----Set Operators----