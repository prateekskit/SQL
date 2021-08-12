----- date add AND DATE DIFF

SELECT DATEADD(DAY,10,GETDATE())
SELECT DATEADD(MONTH,24,GETDATE())
SELECT DATEADD(year,24,GETDATE())
SELECT DATEADD(DAY,-10,GETDATE())
SELECT DATEADD(MONTH,-24,GETDATE())
SELECT DATEADD(year,-24,GETDATE())


SELECT DATEDIFF(YEAR,'1988-05-05',GETDATE())
SELECT DATEDIFF(month,'1988-05-05',GETDATE())
SELECT DATEDIFF(DAY,'1988-05-05',GETDATE())






--RANK FUNCTIONS




use JB_2021_April

select top 3 * from tblEmployee order by salary desc

--- ROW_NUMBER,  RANK, DENSE_RANK

--- ROW_NUMBER() over(order by <column> asc or desc)

----- rankings based on salary , highest salary will get top rank.
select *,
	ROW_NUMBER() OVER(order by salary desc) as 'row number',
	RANK() OVER(order by salary desc) as 'rank_1',
	DENSE_RANK() OVER(order by salary desc) as 'dense_rank_2'	
	from tblEmployee 

----- Rank with Partition by 

--- give me the rank  for each employee based on highest salary  being 1st. Ranking should be done separately 
---- for males and females.


/*
different ways to write sub-queries

1. 
	select a,b,c,(select top 1 from <tblA>) 
	FROM tblB
2. 
	SELECT * 
	FROM (	
			select a,b,c
			FROM tblB
		 ) as t

3. 
		SELECT * 
	FROM TABLa where a = (SELECT 1 FROM TBLb) 
	*/


select *,
	ROW_NUMBER() OVER(partition by gender order by salary desc) as 'row number',
	RANK() OVER(partition by gender order by salary desc) as 'rank_1',
	DENSE_RANK() OVER(partition by gender order by salary desc) as 'dense_rank_2'	
	from tblEmployee 

select * from 
	(
		select *,
					ROW_NUMBER() OVER(partition by gender order by salary desc) as 'row number',
					RANK() OVER(partition by gender order by salary desc) as 'rank_1',
					DENSE_RANK() OVER(partition by gender order by salary desc) as 'dense_rank_2'	
					from tblEmployee ) AS tBL_TEMP
	where [row number] in (3,4,5)

------------------------------------------------------------------------------------
-------------------------------- user defined functions-----------------------------

--- TWO WAYS TO CALCUALTE THE age 
SELECT DATEDIFF(YEAR,'1988-05-05',GETDATE())  


SELECT DATEDIFF(YEAR, '1988-05-01', GETDATE()) - 
	CASE WHEN (MONTH('1988-05-01') > MONTH(GETDATE())) 
				OR (MONTH('1988-05-01') = MONTH(GETDATE()) AND DAY('1988-05-01') > DAY(GETDATE())) THEN 1 
	ELSE 0 END  
------------- SCALAR valued functions-------------
/*
CREATE FUNCTION <FUNCTION_NAME>(PARAMETERS 1 DATATYPE, PARAMETERS 2 DATAYPE .... PARAMETERS n DATATYPE)
RETURNS INT,VARCHAR <DATATYPE>
AS
	BEGIN

		WRITE DOWN YOUR LOGIC

		RETURN VALUE;

	END
*/

CREATE FUNCTION fn_Age(@DOB Date)  
RETURNS INT  
AS  
BEGIN  
	 DECLARE @X INT  ---- VARRIABLE DECLARATION
	 SET @X = DATEDIFF(YEAR, @DOB, GETDATE()) - CASE WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())) THEN 1 ELSE 0 END  
	 RETURN @X  
END


ALTER FUNCTION fn_Age(@DOB Date)  
RETURNS INT  
AS  
BEGIN  
	 DECLARE @X INT  ---- VARRIABLE DECLARATION
	 SET @X = DATEDIFF(YEAR, @DOB, GETDATE()) - CASE WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR (MONTH(@DOB) = MONTH(GETDATE()) AND DAY(@DOB) > DAY(GETDATE())) THEN 1 ELSE 0 END  
	 RETURN @X  
END



SELECT BirthDate,dbo.fn_age(birthdate) as 'age' FROM DIMCUSTOMER_REPLICA
where dbo.fn_age(birthdate) > 60

------------------------------------- table valued functions------------------------------
/*
CREATE FUNCTION <FUNCTION_NAME>(PARAMETERS 1 DATATYPE, PARAMETERS 2 DATAYPE .... PARAMETERS n DATATYPE)
RETURNS TABLE
AS
RETURN (select * from tabl)
*/


select * from DIMCUSTOMER_REPLICA

CREATE FUNCTION fn_CustomerByOccupation(@EnglishOccupation nvarchar(10))
RETURNS TABLE
AS
RETURN (Select Firstname,Lastname,Gender,YearlyIncome,EnglishOccupation
      from DIMCUSTOMER_REPLICA
      where EnglishOccupation = @EnglishOccupation)


select * from fn_CustomerByOccupation('Management')

