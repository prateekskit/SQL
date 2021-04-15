select * from library
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
WHILE @Count >= 1  and @Count <= 500000 
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
  
  select * from Library where Book_Name = 'SQL SERVER10'
  alter table library drop index IX_Index_BookNAme

  -- Non Clustered
  CREATE INDEX IX_Index_BookNAme  ON Library (Book_Name)  
  select * from Library where book_id = 1

  DROP INDEX IX_Index_BookID on LIBRARY