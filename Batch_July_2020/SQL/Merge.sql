Use JB_07_2020

update studentsource
set name = 'Mike M'
where id = 1

MERGE [TARGET] AS T
USING [SOURCE] AS S
   ON [JOIN_CONDITIONS]
 WHEN MATCHED THEN 
      [UPDATE STATEMENT]
 WHEN NOT MATCHED BY TARGET THEN
      [INSERT STATEMENT] 
 WHEN NOT MATCHED BY SOURCE THEN
      [DELETE STATEMENT]


Create table StudentSource
(
     ID int primary key,
     Name nvarchar(20)
)
GO

Insert into StudentSource values (1, 'Mike')
Insert into StudentSource values (2, 'Sara')
GO

Create table StudentTarget
(
     ID int primary key,
     Name nvarchar(20)
)
GO

Insert into StudentTarget values (1, 'Mike M')
Insert into StudentTarget values (3, 'John')
GO

MERGE StudentTarget AS T
USING StudentSource AS S
ON T.ID = S.ID
WHEN MATCHED THEN
     UPDATE SET T.NAME = S.NAME
WHEN NOT MATCHED BY TARGET THEN
     INSERT (ID, NAME) VALUES(S.ID, S.NAME)
WHEN NOT MATCHED BY SOURCE THEN
     DELETE;

SELECT * FROM StudentSource
SELECT * FROM  StudentTarget

Truncate Table StudentTarget
Truncate Table StudentSource
