-- Challenges
/*

Question 1:
Level: Simple
Topic: DISTINCT
Task: Create a list of all the different (distinct) replacement costs of the films.
Question: What's the lowest replacement cost?
Answer: 9.99

*/

-- data 
select * from film limit 100;
select * from film_category limit 100;
select * from category limit 100;
select * from actor;
select * from film_actor;


select * from film limit 100;

select min(REPLACEMENT_COST) as lowest_replacement_cost
from ( select distinct REPLACEMENT_COST from film )
as distinct_cost;

/*
Question 2:
Level: Moderate
Topic: CASE + GROUP BY
Task: Write a query that gives an overview of how many films have replacements costs 
in the following cost ranges
1. low: 9.99 - 19.99
2. medium: 20.00 - 24.99
3. high: 25.00 - 29.99
Question: How many films have a replacement cost in the "low" group?
Answer: 514
*/
select * from film;

select case
when replacement_cost between 9.99 and 19.99 then 'low'
when replacement_cost between 20.00 and 24.99 then 'medium'
when replacement_cost between 25.00 and 29.99 then 'high'
end as cost_range, 
count(*) as all_films
from film 
where replacement_cost between 9.99 and 19.99 group by cost_range;


/* 

Question 3:
Level: Moderate
Topic: JOIN
Task: Create a list of the film titles including their title, length, and category name 
ordered descendingly by length. Filter the results to only the movies in the category 
'Drama' or 'Sports'.
Question: In which category is the longest film and how long is it?
Answer: Sports and 184
*/

select 
    f.title,
    f.length,
    c.name AS category_name
from 
    film f
join 
    film_category fc ON f.film_id = fc.film_id
join 
    category c ON fc.category_id = c.category_id
where 
    c.name IN ('Drama', 'Sports')
order by 
    f.length DESC limit 1;


/*
Question 4:
Level: Moderate
Topic: JOIN & GROUP BY
Task: Create an overview of how many movies (titles) there are in each category 
(name).
Question: Which category (name) is the most common among the films?
Answer: Sports with 74 titles
*/

select 
    c.name as category_name,
    count(f.title) as num_titles
from 
    category c
join 
    film_category fc on c.category_id = fc.category_id
join 
    film f on fc.film_id = f.film_id
group by 
    c.name
order by 
    num_titles desc
limit 1;

/*
Question 5:
Level: Moderate
Topic: JOIN & GROUP BY
Task: Create an overview of the actors' first and last names and in how many movies 
they appear in.
Question: Which actor is part of most movies??
Answer: Susan Davis with 54 movies
*/

select 
    a.first_name, 
    a.last_name, 
    count(fa.actor_id) as num_movies
from 
    actor a
join 
    film_actor fa on a.actor_id = fa.actor_id
group by 
    a.first_name, a.last_name
order by 
    num_movies desc
limit 1;

/*
Question 6:
Level: Moderate
Topic: LEFT JOIN & FILTERING
Task: Create an overview of the addresses that are not associated to any customer.
Question: How many addresses are that?
Answer: 4
*/

-- metadata
select * from city limit 100;
select * from country limit 10;
select * from customer limit 10;
select * from payment limit 10;


select 
    count(a.address_id) as num_addresses
from 
    address a
left join 
    customer c on a.address_id = c.address_id
where 
    c.address_id is null;


/*
Question 7:
Level: Moderate
Topic: JOIN & GROUP BY
Task: Create an overview of the cities and how much sales (sum of amount) have 
occurred there.
Question: Which city has the most sales?
Answer: Cape Coral with a total amount of 221.55
*/
select 
    ci.city, 
    sum(p.amount) as total_sales
from 
    city ci
join 
    address a on ci.city_id = a.city_id
join 
    customer c on a.address_id = c.address_id
join 
    payment p on c.customer_id = p.customer_id
group by 
    ci.city
order by 
    total_sales desc limit 1;


/*
Question 8:
Level: Moderate to difficult
Topic: JOIN & GROUP BY
Task: Create an overview of the revenue (sum of amount) grouped by a column in the 
format "country, city".
Question: Which country, city has the least sales?
Answer: United States, Tallahassee with a total amount of 50.85
*/


select 
    concat(co.country, ', ', ci.city) as country_city, 
    sum(p.amount) as total_sales
from 
    country co
join 
    city ci on co.country_id = ci.country_id
join 
    address a on ci.city_id = a.city_id
join 
    customer c on a.address_id = c.address_id
join 
    payment p on c.customer_id = p.customer_id
group by 
    country_city
order by 
    total_sales limit 1;





