use sakila;


-- 0. Create film rebtal rates
create view film_rental_rates as
select film.title, film.rental_rate
from film;

select * from film_rental_rates;

-- 1. Find the running total of rental payments for each customer 
-- in the payment table, ordered by payment date

SELECT 
	customer_id,
	payment_date,
    amount,
sum(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) AS total_rental_payment
FROM payment;

-- 2. Find the rank and dense rank of each payment amount within each payment
-- date 
SELECT 
	DATE(payment_date) as date,
    amount,
DENSE_RANK() OVER (PARTITION BY payment_date ORDER BY amount DESC) AS payment_dens_rank,
RANK() OVER (PARTITION BY payment_date ORDER BY amount DESC) AS payment_rank
FROM payment;

-- 3. Find the ranking of each film based on its rental rate within its 
-- respective category
SELECT
	c.name as Category,
	f.title  as Title,
    f.rental_rate as Rental_rate,
    DENSE_RANK() OVER (PARTITION BY c.name ORDER BY f.rental_rate DESC) AS dens_rank,
	RANK() OVER (PARTITION BY c.name ORDER BY f.rental_rate DESC) AS rnk

FROM category c
	inner join film_category fc 
		on c.category_id = fc.category_id 
	left join film f
		on  fc.film_id = f.film_id
	;

-- 4. Update the previous query from above to retrieve only top 5 films
-- within each category
select * from 
(
SELECT
	c.name as Category,
	f.title  as Title,
    f.rental_rate as Rental_rate,
    ROw_NUMBER() OVER (PARTITION BY c.name ORDER BY f.rental_rate DESC) AS row_rank
FROM category c
	inner join film_category fc 
		on c.category_id = fc.category_id 
	left join film f
		on  fc.film_id = f.film_id
	
) sub_q
where row_rank <= 5 ;

-- 5. Find the difference between the current and previous payment amount 
-- and the difference between the current and next payment amount
-- for each customer in the payment table
SELECT 
	payment_id,
    customer_id,
    amount,
    payment_date,
	(amount - LAG(amount) OVER (PARTITION BY customer_id ORDER BY payment_date)) AS diff_from_prev,
	(LEAD(amount)  OVER (PARTITION BY customer_id ORDER BY payment_date) - amount) AS diff_from_next
FROM payment;

