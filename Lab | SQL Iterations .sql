--- Lab | SQL Iterations


--- Write a query to find what is the total business done by each store.

select i.store_id, sum(p.amount)
from inventory i
inner join rental r on i.inventory_id = r.inventory_id
inner join payment p on p.customer_id = r.customer_id
group by i.store_id  
order by sum(p.amount);

-- Convert the previous query into a stored procedure.
DELIMITER //
CREATE PROCEDURE Business()
BEGIN
	select i.store_id, sum(p.amount)
	from inventory i
	inner join rental r on i.inventory_id = r.inventory_id
	inner join payment p on p.customer_id = r.customer_id
	group by i.store_id  
	order by sum(p.amount);
END //
DELIMITER;

DROP PROCEDURE Business;

CALL Business

--- Convert the previous query into a stored procedure that takes the input for store_id and displays the total sales for that store.

DELIMITER //
CREATE PROCEDURE Businesstore(in X int)
BEGIN
	select X, sum(p.amount)
	from inventory i
	inner join rental r on i.inventory_id = r.inventory_id
	inner join payment p on p.customer_id = r.customer_id
	group by X
	order by sum(p.amount);
END //
DELIMITER;

DROP PROCEDURE Businesstore;

CALL Businesstore(2);

--- Update the previous query. Declare a variable total_sales_value of float type, that will store the returned result (of the total sales amount for the store). Call the stored procedure and print the results.

DELIMITER //
CREATE PROCEDURE Businesstore2(in X int, out total_sales int)
BEGIN
	select sum(p.amount) into total_sales
	from inventory i
	inner join rental r on i.inventory_id = r.inventory_id
	inner join payment p on p.customer_id = r.customer_id
	group by X
	order by sum(p.amount);
END //
DELIMITER;

DROP PROCEDURE Businesstore2;

CALL Businesstore2(2,@i);
select @i

--- In the previous query, add another variable flag. If the total sales value for the store is over 30.000, then label it as green_flag, otherwise label is as red_flag. Update the stored procedure that takes an input as the store_id and returns total sales value for that store and flag value

DELIMITER //
CREATE PROCEDURE Businesflag2(in X float, out flag varchar(20))
BEGIN
	select 
	case 
		when sum(p.amount) > 30.000 then 'green_flag'
		else 'red_flag'
		end into flag
	from inventory i
	inner join rental r on i.inventory_id = r.inventory_id
	inner join payment p on p.customer_id = r.customer_id
	group by X
	order by sum(p.amount);
END //
DELIMITER ;

DROP PROCEDURE Businesflag2;

CALL Businesflag3(2,@k);
select @k





