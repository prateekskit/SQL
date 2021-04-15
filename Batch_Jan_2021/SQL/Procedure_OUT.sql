CREATE TABLE tblx
(
id int identity(1,1),
Firstname varchar(100)
)


insert into tblx
values('Zoe')

select * from tblx


ALTER PROCEDURE UpdInsTblX
	@id int,@name varchar(100),@x int output	
AS
BEGIN
	declare @id_x int
	set @id_x = 0  --- dfault values

	select @id_x = id
	 from tblx where id = @id

		if (@id_x = 0)
			BEGIN
				INSERT INTO tblx 
				VALUES(@name)

				select top 1 @x =  id from tblx order by id desc

			END
		ELSE
			BEGIN
				update tblx 
				set Firstname = @name
				where id = @id
			END
END

--- procedure will simply insert the customers data  --- customer ID
--- second proceudre based on customer id will define the custom landing page or UI

DECLARE @x int
	EXEC UPDINSTBLX 111,'X-MEN',@X OUT
	PRINT @X
SELECT * FROM TBLX WHERE ID = @X
