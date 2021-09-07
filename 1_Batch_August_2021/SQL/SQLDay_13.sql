

---  date time functions
-- 0 false , 1 - true
select ISDATE(NULL)
select ISDATE('2020-03-03')
select ISDATE('2020-03-31')
select ISDATE('2020-03-32')
select ISDATE('2020-02-29')
select ISDATE('2021-02-29')

--- DAY,MONTH, YEAR

select getdate()
select DAY(getdate())   --- day 
select MONTH(getdate())  -- month
select YEAR(getdate())   -- year

select * from DimCustomer
select * from DimCustomer where year(birthdate) > 1985

select datepart(day,getdate())
select datepart(day,'2021-03-03')

select datepart(day,'2021-03-32')

select datepart(MONTH,getdate())
select datepart(YEAR,getdate())

select datepart(Q,getdate())
select datepart(WEEKDAY,getdate())
select datepart(WEEK,getdate())
select datepart(M,getdate())

select datepart(M,'2020-03-03')

select year(birthdate) from DimCustomer where year(birthdate) > 1985


select DAY(getdate()) + 'abc'

select datename(day,getdate()) 
select datename(MONTH,getdate()) 
select datename(WEEKDAY,getdate()) 


---------------------------- DATEADDD---------------------------------------



select DATEADD(day,365,'2020-01-01')  --- 29th feb

select DATEADD(month,12,'2020-01-01')  --- 29th feb

select DATEADD(YEAR,1,'2020-01-01')  --- 29th feb

select DATEADD(YEAR,-1,'2020-01-01')  --- 29th feb


-------------------------------------- DATEDIFF------------------------------

select DATEDIFF(day,getdate(),'2024-08-27')

select DATEDIFF(YEAR,getdate(),'2024-08-27')

select DATEDIFF(MONTH,getdate(),'2024-08-27')

--------------------------------------------------------

-------------------------- Ranking Functions ---------------------------------


use JB_2021
select * from tblEmployee
select  * from tblEmployee order by salary desc

---- row_num , rank, dense_rank

update tblEmployee
set salary = 4500
where id = 7

select *, ROW_NUMBER() over (order by salary desc ) as 'row_number'
		  ,RANK() over (order by salary desc)     as  'rank_new' 
		  ,DENSE_RANK() over (order by salary desc)     as  'rank_new' 
 from tblEmployee


---- I want to know only 4,5 position guys 

select * 
from(	select *, ROW_NUMBER() over (order by salary desc ) as 'row_number'
		  ,RANK() over (order by salary desc)     as  'rank_new' 
		  ,DENSE_RANK() over (order by salary desc)     as  'dense_rank_new' 
		from tblEmployee
	) AS T
WHERE T.rank_new IN (4,5)



with cte
as
(
select *, ROW_NUMBER() over (order by salary desc ) as 'row_number'
		  ,RANK() over (order by salary desc)     as  'rank_new' 
		  ,DENSE_RANK() over (order by salary desc)     as  'dense_rank_new' 
		from tblEmployee
)
select * from cte where rank_new in (4,5)





select *, ROW_NUMBER() over (order by salary desc ) as 'row_number'
		  ,RANK() over (order by salary desc)     as  'rank_new' 
		  ,DENSE_RANK() over (order by salary desc)     as  'dense_rank_new' 
		FROM TBLEMPLOYEE
		WHERE RANK_NEW IN (4,5)

		select				 ---- 5	
		from                 ---- 1
		where				 ---- 2
		group by			 ---- 3
		having				 ---- 4	
		order by			 ---- last 


------------------------------------------------------ USER DEFINED FUNCTIONS ------------------------------


--- scalar functions ------------------------------- 
---- which always returns a value --- either int,varchar,bit,date, 
--- always a single value , no multiple values --------------

/*
CREATE FUNCTION <FUNCTION_NAME>(PARAMETERS 1 DATATYPE, PARAMETERS 2 DATAYPE .... PARAMETERS n DATATYPE)
RETURNS INT,VARCHAR <DATATYPE>
AS
	BEGIN

		WRITE DOWN YOUR LOGIC

		RETURN VALUE;

	END
*/


  -- @DOB = '2021-01-01'
  -- @DOB = '2022-01-01'


CREATE FUNCTION fn_Age(@DOB Date) --- parameter  
RETURNS INT  
AS  
BEGIN  
	 DECLARE @X INT  ---- VARRIABLE DECLARATION
	 SET @X =   DATEDIFF(YEAR, @DOB, GETDATE()) - 
				CASE WHEN (MONTH(@DOB) > MONTH(GETDATE())) OR (MONTH(@DOB) = MONTH(GETDATE())
				AND DAY(@DOB) > DAY(GETDATE())) THEN 1 ELSE 0 END  
	 RETURN @X  
END


select dbo.fn_age('1991-08-28')

---------------- while and if and else conditions ----------------------
















