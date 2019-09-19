sp_help [sales.customers]

select * from sales.customers where customer_id = 1

/*  Non Clustered Index        */

SELECT  customer_id, city  FROM sales.customers
WHERE   city = 'Atwater';


/*Create a Non Clustered Index*/
CREATE INDEX ix_customers_city
ON sales.customers(city);

DROP INDEX ix_customers_city on  [sales.customers]

SELECT 
    customer_id, 
    first_name, 
    last_name
FROM 
    sales.customers
WHERE 
    last_name = 'Berg' AND 
    first_name = 'Monika';

