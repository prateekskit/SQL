
Create database Test_2
use Test_2
CREATE TABLE Test
(
	Filler CHAR(8000)
)
 
GO

/* Insert record in the files  */

-- Insert 40.000 records, results in about 312MB data (40.000 x 8KB / 1024 = 312,5MB)
-- They are distributed in a round-robin fashion between the files in the file group "FileGroup1"
-- Each file will get about 160MB
DECLARE @i INT = 1
WHILE (@i <= 40000)
BEGIN
	INSERT INTO Test VALUES
	(
		REPLICATE('x', 8000)
	)
	
	SET @i += 1
END
GO

select * from test_2.dbo.test

use Test_2
update Test
set Filler = ''

select * from test_2_SS.dbo.test

/*Refreshing of database snapshot can be done via scripting */
 
CREATE DATABASE Test_2_SS
ON (NAME = Test_2, FILENAME = 'D:\DataBase\Test2.ss')
AS SNAPSHOT OF Test_2;
GO

use master
RESTORE DATABASE test_2 from DATABASE_SNAPSHOT = 'Test_2_SS'