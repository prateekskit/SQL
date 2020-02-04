-- Create a new database



CREATE DATABASE MultipleFileGroups ON PRIMARY
(
	-- Primary File Group
	NAME = 'MultipleFileGroups',
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\MultipleFileGroups.mdf',
	SIZE = 5MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 1024KB
),
-- Secondary File Group
FILEGROUP FileGroup1
(
	-- 1st file in the first secondary File Group
	NAME = 'MultipleFileGroups1',
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\MultipleFileGroups1.ndf',
	SIZE = 1MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 1024KB
),
(
	-- 2nd file in the first secondary File Group
	NAME = 'MultipleFileGroups2',
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\MultipleFileGroups2.ndf',
	SIZE = 1MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 1024KB
)
LOG ON
(
	-- Log File
	NAME = 'MultipleFileGroups_Log',
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\MultipleFileGroups.ldf',
	SIZE = 5MB,
	MAXSIZE = UNLIMITED,
	FILEGROWTH = 1024KB
)
GO


Transact-SQL
CREATE TABLE Customers
(
   FirstName CHAR(50) NOT NULL,
   LastName CHAR(50) NOT NULL,
   Address CHAR(100) NOT NULL,
   ZipCode CHAR(5) NOT NULL,
   Rating INT NOT NULL,
   ModifiedDate DATETIME NOT NULL,
)
ON [FileGroup1]
GO

use MultipleFileGroups
CREATE TABLE Customers
(
   FirstName CHAR(50) NOT NULL,
   LastName CHAR(50) NOT NULL,
   Address CHAR(100) NOT NULL,
   ZipCode CHAR(5) NOT NULL,
   Rating INT NOT NULL,
   ModifiedDate DATETIME NOT NULL,
)
ON [FileGroup1]
GO

/*Simple Example */

/* Add two files in the same file Group */
ALTER DATABASE MultipleFileGroups 
ADD FILEGROUP test_1

ALTER DATABASE MultipleFileGroups 
ADD FILE 
(NAME = MFG_2, 
 FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\MFG_2.ndf') 
TO FILEGROUP test_1

ALTER DATABASE MultipleFileGroups 
ADD FILE 
(NAME = MFG_1, 
 FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\MFG_1.ndf') 
TO FILEGROUP test_1

/* table should be in file Group created above */
CREATE TABLE Test
(
	Filler CHAR(8000)
)
ON test_1
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
