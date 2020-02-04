use FilegroupTest
/* Creation of Database & Additional File Groups */
CREATE DATABASE FilegroupTest 
ON PRIMARY  -- Primary file Group
(NAME = FGTest1_dat, 
 FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\FGTest1_dat.mdf'), 
FILEGROUP FGTestFG2  -- secondary file group -- can be on different disk as well
(NAME = FGTest2_dat, 
 FILENAME = 'D:\DataBase\FGTest2_dat.mdf') 
LOG ON 
(NAME = FGTest_log, --- log files for the transaction purpose
 FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\FGTest_log.ldf')

 /* Add new file Groups to existing database */
 /* this will not create anything as of now at DB level.*/
ALTER DATABASE FilegroupTest 
ADD FILEGROUP FGTestFG3

 /* Check the file Groups created in SQL SERVER         */

USE FilegroupTest;
GO
SELECT * 
FROM sys.filegroups


/* Add an existing File to a new FileGroup */

ALTER DATABASE FilegroupTest 
ADD FILEGROUP test

ALTER DATABASE FilegroupTest 
ADD FILE 
(NAME = FGTest3_dat, 
 FILENAME = 'D:\DataBase\FGTest3_dat.mdf') 
TO FILEGROUP FGTestFG3


ALTER DATABASE FilegroupTest 
ADD FILE 
(NAME = FGTest3_dat, 
 FILENAME = 'D:\DataBase\FGTest3_dat.mdf') 
TO FILEGROUP FGTestFG3

/* Create Objects in the FileGroups */


CREATE TABLE StuffAndJunk
(StuffHere INT NOT NULL, 
 JunkHere INT NOT NULL)
 ON FGTestFG3

 sp_help StuffAndJunk