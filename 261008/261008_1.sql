USE sakila;

SELECT SQRT(4);
SELECT SQRT(9);

SELECT 
	ROUND(SQRT(length), 2) film_length_sqrt
FROM film 
WHERE length >= 120;

SELECT 
	SQRT(length) film_length_sqrt
FROM film 
WHERE length >= 120;


# 고객의 이름을 출력
# 고객들이 영화를 렌탈하면서 지불한 결제 비용이 존재 
# 해당 결제 비용의 전체 평균
# 고객들의 전체 결제 총 비용의 평균값보다 큰 금액으로 결제한 고객들만 선별해서 출력하기!
# 1)
SELECT * FROM customer LIMIT 5;
# 2) 
SELECT 
	CONCAT(first_name, " ", last_name) full_name
FROM customer LIMIT 5;
# 3)
SELECT COUNT(*) FROM customer; # 599 -> 하지만 전체 고객을 보고 싶은게 아니야
# 4) 
SELECT * FROM payment LIMIT 5; # 고객이 얼마 결제했지? 아 amount다 / customer_id를 통해 어떤 고객이 얼마를 지불했는지 알수 잇지
# 5)
SELECT * FROM customer LIMIT 5; # customer_id 로 가져와야지!
# 6)
SELECT AVG(amount) FROM payment; # 평균 비용이 4.201356이네!
# 7) 일반 서브쿼리 구문 / 거의 대부분 조건절에서 서브쿼리 구문 등장 
# 평균 금액보다 더 높은 금액 지불한 고객 찾기
SELECT 
	CONCAT(first_name, " ", last_name) full_name
FROM customer
WHERE customer_id IN (
	SELECT
		customer_id
    FROM payment
    WHERE amount > (
		SELECT AVG(amount)
        FROM payment
    )
);

# 고객별 지불한 횟수가 상이 / 현재 전체 고객 599명 
# A고객 : 3년동안 10회 결제 / B고객 : 3년동안 50회
# 조건 : 전체 고객 599명을 기준으로 평균 렌탈 횟수
# 전체 평균 렌탈 횟수 대비 그보다 더 많은 렌탈 횟수를 가지고 있는 고객만 선별해서 이름을 조회하자! 
# ~별, ~당, ~의 -> 고객별 그룹 => COUNT(*) 
# GROUP BY를 써야지
# 전체 평균 렌탈 횟수보다 높은 사람들만 조건식을 통해 선별해서 출력할 수 있어야되!
SELECT 
	CONCAT(first_name, " ", last_name) full_name
FROM rental
WHERE customer_id IN (
	SELECT
		customer_id
    FROM rental
    WHERE amount > (
		SELECT AVG(amount)
        FROM payment
    )
);

-- SHOW TABLES;

-- SELECT * FROM customer;
-- SELECT * FROM rental;

-- SELECT  COUNT(*) rental_count
-- FROM rental
-- GROUP BY rental_id;

# 1) 고객별 렌탈 횟수 = 서비스 진행 기간 중 몇 번의 결제를 진행했지?
# 전체 총 렌탈 횟수 평균
# 고객별 렌탈 횟수 > 전체 총 렌탈 횟수 평균

# 지불할 때 마다 렌탈 횟수 카운트
SELECT * FROM payment LIMIT 5;

SELECT COUNT(*) FROM payment;
# 고객별 렌탈 횟수
SELECT 
	customer_id, COUNT(*) payment_count
FROM payment
GROUP BY customer_id;

SELECT 
	CONCAT(first_name, " ", last_name) full_name
FROM customer
WHERE customer_id IN(
	SELECT customer_id 
    FROM payment 
    GROUP BY customer_id
    HAVING COUNT(*) > (
		SELECT AVG(payment_count)
		FROM (
			SELECT 
				COUNT(*) payment_count
			FROM payment
			GROUP BY customer_id
		) payment_counts
    )
);

# payment_count의 평균 구하기
SELECT AVG(payment_count)
FROM (
	SELECT 
		COUNT(*) payment_count
	FROM payment
	GROUP BY customer_id
) payment_counts;


