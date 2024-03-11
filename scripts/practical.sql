--- practical 5 march 

select * from payment WHERE customer_id=100;

select first_name,last_name from customer where first_name='ERICA';
------------------------------
--The inventory manager asks you how rentals have not been returned yet (return_date is null).
select * from rental;
Select * from rental where return_date IS NULL;
-- update rental set return_date = NULL where return_date = 'NULL';
--The sales manager asks you how for a list of all the payment_ids with an amount less than or equal to $2. Include payment_id and the amount.
select * from payment;
SELECT payment_id, amount FROM payment WHERE amount <= 2;

select * from payment where (amount=10.99 or amount=9.99) and customer_id=426;
-------------------------------------------------------------
--Q: The suppcity manager asks you about a list of all the payment of the customer 322, 346 and 354 where the amount is either less than $2 or greater than $10.
-- It should be ordered by the customer first  (ascending) and then as second condition order by amount in a descending order.
select * from payment where 
(customer_id=322 or customer_id=346 or customer_id=354)
and (amount<2 or amount>10)
;
select *
from payment
where (customer_id = 322 or customer_id = 346 or customer_id = 354)
and (amount < 2 or amount > 10)
order by customer_id asc, amount desc;
------------------------------------
--BETWEEN
select payment_id, amount from payment WHERE AMOUNT between 1.99 and 6.99;
select payment_id, amount from payment WHERE AMOUNT>= 1.99 and amount<=6.99;

select payment_id, payment_date from payment 
where payment_date between '2020-01-24' and '2020-01-26'
order by payment_date;
--------------------------------------------------
--Q
-- There have been 6 complaints of customers about their
-- customer_id: 12,25,67,93,124,234
-- The concerned payments are all the payments of these customers with amounts 4.99, 7.99 and 9.99  in January 2020.
select * from payment where customer_id IN (12,25,67,93,124,234)
AND AMOUNT IN (4.99,7.99,9.99)
and payment_date BETWEEN '2020-01-01' and '2020-01-31'
order by customer_id;
-----------------------------------------------------
--Q
-- How many payments have been made on January 26th and 27th
-- 2020 (including entire 27th) with an amount between 1.99 and 3.99?
select * from payment where payment_date BETWEEN '2020-01-26' and  '2020-01-27' and amount between 1.99 and 3.99;



---- DAY 31: 8th March 2024:
-----AGGREGATE
-- count(*) No of records in the table
select count(distinct total_amount) from bookings limit 1000;
select distinct total_amount from bookings;

select * from bookings limit 1000;

--distinct
select distinct store_id,first_name from customer;

-- 1.	Create a list of all the distinct districts customers are from.
select distinct district from address;

-- A marketing team member asks you about the different prices that have been paid.
-- To make it easier for them order the prices from high to low.
select distinct amount from payment order by amount desc;
select * from payment;
--sum
select sum(amount) from payment;
--average
select avg(amount) from payment;
--maximum
select max(amount) from payment;
--minimum
select min(amount) from payment;
select min(amount),max(amount),avg(amount),count(amount) from payment;

-- Your manager wants to which of the two employees (staff_id) is responsible for more payments?
-- Which of the two is responsible for a higher overall payment amount?
-- How do these amounts change if we don't consider amounts
-- equal to 0?
select count(*) from payment where staff_id=2 and amount!='0.00'; --7992 --7983
select count(*) from payment where staff_id=1 and amount!='0.00'; --8057 --8042
select sum(amount) from payment where staff_id=2; --33927.04
select sum(amount) from payment where staff_id=1;  --33489.47

select staff_id, count(*), sum(amount) from payment where amount!='0.00'
group by staff_id;

