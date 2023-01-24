USE olist;

SET FOREIGN_KEY_CHECKS=0;
SET FOREIGN_KEY_CHECKS=1;

Select * from olist.order_items limit 10;


-- Q1 -------- From the order_items table, find the price of the highest priced order and lowest price order.
SELECT order_id, price
FROM olist.order_items
WHERE price = (SELECT MAX(Price) FROM olist.order_items limit 1)
      OR price = (SELECT MIN(Price) FROM olist.order_items limit 1);

-- Q2 ------ From the order_items table, what is range of the shipping_limit_date of the orders?
SELECT order_id, shipping_limit_date
FROM olist.order_items
GROUP BY shipping_limit_date, order_id;

-- Q3 From the customers table, find the states with the greatest number of customers. ----------
SELECT customer_state, count(customer_id)
FROM olist.customers 
group by customer_state
order by count(customer_id) desc limit 10 ;

-- Q4  From the customers table, within the state with the greatest number of customers,
-- find the cities with the greatest number of customers.
SELECT customer_city, count(customer_id)
FROM olist.customers 
group by customer_city
order by count(customer_id) desc limit 10 ;

-- Q5 From the closed_deals table, how many distinct business segments are there (not including null)?
SELECT distinct business_segment
FROM olist.closed_deals
WHERE business_segment IS NOT NULL;

-- Q6 From the closed_deals table, sum the declared_monthly_revenue for duplicate row values in business_segment 
-- and find the 3 business segments with the highest declared monthly revenue (of those that declared revenue).
SELECT count(declared_monthly_revenue), business_segment
FROM olist.closed_deals
WHERE business_segment IS NOT NULL
group by business_segment
order by count(declared_monthly_revenue), business_segment desc limit 3;

-- Q7 From the order_reviews table, find the total number of distinct review score values.
SELECT distinct  sum(review_score)
FROM olist.order_reviews;

-- Q8 In the order_reviews table, create a new column with a description that corresponds 
-- to each number category for each review score from 1 - 5, then find the review score and category occurring most frequently in the table.
ALTER TABLE order_reviews ADD description_review varchar(255);

SET SQL_SAFE_UPDATES = 0;

UPDATE order_reviews
SET description_review = "very good"
WHERE review_score = 5;

UPDATE order_reviews
SET description_review = "good"
WHERE review_score = 4;

UPDATE order_reviews
SET description_review = "satisfying"
WHERE review_score = 3;

UPDATE order_reviews
SET description_review = "bad"
WHERE review_score = 2;

UPDATE order_reviews
SET description_review = "very bad"
WHERE review_score = 1;

SELECT DISTINCT description_review, count(description_review) from olist.order_reviews
GROUP BY olist.description_review
ORDER BY count(description_review) DESC
LIMIT 1;

-- Q9 From the order_reviews table, find the review value occurring most frequently and how many times it occurs.
SELECT review_score, count(review_score) FROM olist.order_reviews
GROUP BY review_score
ORDER BY count(review_score) DESC
LIMIT 1;








