---- In OPERATOR

select * from DimCustomerCopy 
WHERE TotalChildren IN (3,1)

select * from DimCustomerCopy 
WHERE LastName IN ('Rivera','Alonso')

select * from DimCustomerCopy 
WHERE LastName NOT IN ('Rivera','Alonso')

--- 
--- >,<,>=,<=,=,!= (not equal) or <> (not equal operator)
SELECT * FROM DimCustomerCopy
where YearlyIncome <= 50000

---- between & AND

SELECT * FROM DimCustomerCopy
where YearlyIncome between 75000 and 100000



--- DISTINCT 
select distinct yearlyincome from DimCustomerCopy

--- order by 
select distinct yearlyincome from DimCustomerCopy order by YearlyIncome desc

SELECT * 
FROM DimCustomerCopy 
where YearlyIncome between 70000.00 and 110000.00
order by YearlyIncome desc,EmailAddress desc 




select 5+7

select 5-1 AS 'substraction'

select Firstname+'-'+ Lastname AS 'FullName', * from DimCustomerCopy




----- CASE Statements & IIF    (anyone can be used)
SELECT CustomerKey,FirstName,LastName,BirthDate,YEARLYINCOME,
	CASE WHEN YearlyIncome >= 0 AND YearlyIncome <= 60000 THEN 'A'
		 WHEN YearlyIncome > 60000 AND YearlyIncome <= 95000 THEN 'B'
		 WHEN YearlyIncome > 95000 AND YearlyIncome <= 120000 THEN 'C'
		 ELSE 'D' 
	END AS 'INCOME GROUPS',
	CASE WHEN MaritalStatus = 'M' THEN 'MARRIED'
		ELSE 'SINGLE' 
	END AS 'MARITAL_STATUS',
	IIF(MaritalStatus = 'm','MARRIED','SINGLE') AS 'IIIFF'
FROM DimCustomerCopy


SELECT DISTINCT MaritalStatus FROM DimCustomerCopy

------ GROUP BY CLAUSE

-- m
-- S
--- AVG,MIN,MAX,SUM,COUNT
----- HOW MANY MARRIED AND SINGLE FOLKS ARE THERE IN OUR CUSTOMER BASE
SELECT MaritalStatus,COUNT(*)
FROM DimCustomerCopy 
GROUP BY MaritalStatus

----- HOW MANY MARRIED AND SINGLE FOLKS ARE THERE IN OUR CUSTOMER BASE ACCORDING TO THEIR GENDER
SELECT * FROM DimCustomerCopy

SELECT MaritalStatus,GENDER, COUNT(*)
FROM DimCustomerCopy 
GROUP BY MaritalStatus,GENDER 

---- MAXIMUM INCOME FOR EACH GENDER --- MAX(YEARLYINCOME)

Select YearlyIncome,Gender,Max(*)From DimCustomerCopyGroup BY  YearlyIncome, Gender

SELECT GENDER,max(YEARLYINCOME)
FROM DimCustomerCopy
GROUP BY GENDER 

SELECT DISTINCT GENDER,YearlyIncome FROM DimCustomerCopy


---- ORDER IN WHICH sql QEURY EXECUTES

SELECT GENDER,ENGLISHEDUCATION,COUNT(*) AS CNT									------ LAST STEP ALWAYS 
FROM DimCustomerCopy															------ 1 FIRST OF ALL GO TO TABLE 
WHERE EnglishEducation IN ('Bachelors','Graduate Degree','Partial College')		------- 2 APPLY THE WHERE CLAUSE
GROUP BY GENDER,ENGLISHEDUCATION												------	3 PERFORM THE GROUP BY				
HAVING COUNT(*) > 2000															------- 4 HAVING CLAUSE, IF ANY
ORDER BY GENDER																	------ 5 ORDER BY				


SELECT * FROM DimCustomerCopy WHERE FirstName LIKE 'A%N'


