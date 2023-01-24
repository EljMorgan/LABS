use lab_20_v2;

select * from Salesperson;

SELECT 
	staff_id,
    Name,
    Store
FROM
	salesperson
WHERE
	id = 5;
    
UPDATE Salesperson
SET 
	store = 'Miami'
WHERE 
	id = 5;
    
SELECT * FROM Customers;
    
UPDATE
	customers
SET 
	email = 'ppicasso@gmail.com'
WHERE 
	id = 1;
    
UPDATE
	customers
SET 
	email = 'plincoln@us.gov'
WHERE 
	id = 2;
    
UPDATE
	customers
SET 
	email = 'hello@napoleon.me'
WHERE 
	id = 3;
    
SELECT * FROM Customers;