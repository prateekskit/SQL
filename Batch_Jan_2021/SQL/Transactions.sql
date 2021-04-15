use JB_2021
select * from tblEmployee where id = 1

begin tran

	delete from tblEmployee where id = 1

commit tran

rollback tran