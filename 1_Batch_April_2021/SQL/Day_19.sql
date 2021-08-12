SELECT * FROM LIBRARY
DROP TABLE LIBRARY


CREATE Table Library (  
Book_Id int identity (1, 1),  
Book_Name varchar(100),  
Dept varchar(100),  
Subject_Id int  
);  

/*  Insert the data in a table in automated way     */
DECLARE @Dept varchar(20) = 'Computer_Science' 
DECLARE @Book_Id int = 1 
DECLARE @Count int = 1 
WHILE @Count >= 1  and @Count <= 5000000 
BEGIN 
INSERT INTO Library(Book_Name, Dept, Subject_Id)   
VALUES   
  (  
    'SQL SERVER' + convert(  
      varchar(100),   
      @Book_Id  
    ),   
    @Dept,   
    @Book_Id  
  )   
SET   
  @Book_Id = @Book_Id + 1   
SET   
  @Count =  @Count + 1 
END 

select * from Library  -- 3745141
sp_help library
  --WITHOUT INDEX
  --- Table Scan --- when you try to fetch data from a table without any Indexes,
  ---- clusterede index seek - when you try to fetch the data from a table with filter on column being indexed
  ---- clustered index scan - when you try to fetch the data from a table with filter on column being non-indexed but table is having a clustered index or PK

  select * from Library where book_id = 1
  
  select * from Library where Book_Name = 'SQL SERVER9'

  -- CLUSTERED INDEX    
	CREATE CLUSTERED INDEX IX_Index_BookID  ON Library (book_id)  

	select * from Library where book_id = 1
  
  -- Non Clustered
  CREATE INDEX IX_Index_BookNAme  ON Library (Book_Name)  
  select * from Library where book_id = 1

  DROP INDEX IX_Index_BookID on LIBRARY
  select top 100 * from tbl order by id desc

  --------------------------------------- TRANSACTIONS--------------------------------------

  select * into tblEmp_Replica from tblEmployee


  select * from tblEmployee


  BEGIN TRAN
	BEGIN
		UPDATE tblEmployee
		set Name = 'Jack'
		WHERE ID = 12

		WAITFOR DELAY '00:00:20'

		UPDATE tblEmployee
		set DepartmentId = 1/0
		WHERE ID = 11


	END

	COMMIT TRAN

	ROLLBACK TRAN

	select 1/0