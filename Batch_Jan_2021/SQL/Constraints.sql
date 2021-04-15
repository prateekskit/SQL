--- NULL constraints.

select * from DimCustomer

use JB_2021

select * from dimcustomer_name
select * from tblExample
sp_help tblExample 

insert into tblExample(id,fname,gender,salary,age)
values(1,'NULL','y',2000,89)

select * from tblExample where fname is null

select * from tblExample where fname = ''

alter table tblExample alter column fname varchar(max)


create table tblx
(
id int not null,
fname varchar(max)
)

select * from tblx
insert into tblx(id)
values(2)