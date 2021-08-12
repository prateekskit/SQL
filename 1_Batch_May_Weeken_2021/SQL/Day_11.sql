---- MERGE STATEMENT --- 
--- it helps to put the table in sync.....

MERGE [TARGET] AS T
USING [SOURCE] AS S
   ON [JOIN_CONDITIONS]
 WHEN MATCHED THEN 
      [UPDATE STATEMENT]
 WHEN NOT MATCHED BY TARGET THEN
      [INSERT STATEMENT] 
 WHEN NOT MATCHED BY SOURCE THEN
      [DELETE STATEMENT]


Create table StudentSource
(
     ID int primary key,
     Name nvarchar(20)
)
GO

Insert into StudentSource values (1, 'Mike')
Insert into StudentSource values (2, 'Sara')
GO

Create table StudentTarget
(
     ID int primary key,
     Name nvarchar(20)
)
GO

Insert into StudentTarget values (1, 'Mike M')
Insert into StudentTarget values (3, 'John')
GO

MERGE StudentSource AS S
USING StudentTarget AS T
ON T.ID = S.ID
WHEN MATCHED THEN
     UPDATE SET S.NAME = T.NAME
WHEN NOT MATCHED BY TARGET THEN
     INSERT (ID, NAME) VALUES(T.ID, T.NAME)
WHEN NOT MATCHED BY SOURCE THEN
     DELETE;


SELECT * FROM  StudentSource
SELECT * FROM  StudentTarget 

delete from StudentTarget

Truncate Table StudentTarget
Truncate Table StudentSource
--------------------------------------------------------------------------------

--------------------------------FUNCTIONS--------------------------------------- 

---- It takes 0 or more values/parameter to perform some operations as per the need.
--- it always returns you a value

--- system functions
---- user defined functionss

----- SYSTEM FUNCTIONS
-- AGGREGATE FUNCTIONS -- MAX,MIN,SUM,AVG,COUNT
select * from FactInternetSales 
select orderdate,sum(salesamount) from FactInternetSales group  by OrderDate


--- REPLACING NULL VALUES

select * from DimCustomer

select firstname,middlename,lastname,
	 Firstname + ' '+ Middlename + ' ' + Lastname from DimCustomer 

	 select firstname,middlename,lastname,
	 Firstname + ' '+  
	 CASE WHEN Middlename is null then ' '
		ELSE MiddleName END
	 + ' ' + Lastname from DimCustomer 

	 select firstname,middlename,lastname,
	 Firstname + ' '+  ISNULL(middlename,'XYZ')	
	 + ' ' + Lastname from DimCustomer 


----- COALESCE -- COALESCE(a,b,c,d)

select * from DimCustomer

 select firstname,middlename,title,suffix,lastname,
	 Firstname + ' '+  COALESCE(MiddleName,title,suffix,'xx')
	 + ' ' + Lastname from DimCustomer 
	 where MiddleName is not null and title is not null --and Suffix is not null

----- STRING FUNCTIONS

select firstname,middlename,title,suffix,lastname,
	 Firstname + ' '+  COALESCE(MiddleName,title,suffix,'xx')
	 + ' ' + Lastname from DimCustomer 
	 where MiddleName is not null and title is not null --and Suffix is not null

	 select firstname,UPPER(firstname) from DimCustomer
	 select firstname,LOWER(firstname) from DimCustomer

	 --- UPPER LOWER REVERSE LEN REPLACE LEFT RIGHT
