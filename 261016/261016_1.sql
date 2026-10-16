# 윈도우 함수 = Window Function 
# Window = 창문 // Function = 기능 // 쿼리문을 작성해서 어떤 기능을 구현하려고 하는데, 마치 창문과 같은 기능을 구현하고 싶을 때 > 어떤 공간 내부에 독립적인 작은 공간을 새롭게 만들어서 독립적인 공간을 들여다 보기 위한 설치 도구
# 예) SUM() : 첫번째 행부터 마지막행까지 모두의 합계 계산
# 나는 1등부터 10등까지만 선별해서 SUM()을 하고 11~20등까지 선별해서 SUM()할래 

USE sakila;

SELECT * FROM film LIMIT 5;

SELECT title, length,
	RANK() OVER (ORDER BY length DESC) ranking, # 동일한 1첫번째가 끝나서 그 1의 갯수만큼 10으로 감
	DENSE_RANK() OVER (ORDER BY length DESC) dense_ranking, # 동일한 1첫번째가 끝나서 다음 2로 감
	ROW_NUMBER() OVER (ORDER BY length DESC) row_numbers # 단순한 카운트 // 들어오는 순서에 따라 임의로
FROM film
ORDER BY length DESC; # ASC 

SELECT * FROM customer LIMIT 5; # customer_id
SELECT * FROM payment LIMIT 5; # customer_id

SELECT 
	C.customer_id,
    CONCAT(C.first_name, " ", C.last_name) customer_name,
    SUM(P.amount) total_amount,
    RANK() OVER (ORDER BY SUM(P.amount) DESC) ranking,
    DENSE_RANK() OVER (ORDER BY SUM(P.amount) DESC) dense_ranking,
    ROW_NUMBER() OVER (ORDER BY SUM(P.amount) DESC) row_numbers
FROM customer C
JOIN payment P ON P.customer_id = C.customer_id 
GROUP BY C.customer_id
ORDER BY total_amount DESC;


SELECT * FROM rental LIMIT 5;
SELECT 
	customer_id,
    rental_date,
    COUNT(*) OVER (PARTITION BY customer_id ORDER BY rental_date
					ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_rentals
FROM rental;

SELECT 
	customer_id,
    rental_date,
    COUNT(*) OVER (PARTITION BY customer_id ORDER BY rental_date
					ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cumulative_rentals
FROM rental;

SELECT 
	customer_id,
    rental_date,
    COUNT(*) OVER (PARTITION BY customer_id ORDER BY rental_date
					ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_rentals_01,
    COUNT(*) OVER (PARTITION BY customer_id ORDER BY rental_date
					ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cumulative_rentals_02,
    COUNT(*) OVER (PARTITION BY customer_id ORDER BY rental_date
					ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS cumulative_rentals_03	
FROM rental;




SELECT * FROM payment LIMIT 5; # rental_id
SELECT * FROM rental LIMIT 5; # rental_id

SELECT 
	R.customer_id,
    R.rental_date,
	P.amount,
    SUM(P.amount) OVER (PARTITION BY R.customer_id ORDER BY rental_date
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_payment_amount01,
    SUM(P.amount) OVER (PARTITION BY R.customer_id ORDER BY rental_date
						ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) cumulative_payment_amount02,     
    AVG(P.amount) OVER (PARTITION BY R.customer_id ORDER BY rental_date
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_payment_amount03
FROM payment P
JOIN rental R ON R.rental_id = P.rental_id
ORDER BY R.customer_id;

SELECT 
	R.customer_id,
    R.rental_date,
	P.amount,
    SUM(P.amount) OVER (PARTITION BY R.customer_id ORDER BY DATE(rental_date)
						RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_payment_amount01,
    SUM(P.amount) OVER (PARTITION BY R.customer_id ORDER BY DATE(rental_date)
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_payment_amount02
FROM payment P
JOIN rental R ON R.rental_id = P.rental_id
ORDER BY R.customer_id;

SELECT * FROM payment LIMIT 5; # rental_id
SELECT * FROM rental LIMIT 5; # rental_id, inventory_id 
SELECT * FROM inventory LIMIT 5; # inventory_id, film_id 

SELECT 
	I.film_id,
	P.amount,
    P.payment_date,
    SUM(P.amount) OVER (PARTITION BY I.film_id ORDER BY P.payment_date
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_payment_revenue     
FROM payment P
JOIN rental R ON R.rental_id = P.rental_id
JOIN inventory I ON I.inventory_id = R.inventory_id;


SELECT 
	I.film_id,
	P.amount,
    P.payment_date,
    SUM(P.amount) OVER (PARTITION BY I.film_id ORDER BY P.payment_date
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_payment_revenue01,    
    SUM(P.amount) OVER (PARTITION BY I.film_id ORDER BY P.payment_date
						ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) cumulative_payment_revenue02
FROM payment P
JOIN rental R ON R.rental_id = P.rental_id
JOIN inventory I ON I.inventory_id = R.inventory_id;

SELECT 
	I.film_id,
	P.amount,
    P.payment_date,
    SUM(P.amount) OVER (PARTITION BY I.film_id ORDER BY P.payment_date
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_payment_revenue01,    
    SUM(P.amount) OVER (PARTITION BY I.film_id ORDER BY P.payment_date
						ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) cumulative_payment_revenue02,
    COUNT(P.amount) OVER (PARTITION BY I.film_id ORDER BY P.payment_date
						ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) cumulative_payment_revenue03,
    AVG(P.amount) OVER (PARTITION BY I.film_id ORDER BY P.payment_date
						ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_payment_revenue04
FROM payment P
JOIN rental R ON R.rental_id = P.rental_id
JOIN inventory I ON I.inventory_id = R.inventory_id;


















