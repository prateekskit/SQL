
/* https://www.sqlshack.com/sql-server-2016-enhancements-truncate-table-table-partitioning/ */



DROP DATABASE IF EXISTS powerSQLPartitionTest;
GO
CREATE DATABASE powerSQLPartitionTest;
 
USE powerSQLPartitionTest
GO
--The following statements create filegroups to a database powerSQLPartitionTest
 
ALTER DATABASE powerSQLPartitionTest ADD FILEGROUP [Filegroup_2017]  
GO  
ALTER DATABASE powerSQLPartitionTest ADD FILEGROUP [Filegroup_2018]  
GO  
ALTER DATABASE powerSQLPartitionTest ADD FILEGROUP [Filegroup_2019]  
GO  
ALTER DATABASE powerSQLPartitionTest ADD FILEGROUP [Filegroup_2020]  
GO
ALTER DATABASE powerSQLPartitionTest ADD FILEGROUP [Filegroup_2021]  
 
--#Add one file to each filegroup so that you can store partition data in each filegroup
 
ALTER DATABASE powerSQLPartitionTest
  ADD FILE
  (
NAME = N'data_2017',
FILENAME = N'D:\DataBase\filegroups\data_2017.ndf',
SIZE = 5MB,
MAXSIZE = 100MB,
FILEGROWTH = 2MB
  )
  TO FILEGROUP [Filegroup_2017]
GO  
ALTER DATABASE powerSQLPartitionTest
  ADD FILE
  (
NAME = N'data_2018',
FILENAME = N'D:\DataBase\filegroups\data_2018.ndf',
SIZE = 5MB,
  	MAXSIZE = 100MB,
  	FILEGROWTH = 2MB
  )
  TO FILEGROUP [Filegroup_2018]
GO  
ALTER DATABASE powerSQLPartitionTest
  ADD FILE
  (
NAME = N'data_2019',
  	FILENAME = N'D:\DataBase\filegroups\data_2019.ndf',
  	SIZE = 5MB,
  	MAXSIZE = 100MB,
FILEGROWTH = 2MB
  )
  TO FILEGROUP [Filegroup_2019]
GO  
ALTER DATABASE powerSQLPartitionTest
  ADD FILE
  (
NAME = N'data_2020',
  	FILENAME = N'D:\DataBase\filegroups\data_2020.ndf',
  	SIZE = 5MB,
  	MAXSIZE = 100MB,
  	FILEGROWTH = 2MB
  )
  TO FILEGROUP [Filegroup_2020]
GO  
ALTER DATABASE powerSQLPartitionTest
  ADD FILE
  (
NAME = N'data_2021',
  	FILENAME = N'D:\DataBase\filegroups\data_2021.ndf',
  	SIZE = 5MB,
  	MAXSIZE = 100MB,
  	FILEGROWTH = 2MB)
  TO FILEGROUP [Filegroup_2021]
GO  
 
---Create Partition Range Function as follows
 
CREATE PARTITION FUNCTION powerSQLPartitionTest_PartitionRange (datetime)
AS RANGE LEFT FOR VALUES (datepart( year,getdate()));
GO
 
----Mapping partition scheme filegroups to the partition range function 
 
CREATE PARTITION SCHEME powerSQLPartitionTest_PartitionScheme
AS PARTITION powerSQLPartitionTest_PartitionRange TO ([PRIMARY], [Filegroup_2017],Filegroup_2018,Filegroup_2019,Filegroup_2020,Filegroup_2021);
GO
 
--Now that there is a partition function and scheme, you can create a partitioned table. The syntax is very similar to any other CREATE TABLE statement except it references the partition scheme instead of a referencing filegroup
 
CREATE TABLE powerSQLPartitionTestTable
(ID INT NOT NULL,
Date DATETIME default getdate())
ON powerSQLPartitionTest_PartitionScheme (ID);
GO
 
--Now that the table has been created on a partition scheme powerSQLPartitionTestTable , populate table using sample data
 
Insert into powerSQLPartitionTestTable (ID)
SELECT r_Number
FROM (
SELECT ABS(CAST(NEWID() AS binary(6)) %1000) + 1 r_Number
FROM master..spt_values) sample
GROUP BY r_Number
ORDER BY r_Number
 
--- select * from powerSQLPartitionTestTable order by id 
--- drop table powerSQLPartitionTestTable
 
SELECT *
FROM powerSQLPartitionTestTable where id = 45
GO
 
 
--Next we can use $PARTITION function to retrieve row counts  For each partition:  
 
 
SELECT $PARTITION.powerSQLPartitionTest_PartitionRange(ID)  AS PARTITIONID,
       COUNT(*) AS ROW_COUNT
FROM     dbo.powerSQLPartitionTestTable
GROUP BY $PARTITION.powerSQLPartitionTest_PartitionRange(ID)
ORDER BY PARTITIONID
 
SELECT *
FROM sys.partitions
WHERE OBJECT_NAME(OBJECT_ID)='powerSQLPartitionTestTable';
GO
 
 
--SQL Truncate individual Partition
 
TRUNCATE TABLE dbo.powerSQLPartitionTestTable WITH (PARTITIONS (2));
 
SELECT *
FROM sys.partitions
WHERE OBJECT_NAME(OBJECT_ID)='powerSQLPartitionTestTable';
GO