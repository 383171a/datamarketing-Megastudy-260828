# 복합서브쿼리 구문
# 각 고객들은 영화를 렌탈할 수 있다.
# 각 고객들이 렌탈했던 영화들은 각각의 영화마다의 상영길이 
# 1 : 80분, 2 : 90분, ... 10 : 130분 
# 해당 렌탈 영화들의 평균 상영 길이 => 100분 
# 조회하고 싶은 결과 : 내가 그동안 렌탈했었던 영화의 재생길이가 내가 그동안 렌탈했었던 모든 영화들의 평균 재생길이보다 긴 영화들만 찾아서 해당 영화들의 제목 조회 

-- SELECT title, length FROM film
-- WHERE length > (
-- 	SELECT 
-- 		AVG(length)
-- 	FROM film
-- );

-- SELECT title,
-- 	AVG(length)
-- FROM(
-- 	SELECT 
-- 	customer_id,
--     COUNT(*) rental_count
-- FROM film
-- GROUP BY customer_id
-- ) rental_counts;

-- SELECT
-- 	AVG(rental_count)
-- FROM(
-- 	SELECT 
-- 	customer_id,
--     COUNT(*) rental_count
-- FROM rental
-- GROUP BY customer_id
-- ) rental_counts;

-- SELECT 
-- 	customer_id,
-- 	AVG(length) film_length
-- FROM film
-- GROUP BY customer_id;

-- SELECT * FROM film;

# 고객들이 그동안 렌탈했었던 영화들의 재생시간 (A) 
# 고객들이 그동안 렌탈했었던 영화들의 평균 재생시간 (B)
# A > B 조건에 해당되는 영화들의 제목만 가져오면 됨 


# 고객의 데이터 
SELECT * FROM customer LIMIT 5; # customer_id, first_name, last_name

# 고객렌탈 데이터
SELECT * FROM rental LIMIT 5; # customer_id, rental_id, inventory_id

# 영화재고 데이터 
SELECT * FROM inventory LIMIT 5; # inventory_id, film_id

# 영화들의 재생시간 
SELECT * FROM film LIMIT 5; # film_id, title, length 

SELECT 
	CONCAT(C.first_name, " ", C.last_name) full_name,
	F.title
FROM customer C
JOIN rental R ON R.customer_id = C.customer_id
JOIN inventory I ON I.inventory_id = R.inventory_id
JOIN film F ON F.film_id = I.film_id
WHERE F.length > (
	SELECT AVG(FIL.length)
    FROM film FIL
    JOIN inventory INV ON INV.film_id = FIL.film_id
    JOIN rental REN ON REN.inventory_id = INV.inventory_id
    WHERE REN.customer_id = C.customer_id
);

# 영화 테이블이 존재
# 영화 테이블에는 영화 렌탈 시, 보증금을 입금하는데
# 해당 보증금 얼마인지 확인 컬럼(replacement_cost)
# 보증금이 20달러 이상인 영화를 대여한 고객이 존재
# 해당 고객들의 이름을 조회(단, 고객들의 이름을 소문자로) 

# 고객 테이블 
SELECT * FROM customer; # first_name, last_name, customer_id
# 렌탈 테이블
SELECT * FROM rental LIMIT 5; # rental_id, customer_id, inventory_id
# 재고 테이블 
SELECT * FROM inventory LIMIT 5; # inventory_id, film_id
# 영화 테이블 먼저 화긴! 
SELECT * FROM film; # replacement_cost, film_id

SELECT 	
	DISTINCT LOWER(CONCAT(C.first_name, " ", C.last_name)) full_name
FROM customer C
JOIN rental R ON R.customer_id = C.customer_id
JOIN inventory I ON I.inventory_id = R.inventory_id
JOIN film F ON F.film_id = I.film_id
WHERE F.replacement_cost >= 20;





