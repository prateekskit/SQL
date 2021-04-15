select * from library
select count(*) from library with(nolock)

CREATE PROCEDURE getLibrary @param int
AS
BEGIN
	DECLARE @query AS NVARCHAR(255)
	DECLARE @tbl AS NVARCHAR(255)
	DECLARE @book_id int
	DECLARE @subject_id int
	SET @book_id = 100
	SET @subject_id = 250
	SET @tbl = 'library'

	SET @query = N'SELECT * FROM '+ @tbl + ' where '
	
	print @query
	
	if(@param = 1)
		begin
			SET @query = @query + ' book_id = ' + CAST(@book_id as varchar)
			print @query
		end
	else 
		begin
		   SET @query = @query + ' subject_id = ' + CAST(@subject_id as varchar);
		   print @query
		end
	
	EXEC(@query);

END

exec getLibrary 10