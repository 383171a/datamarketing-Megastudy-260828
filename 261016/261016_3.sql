SELECT * FROM rental LIMIT 5;

SELECT 
	rental_id,
    rental_date,
    LAG(rental_id, 1, 0) OVER (ORDER BY rental_date) prev_rental,
    LEAD(rental_id, 1, 0) OVER (ORDER BY rental_date) next_rental
FROM rental;
# 기준이 없을 때
SELECT 
	rental_id,
    rental_date,
    LAG(rental_id, 0) OVER (ORDER BY rental_date) prev_rental,
    LEAD(rental_id, 0) OVER (ORDER BY rental_date) next_rental
FROM rental;
# 결측치가 나옴 0과는 완전히 달라
SELECT 
	rental_id,
    rental_date,
    LAG(rental_id) OVER (ORDER BY rental_date) prev_rental,
    LEAD(rental_id) OVER (ORDER BY rental_date) next_rental
FROM rental;

SELECT * FROM rental LIMIT 5; # inventory_id
SELECT * FROM inventory LIMIT 5; # inventory_id, film_id 

SELECT 
	DISTINCT I.film_id,
    FIRST_VALUE(R.rental_date) over (PARTITION BY I.film_id ORDER BY R.rental_date) first_rental, 
    LAST_VALUE(R.rental_date) over (PARTITION BY I.film_id ORDER BY R.rental_date
									ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) last_rental
FROM rental R 
JOIN inventory I ON I.inventory_id = R.inventory_id;

SELECT * FROM rental LIMIT 5; # rental_id, rental_date, customer_id 

SELECT 
	customer_id ,
    rental_date,
    DATEDIFF(rental_date, LAG(rental_date) OVER (PARTITION BY customer_id ORDER BY rental_date)) days_since_last_rental
FROM rental
ORDER BY customer_id, rental_date;

# 백분위 순위 : 꼴등은 % 없음 
SELECT 
	title,
    length,
    PERCENT_RANK() OVER (ORDER BY length) percent
FROM film
ORDER BY length;

# 누적분포 : 마지막이 무조건 1 꼴찌도 지분이 있음
SELECT 
	title,
    length,
    PERCENT_RANK() OVER (ORDER BY length) percent,
	CUME_DIST() OVER (ORDER BY length) cume
FROM film
ORDER BY length;

SELECT 
	customer_id,
    CONCAT(first_name, " ", last_name) customer_name,
    NTILE(4) OVER (ORDER BY customer_id) customer_group
FROM customer;








