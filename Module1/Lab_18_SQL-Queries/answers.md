answers

create schema ironhack_examples;
use ironhack_examples;
SELECT * FROM ironhack_examples.applestore;
-- ---------Q1----------the different genres
SELECT distinct prime_genre 
FROM ironhack_examples.applestore;
-- ---------Q2----------the genre with the most apps rated
SELECT  prime_genre, sum(rating_count_tot) 
FROM ironhack_examples.applestore 
group by prime_genre 
order by sum(rating_count_tot) desc; 
-- ---------Q3----------the genre with most apps
SELECT  prime_genre, count(track_name) 
FROM ironhack_examples.applestore 
group by prime_genre 
order by count(track_name) desc; 
-- Q4--------- the one with least?
SELECT  prime_genre, count(track_name) 
FROM ironhack_examples.applestore 
group by prime_genre 
order by count(track_name) asc; 
-- ---------Q5----------top 10 apps most rated
SELECT track_name, sum(rating_count_tot), prime_genre 
FROM ironhack_examples.applestore 
group by track_name, prime_genre
order by sum(rating_count_tot) desc limit 10; 
-- --------Q6---------------top 10 apps best rated by users
SELECT  track_name, max(user_rating), prime_genre
FROM ironhack_examples.applestore 
group by track_name , prime_genre
order by max(user_rating) desc limit 10;  
-- --------Q7---------Take a look at the data you retrieved in question 5. Give some insights.
-- Social networking (Facebook) have rating total x2 from second position of Music app(Pandora)
-- ---------Q8---------- Take a look at the data you retrieved in question 6. Give some insights.
-- The most rated by user are aplication for photo (Photo Ephmere) for workout(J&J) and religion(Bible)
-- ------Q9--------compare the data from questions 5 and 6. What do you see?
-- Most popular by download are very different from most rated. May be people more happy with useful apps
-- -------Q10----------
-- skipping
-- -----Q11----------Do people care about the price of an app? Do some queries, comment why are you doing them and the results you retrieve. What is your conclusion?
SELECT prime_genre, avg(price), avg(user_rating)
FROM ironhack_examples.applestore 
group by prime_genre
order by avg(price) desc;
-- For education they spend the most, so knowledge has no price, and navigation and books comes after a biglap, so it's as well important to read and to navigate throuh