CREATE Table Library (  
Book_Id int identity (1, 1),  
Book_Name varchar(100),  
Dept varchar(100),  
Subject_Id int  
);  

sp_help Library

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

PRimary Key = CLUSTERED INDEX

select * from Library where Book_Name = 'SQL SERVER9'
-- Non Clsutered Index
CREATE INDEX IX_Index_BookNAme  ON Library (Book_Name)  

DROP INDEX IX_Index_BookID on LIBRARY
drop index IX_Index_BookNAme on library

select * from Library where book_id = 1000
-- clsuter index
CREATE CLUSTERED INDEX IX_Index_BookID  ON Library (book_id)  


