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
select count(*) from payment where staff_id=2 and amount!='0.00';--7992 --7983
select count(*) from payment where staff_id=1 and amount!='0.00';--8057 --8042
select sum(amount) from payment where staff_id=2;--33927.04
select sum(amount) from payment where staff_id=1;--33489.47

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