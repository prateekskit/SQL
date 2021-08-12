use JB_2021

select * from emp

--- if inserting as per column order
INSERT INTO EMP
VALUES(2,'John',18000.00,'2020-05-05')

-- values with specific column name
INSERT INTO EMP(EmpID,EmpName,DOB)
VALUES(1,'JanBask','2020-05-05')

-- replicate existing table with another name
--- not only copying data, but copying table structure as well.
select * into emp_bkp
from Emp

select * from Emp
select * from emp_bkp

delete from emp_bkp 

---- insert the bulk data in existing table from another table.
insert into emp_bkp
select * from Emp

delete from emp_bkp 
-- insert oonly specific columns data.
insert into emp_bkp(EmpID,DOB)
select EmpID,DOB from Emp

select * from emp_bkp



insert into emp_bkp
select * from Emp

---- cross database insertion and creation of table
--- this is possible only when both databases are at same server.

select * into dimcustomer_Bakcup
from AdventureWorksDW2017.dbo.DimCustomer

----


select * from [dbo].[dimcustomer_Bakcup]

--interview questions 
JOHN - 4
NANCY - 5

VARCHAR(10)   -- 4 byte   5 byte      ----store plain english and no foreign elements
CHAR(10)      --  10 byte   10 byte   --- only when we are 100% sure of the byte consumed
NVARCHAR(10)  -- 4 byte   5 byte       --- foreign elements 

-----------------------------------------------------

--- WHERE CLAUSE    
-- SELECT,FROM,WHERE,GROUP BY, ORDER BY, HAVING,DISTINCT,TOP
-- INSERT,UPDATE,DELETE,TRUNCATE

select * from emp_bkp

select  * from emp where empid = 2

insert into emp_bkp
select  * from emp where empid = 2


select * from emp

delete from emp where empid = 2








