--Schemas in Database
/*
A schema always belongs to one database. On the other hand, a database may have one or multiple schemas.
*/

CREATE SCHEMA sch;
GO

-- you can create same name tables in different schemas. Schemas can act as security groups.

CREATE TABLE jobs(
    job_id INT PRIMARY KEY IDENTITY,
    customer_id INT NOT NULL,
    description VARCHAR(200),
    created_at DATETIME2 NOT NULL
);


CREATE TABLE sch.jobs(
    job_id INT PRIMARY KEY IDENTITY,
    customer_id INT NOT NULL,
    description VARCHAR(200),
    created_at DATETIME2 NOT NULL
);



use janbask_6
SELECT * 
FROM sys.objects 
WHERE schema_id = SCHEMA_ID('sch')

SELECT 
    s.name AS schema_name, 
    u.name AS schema_owner
FROM 
    sys.schemas s
INNER JOIN sys.sysusers u ON u.uid = s.principal_id
ORDER BY 
    s.name;


/* CREATE USER Commands   */

--User based on a login using SQL Server authentication.

-- at server level
CREATE Login login_1 with password = 'abcd1234';


-- create server level roles
USE master;  
CREATE SERVER ROLE role_2 AUTHORIZATION login_1;  
GO 

-- create DB user based on login created above...
use janbask_6
CREATE USER login_1

-- GRANT,DENY,REVOKE

use janbask_6
-- granting permission 


GRANT SELECT on SCHEMA :: sch to login_1
GRANT DELETE on SCHEMA :: sch to login_1

DENY DELETE ON SCHEMA :: sch to login_1

REVOKE SELECT on SCHEMA :: sch to login_1