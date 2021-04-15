--- DML Syntax & DDL Syntax
use JB_2021_April

select * from [dbo].[tblemp_new]

truncate table tblemp_new   --- DDL Sysntax 

select * from [dbo].[tblEmp]
select *  from DIMCUSTOMER_REPLICA
delete from [dbo].[tblEmp]  where id = 1  --- DML Category

DROP TABLE tblemp_new                  --- DDL 

alter table tblemp drop column EmpLastName ---  DDL 


select *  from DIMCUSTOMER_REPLICA
--- DDL Syntax
UPDATE DIMCUSTOMER_REPLICA
SET title = 'Ms.'
	,Suffix = 'Jr.'
WHERE customerkey = 20333


---- SELECT 

SELECT * FROM DIMCUSTOMER_REPLICA

SELECT CUSTOMERKEY,FIRSTNAME,LASTNAME,BIRTHDATE FROM DIMCUSTOMER_REPLICA

SELECT * 
FROM DIMCUSTOMER_REPLICA
WHERE CustomerKey = 20340
--- FOR NEGATIVE CONDITIONS
SELECT * 
FROM DIMCUSTOMER_REPLICA
WHERE CustomerKey != 20340

SELECT * 
FROM DIMCUSTOMER_REPLICA
WHERE CustomerKey in (20340,20333)

SELECT * 
FROM DIMCUSTOMER_REPLICA
WHERE CustomerKey NOT in (20340,20333)

SELECT * 
FROM DIMCUSTOMER_REPLICA
WHERE FIRSTNAME in ('DANNY','ABIGAIL')
--- FOR NEGATIVE CONDITIONS
SELECT * 
FROM DIMCUSTOMER_REPLICA
WHERE FIRSTNAME not in ('DANNY','ABIGAIL')

----- AND OPERATOR & OR OPERATOR 
-- I wanted to fetch all the records where name is Danny and Abigail and should be bachelors
--- AND
select * from DIMCUSTOMER_REPLICA
where  FIRSTNAME in ('Danny','Abigail') 
	AND EnglishEducation = 'Bachelors'
	AND YearlyIncome = 40000.00

--- I  wanted to fetch 
--- the records where either name should be DANNY and abigail OR education status should be bachelors

-- OR
select FirstName,EnglishEducation
 from DIMCUSTOMER_REPLICA
where  FIRSTNAME in ('DannyYYY','AbigailYYY') 
	OR EnglishEducation = 'Bachelorsss'
	AND YearlyIncome = 40000.00

/* fetch the records for customer where yearlyincome is 120,000 and maritialstatus = Married 
OR all the folks whose marital status = single and yearlyincome = 40000
*/

select YearlyIncome,MaritalStatus from DIMCUSTOMER_REPLICA
where (YearlyIncome = 120000 AND MaritalStatus = 'M') OR (MaritalStatus = 'S' and YearlyIncome = 40000)
order by MaritalStatus



select YearlyIncome,MaritalStatus from DIMCUSTOMER_REPLICA
where (YearlyIncome = 120000 AND MaritalStatus = 'M') OR MaritalStatus = 'S'
order by MaritalStatus




select * from dimempl
