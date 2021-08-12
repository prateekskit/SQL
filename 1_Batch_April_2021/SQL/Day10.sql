--- SEt OPERATORS
/*
UNION
UNION ALL
EXCEPT
INTERSECT
*/

CREATE TABLE tblA
(
id int,
color varchar(10)
)

insert into tblA
values(4,'Orange')

update tblC
set colour = 'Brown'
where id = 4

select *  from tblA
select * from tblB
select * from  tblC
---- merge all the data and brings up the unique record set
---- order of column in each query should be of similar data type
select * from tblA
UNION 
select * from tblB
UNION 
select * from tblC


select * from tblA
UNION ALL
select * from tblB
UNION ALL
select * from tblC

select customerkey,yearlyincome from DimCustomer
union
select EmployeeKey,baserate from DimEmployee


select * from tblA
INTERSECT
select * from tblB
INTERSECT
select * from tblC

--- 10-2 = 8
--- (10-2)-5 = 3 
--- (A-b)-C
select * from tblA
EXCEPT
select * from tblB  --- 2 white
EXCEPT
select * from tblC


select * from tblC

update tblC
set color = 'silver'
where id = 2



-----------------------------------------------
------------------Sub Query---------------------------

select color,count(*) from tblA group by color
UNION ALL
select color,count(*) from tblB group by color
UNION ALL
select color,count(*) from tblC group by color

------------------

select Aliass1.id,Aliass1.color 
						from (
								  (
												select * from tblA
												UNION ALL
												select * from tblB
												UNION ALL
												select * from tblC
						     	   ) As Aliass1
							   inner join
							      (select * from tblA	
								    union 
									select * from tblB										
												) as AB on Aliass1.id = AB.id
							   ) 
		

		select * from DimCustomer
		select * from FactInternetSales
		select * from DimEmployee where BirthDate 
							IN (select BirthDate from dimcustomer)


		select DimSalesTerritory.SalesTerritoryCountry,* from DimCustomer inner join FactInternetSales 
						on DimCustomer.CustomerKey = FactInternetSales.CustomerKey
						inner join DimSalesTerritory on 
						 FactInternetSales.SalesTerritoryKey = DimSalesTerritory.SalesTerritoryKey
						where FactInternetSales.SalesTerritoryKey = 1

						select * from DimSalesTerritory


		select * from dimcustomer where CustomerKey IN
					(select customerkey from 
							FactInternetSales inner join DimSalesTerritory on 
						 FactInternetSales.SalesTerritoryKey = DimSalesTerritory.SalesTerritoryKey
						where FactInternetSales.SalesTerritoryKey = 1)