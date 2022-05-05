--  1. Rank films by length (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, and the rank. 
select title,length,
rank() over(partition by length order by length asc) as ranking
from sakila.film
where length is not null;
-- 2. Rank films by length within the `rating` category (filter out the rows that have nulls or 0s in length column). 
-- In your output, only select the columns title, length, rating and the rank. 
select title,rating,
rank() over(order by rating asc) as ranking_rating
from sakila.film;

-- 3. How many films are there for each of the categories in the category table. 
-- Use appropriate join to write this query
select a.film_id,title,count(a.title) as film_count,c.name
from sakila.film a 
INNER JOIN sakila.film_category b
ON a.film_id = b.film_id
INNER JOIN sakila.category c
ON b.category_id=c.category_id
GROUP BY c.name
ORDER BY film_count;

-- 4. Which actor has appeared in the most films?
select max(x.film_count), x.actor_name 
from 
(select count(title) film_count ,concat(c.first_name,"  ",c.last_name) as actor_name
from sakila.film a 
INNER JOIN sakila.film_actor b
ON a.film_id = b.film_id
INNER JOIN sakila.actor c
ON b.actor_id=c.actor_id
GROUP BY b.actor_id) x;

-- 5. Most active customer (the customer that has rented the most number of films)rental_id
select max(x.rented_film_count) as max_film_count , x.customer_name 
from
(select count(rental_id) as rented_film_count,concat(b. first_name,"  ",b.last_name) as customer_name
from sakila.rental a 
INNER JOIN sakila.customer b
on a.customer_id= b.customer_id
GROUP BY a.customer_id )x;