-- Which employee had the highest sales amount in a single day?
-- Which employee had the most sales in a single day (not
-- counting payments with amount = 0?
select * from payment;
select staff_id,date(payment_date), count(*) from payment
where amount!='0.00' 
group by staff_id,date(payment_date)
having count(*)>300
order by count(*) desc;

------------------------------------------------------------------------------------------

-- 09/03/2024 Practical 
/*
In 2020, April 28, 29 and 30 were days with very high revenue
That's why we want to focus in this task only on these days (filter accordingly).
Find out what is the average payment amount grouped by customer and day – consider only the days/customers with more than 1 payment (per customer and day).
Order by the average amount in a descending order.*/
select customer_id,date(payment_date) as pay_dt ,avg(amount) as average, count(*) from payment where payment_date between '2020-04-28' and '2020-05-01'
group by customer_id,pay_dt
having count(*)>1
order by average desc;
select date(payment_date) from payment where payment_date like '2020-04-30%';

-- Which employee had the highest sales amount in a single day?
-- Which employee had the most sales in a single day (not
-- counting payments with amount = 0?
select staff_id,sum(amount),date(payment_date) as pay_dt,count(*) as no_of_transactions  from payment where amount != '0.00'
group by staff_id,pay_dt
order by sum(amount) desc;

select 4+1,4-1,5/3,5%3,5*3,POW(5,3);
select * from payment;

select abs(-5),abs(5),ROUND(5.446346,2),CEIL(5.446346),FLOOR(5.446346);

select amount,
CASE 
    WHEN amount > 10 THEN 'VERY HIGH'
    WHEN amount > 8 THEN 'HIGH'
    WHEN amount <=8 AND amount>5 THEN 'MEDIUM'
    ELSE 'SMALL'
END AS CATEGORY
from payment;

-- day 8 case 

SELECT amount,
CASE
WHEN amount < 2 THEN 'low amount'
WHEN amount < 5 THEN 'mediumamount'
ELSE 'high amount'
END
FROM payment;

SELECT
TO_CHAR(book_date,'Dy'), 
TO_CHAR(book_date,'Mon'),
CASE
WHEN TO_CHAR(book_date,
'Dy')='Mon'THEN 'Monday special'
WHEN TO_CHAR(book_date,
'Mon')='Jul' THEN 'July special'
END
FROM bookings;

SELECT
TO_CHAR(book_date,'Dy'),
TO_CHAR(book_date,'Mon'), 
CASE
WHEN TO_CHAR(book_date,
'Dy')='Mon'THEN 'Monday special'
WHEN TO_CHAR(book_date,
'Mon')='Jul' THEN 'July special'
ELSE 'no special'
END
FROM bookings;

SELECT
total_amount, 
TO_CHAR(book_date,'Dy'), 
CASE
WHEN TO_CHAR(book_date,
'Dy')='Mon'THEN 'Monday special'
WHEN total_amount < 30000 THEN 'Special deal'
ELSE 'no special at all'
END
FROM bookings;

SELECT
total_amount, 
TO_CHAR(book_date,'Dy'), 
CASE
WHEN TO_CHAR(book_date,
'Dy')='Mon'THEN 'Monday special' 
WHEN total_amount*1.4 < 30000 THEN 'Special deal' ELSE
'no special at all'
END
FROM bookings;
-------------------------------------------------------------
/* Challenge 
You need to find out how many tickets you have sold in the
following categories:
• Low price ticket: total_amount< 20,000
• Mid price ticket: total_amount between 20,000 and 150,000
• High price ticket: total_amount >= 150,000
How many high price tickets has the company sold?
 */

select * from bookings;

SELECT 
  CASE 
    WHEN total_amount < 20000 THEN 'Low price ticket'
    WHEN total_amount >= 20000 AND total_amount < 150000 THEN 'Mid price ticket'
    WHEN total_amount >= 150000 THEN 'High price ticket'
  END AS ticket_category,
  COUNT(*) AS ticket_count
FROM bookings
GROUP BY ticket_category;


--------------------------------------------------------------
 /* Challenge
 You need to find out how many flights have departed in the
following seasons:
• Winter:December, January,February
• Spring:March, April,May
• Summer:June, July,August
• Fall:September, October, November
*/

select * from flights limit 100;

SELECT 
  CASE 
    WHEN EXTRACT(MONTH FROM scheduled_departure) IN (12, 1, 2) THEN 'Winter'
    WHEN EXTRACT(MONTH FROM scheduled_departure) IN (3, 4, 5) THEN 'Spring'
    WHEN EXTRACT(MONTH FROM scheduled_departure) IN (6, 7, 8) THEN 'Summer'
    WHEN EXTRACT(MONTH FROM scheduled_departure) IN (9, 10, 11) THEN 'Fall'
  END AS season,
  COUNT(*) AS flights_count
FROM flights
GROUP BY season;

-------------------------------------------------------------
/* challnge
You want to create a tierlist in the following way:
1. Rating is 'PG' or'PG-13' orlength is more then 210 min:
'Great rating orlong (tier1)
2. Description contains 'Drama' and length is more than 90min:
'Long drama (tier2)'
3. Description contains 'Drama' and length is not more than 90min:
'Shcity drama (tier 3)'
4. Rental_rate less than $1:
'Very cheap (tier4)'
If one movie can be in multiple categories it gets the highertier a ssigned.
How can you filterto only those movies that appearin one of these 4 tiers?
 */

select * from film;

 SELECT 
  title,
  CASE 
    WHEN rating IN ('PG', 'PG-13') OR length > 210 THEN 'Great rating or long (tier 1)'
    WHEN description LIKE '%Drama%' AND length > 90 THEN 'Long drama (tier 2)'
    WHEN description LIKE '%Drama%' AND length <= 90 THEN 'Short drama (tier 3)'
    WHEN rental_rate < 1 THEN 'Very cheap (tier 4)'
    ELSE 'Not in any tier'
  END AS tier
FROM film
WHERE 
  rating IN ('PG', 'PG-13') OR length > 210 OR 
  (description LIKE '%Drama%' AND length > 90) OR 
  (description LIKE '%Drama%' AND length <= 90) OR 
  rental_rate < 1;
 -------------------------------------------------------------

 /*You need to find out how many flights have departed in the following seasons:
Winter: Dec, Jan, Feb
Spring: Mar . Apr May
Summer: June July, Aug
Fall: Sep , Oct, Nov*/
select SEASON, COUNT(FLIGHT_NO) FROM (
select MONTHNAME(SCHEDULED_DEPARTURE) AS month_departed, 
CASE    WHEN month_departed IN ('Dec','Jan','Feb') THEN 'Winter'
        WHEN month_departed IN ('Mar','Apr','May') THEN 'Spring'
        WHEN month_departed IN ('Jun','Jul','Aug') THEN 'Summer'
        WHEN month_departed IN ('Sep','Oct','Nov') THEN 'Fall'
    ELSE 'INVALID SEASON'
END AS SEASON,*
from flights) 
GROUP BY SEASON;

--COALESCE--------------------------------------------------
select COALESCE(NULL,'COLUMN IS EMPTY');

SELECT TO_VARCHAR(363*430) , '4323', TO_NUMBER('4323');

-- REPLACE-------------------------------------------------------
select REPLACE(flight_no,'PG','') from flights;

select REPLACE('PGalkjdPG3453','PG','');


/*
The airline company wants to understand in which category they sell most tickets.
How many people choose seats in the category
Business
Economy or
Comfort?
You need to work on the seats table and the boarding_passes table.*/
select * from seats limit 10;
select * from boarding_passes limit 10;

select s.fare_conditions,count(B.TICKET_NO) from boarding_passes AS B
inner join seats AS S
ON B.SEAT_NO = S.SEAT_NO
group by s.fare_conditions;

select * from payment ;
select * from customer;

select P.payment_id,p.amount,c.first_name,c.last_name 
from payment AS P
INNER JOIN CUSTOMER C
ON P.CUSTOMER_ID=C.CUSTOMER_ID;

