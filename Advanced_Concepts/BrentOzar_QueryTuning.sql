/*
Watch Brent Tune Queries 2020
Brent Ozar
v1.0 - 2020-01-30

Download the scripts, database, and resources free: 
https://BrentOzar.com/go/tunequeries

This file is licensed under cc-wiki with attribution required:
License: https://creativecommons.org/licenses/by-sa/4.0/


*** OUR DEMO ENVIRONMENT ***
Isn't AdventureWorks boring? Let's work on something a little more exciting.
StackExchange, the people behind StackOverflow.com and DBA.StackExchange.com,
make all of their databases available with a Creative Commons license.

To get the Stack Overflow database and play along, visit:
https://BrentOzar.com/go/querystack

I'm using the 50GB Stack Overflow 2013 database, but any version will work.

Set up an index for our query:
*/
USE StackOverflow2013;
GO
DropIndexes;
GO
CREATE INDEX IX_OwnerUserId ON dbo.Posts(OwnerUserId);
GO
ALTER DATABASE CURRENT SET COMPATIBILITY_LEVEL = 140 /* 2017, will show 2019 during the session too */
GO

CREATE OR ALTER FUNCTION dbo.fnGetPostType ( @PostTypeId INT )
RETURNS NVARCHAR(50)
    WITH RETURNS NULL ON NULL INPUT,
         SCHEMABINDING
AS
    BEGIN
        DECLARE @PostType NVARCHAR(50);
        SELECT  @PostType = [Type]
        FROM    dbo.PostTypes
        WHERE   Id = @PostTypeId;

        IF @PostType IS NULL
            SET @PostType = 'Unknown';
        RETURN @PostType;
    END;
GO

CREATE OR ALTER PROC dbo.usp_RptInterestingUsers AS
BEGIN
SET NOCOUNT ON

CREATE TABLE #InterestingUsers (UserId INT PRIMARY KEY CLUSTERED, DisplayName NVARCHAR(40));

INSERT INTO #InterestingUsers (UserId, DisplayName)
  SELECT u.Id, u.DisplayName
  FROM dbo.Users u
  WHERE (u.DownVotes + u.UpVotes + u.Reputation + u.Views) > 1000000 /* They've done a lot of work */
    AND EXISTS(SELECT * FROM dbo.Posts p WHERE p.PostTypeId = 1 AND p.OwnerUserId = u.Id); /* They've posted at least one question */

SELECT iu.UserId, iu.DisplayName, dbo.fnGetPostType(p.PostTypeId) AS PostType, COUNT(DISTINCT p.Id) AS Posts
  FROM #InterestingUsers iu
  INNER JOIN dbo.Posts p ON iu.UserId = p.OwnerUserId
  GROUP BY iu.UserId, iu.DisplayName, dbo.fnGetPostType(p.PostTypeId)
  ORDER BY iu.UserId, iu.DisplayName, dbo.fnGetPostType(p.PostTypeId)

END
GO


EXEC usp_RptInterestingUsers;
GO