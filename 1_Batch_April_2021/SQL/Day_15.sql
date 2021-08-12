use AdventureWorksDW2017

--c.	Give me the product name who has the maximum number of sales-order?
--d.	Give me the product category who has the highest sales figure?
--e.	Give me the total sales amount for all the product who’s color is Black

select * from DimProduct          --- color
select * from FactInternetSales   --- total sales 

sp_help FactInternetSales

select color,SUM(salesamount)  from DimProduct DP inner join FactInternetSales FIS 
					ON dp.ProductKey = FIS.ProductKey
					WHERE Color = 'Black'
					group by color   --- 8838411.9576

					select color,count(*)  from DimProduct DP 
					group by Color

					select * from FactInternetSales where ProductKey = 180
-----------------------------------------------------------------------------------------------------

---- temp tables
--- local temp tables.

select ProductAlternateKey,EnglishProductName into #temp_product from DimProduct where ProductKey IN (2,3,4,5)


select * from #temp_product


update #temp_product
set EnglishProductName = 'Balls'
where ProductAlternateKey like 'Be%'

select * from #temp_product

CREATE TABLE #temp_table
(
id int,
name varchar(10)
)


--------------------
use JB_2021_April


select *,
					ROW_NUMBER() OVER(partition by gender order by salary desc) as 'row number',
					RANK() OVER(partition by gender order by salary desc) as 'rank_1',
					DENSE_RANK() OVER(partition by gender order by salary desc) as 'dense_rank_2'	
					into ##temp_glbl
					from tblEmployee

select * from #temp
where [row number] in (3,4,5)

select * from 
	(
		select *,
					ROW_NUMBER() OVER(partition by gender order by salary desc) as 'row number',
					RANK() OVER(partition by gender order by salary desc) as 'rank_1',
					DENSE_RANK() OVER(partition by gender order by salary desc) as 'dense_rank_2'	
					from tblEmployee ) AS tBL_TEMP
	where [row number] in (3,4,5)




					
select * from #temp
where [row number] in (3,4,5)




select * from #temp
where [row number] in (3,4,5)



select * from ##temp
where [row number] in (3,4,5)

insert into #temp
values(15,'John','Male',6000,2,1,1,1)
select * from #temp
drop table #temp
---------------------------------------------------

------------------ CTEs ------------------- COMMON TABLE EXPRESSIONS
use JB_2021_April
select * from 
	(
		select *,
					ROW_NUMBER() OVER(partition by gender order by salary desc) as 'row number',
					RANK() OVER(partition by gender order by salary desc) as 'rank_1',
					DENSE_RANK() OVER(partition by gender order by salary desc) as 'dense_rank_2'	
					from tblEmployee ) AS tBL_TEMP
					inner join 
					(select * from tblEmployee)
	where [row number] in (3,4,5)

	select * from tBL_TEMP

	with cte_table
	AS
	(
	select *,
					ROW_NUMBER() OVER(partition by gender order by salary desc) as 'row number',
					RANK() OVER(partition by gender order by salary desc) as 'rank_1',
					DENSE_RANK() OVER(partition by gender order by salary desc) as 'dense_rank_2'	
					from tblEmployee
	),
	cte_employee
	as
	(select * from tblEmployee)

	select * from cte_table inner join cte_employee on cte_table.Name = cte_employee.name


	--------------------- STORED PROCEDURES ------------------------------------------------
	sp_help 

