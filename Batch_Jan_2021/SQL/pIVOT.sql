CREATE TABLE Grades(
  [Student] VARCHAR(50),
  [Subject] VARCHAR(50),
  [Marks]   INT
)
GO
 
INSERT INTO Grades VALUES 
('Jacob','Mathematics',120),
('Jacob','Science',100),
('Jacob','Geography',190),
('Amilee','Mathematics',190),
('Amilee','Science',190),
('Amilee','Geography',200)
GO



select * from Grades ORDER BY STUDENT
SELECT * FROM (
			SELECT STUDENT,[SUBJECT],MARKS 
			FROM GRADES) StudentResults
			PIVOT
				(SUM(Marks) FOR STUDENT
				 IN (
							[jACOB],
							[aMILEE]							
						)					
					) as TBL

select  STUDENT,STRING_AGG(SUBJECT,', ') from Grades 
GROUP BY STUDENT
 ORDER BY STUDENT

