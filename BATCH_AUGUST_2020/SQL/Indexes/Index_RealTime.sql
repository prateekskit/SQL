
sp_help library

select * from library where Book_id = 50

select * from library where Subject_Id = 50
--- non clustered index 255 non clustered index
CREATE INDEX IX_Index_SubjectID  ON Library (Subject_Id) 


drop table library


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

WHILE @Count >= 1 and @Count <= 500000 
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
		  @Book_Id += 1   
		SET   
		  @Count += 1 
	END 


  --WITHOUT INDEX
  select * from Library where book_id = 1

  -- CLUSTERED INDEX    
	CREATE CLUSTERED INDEX IX_Index_BookID  ON Library (book_id)  
	select * from Library where book_id = 1
  
  -- Non Clustered
  CREATE INDEX IX_Index_BookID  ON Library (book_id)  
  select * from Library where book_id = 1

  DROP INDEX IX_Index_BookID on LIBRARY