# 전체 599명 고객 가운데, 가장 많은 대여 횟수 기록을 갖고 있는 고객의 이름을 조회 

-- SELECT 
-- 	customer_id, COUNT(*) payment_count
-- FROM payment
-- GROUP BY customer_id
-- ORDER BY payment_count DESC
-- LIMIT 1;

-- SELECT 
-- 	CONCAT(first_name, " ", last_name) full_name
-- FROM customer
# 1)
SELECT 
	customer_id, COUNT(*) payment_count
FROM payment
GROUP BY customer_id;

# 2)
SELECT 
CONCAT(first_name, " ", last_name) full_name
FROM customer
WHERE customer_id = (
	SELECT customer_id  
    FROM ( 
		SELECT
			customer_id,
			COUNT(*) payment_count
		FROM payment
		GROUP BY customer_id
	) payment_counts
    ORDER BY payment_count DESC
    LIMIT 1 
);

# 상관서브쿼리
SELECT 
	customer_id,
    amount,
    payment_date
FROM payment P
WHERE amount > (
	SELECT AVG(amount)
    FROM payment
    WHERE customer_id = P.customer_id
); 

SELECT 
	customer_id,
    amount,
    payment_date
FROM payment;
# -> 1번 고객이 0.99, 5.99, 2.99, 9.99 

SELECT 
	customer_id,
	AVG(amount) customer_avg
FROM payment
GROUP BY customer_id;
# -> 1번 고객, 평균 결제 금액 3.70 2번 고객, 평균 결제 금액 4.76..

# 영화 테이블은 영화 관련 정보 데이터 저장되어 있는데요 그 중 평균 상영 시간보다 긴 영화들만 찾아서 해당 영화들의 제목 출력하기!

SELECT * FROM film LIMIT 5;

SELECT title, length FROM film
WHERE length > (
	SELECT 
		AVG(length)
	FROM film
);

# 고객들은 저마다 렌탈 횟수를 가지고 있다.
# 전체 고객들의 평균 렌탈 횟수보다 더 많은 렌탈 횟수 기록을 갖고 있는 고객들의 이름을 조회
# 조건 : 고객별 렌탈 횟수 > 전체 고객 평균 렌탈 횟수
-- SELECT 
-- CONCAT(first_name, " ", last_name) full_name
-- FROM customer
-- WHERE customer_id IN (
-- 	SELECT 
-- 		AVG(amount) customer_avg
-- 	FROM payment
-- 	GROUP BY customer_id
-- );

-- DESC payment;

# 1) 고객 이름 조회
SELECT 
	CONCAT(first_name, " ", last_name) full_name
FROM customer LIMIT 5;

# 2) 각각 고객의 렌탈 횟수
SELECT 
	customer_id,
    COUNT(*) rental_count
FROM rental
GROUP BY customer_id;

# 2) 렌탈 평균
SELECT
	AVG(rental_count)
FROM(
	SELECT 
	customer_id,
    COUNT(*) rental_count
FROM rental
GROUP BY customer_id
) rental_counts;
	
SELECT 
	CONCAT(first_name, " ", last_name) full_name
FROM customer
WHERE customer_id IN (
		SELECT customer_id
	FROM rental 
    GROUP BY customer_id
    HAVING COUNT(*) > (
		SELECT 
			AVG(rental_count)
		FROM (
			SELECT 
				customer_id,
                COUNT(*) rental_count
			FROM rental
            GROUP BY customer_id
        )rental_counts        
    )   
);



SELECT 
	CONCAT(first_name, " ", last_name) full_name,
    (
		SELECT COUNT(*) FROM rental R
		WHERE R.customer_id = C.customer_id
	) customer_count
FROM customer C
WHERE C.customer_id IN (
	SELECT customer_id
	FROM rental 
    GROUP BY customer_id
    HAVING COUNT(*) > (
		SELECT 
			AVG(rental_count)
		FROM (
			SELECT 
				customer_id,
                COUNT(*) rental_count
			FROM rental
            GROUP BY customer_id
        )rental_counts        
    )   
);

