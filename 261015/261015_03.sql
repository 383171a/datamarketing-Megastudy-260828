# 1. 카테고리 테이블에서 코메디, 스포츠, 패밀리 카테고리의 카테고리 아이디를 카테고리 명과 함께 조회해주세요

SELECT * FROM category;

SELECT category_id, name 
FROM category
WHERE
	name = "Comedy" OR 
	name = "Sports" OR 
	name = "Family";

SELECT category_id, name 
FROM category
WHERE name IN ("Comedy", "Sports", "Family");


SELECT * FROM actor LIMIT 5;
SELECT * FROM address LIMIT 5;
SELECT * FROM category LIMIT 5;
SELECT * FROM city LIMIT 5;
SELECT * FROM country LIMIT 5;
SELECT * FROM customer LIMIT 5;
SELECT * FROM film LIMIT 5;
SELECT * FROM film_actor LIMIT 5;
SELECT * FROM film_category LIMIT 5;

# 2. 카테고리가 코메디인 영화 갯수를 조회해주세요.
-- SELECT name, COUNT(*) film_count
-- FROM category
-- WHERE name = "Comedy"
-- GROUP BY name;
SELECT * FROM category LIMIT 5;
SELECT * FROM film_category LIMIT 5;

SELECT C.name, COUNT(*) comedy_count
FROM category C
JOIN film_category F ON F.category_id = C.category_id
WHERE name = "Comedy"
GROUP BY name;

# 3. 카테고리에 포함되는 각각의 영화 갯수가 70이상인 가케고리 명을 출력
SELECT C.name, COUNT(*) film_count
FROM category C
JOIN film_category F ON F.category_id = C.category_id
-- WHERE film_count >= "70"
GROUP BY C.name;
# --> 내가 한거
SELECT C.name, COUNT(*) film_count
FROM category C
JOIN film_category F ON F.category_id = C.category_id
GROUP BY C.name
Having film_count >= "70";
# Having 절..

SELECT * FROM category; # 16개의 카테고리 목록이 존재

SELECT * FROM film_category LIMIT 5; 

SELECT 
	C.name,
    COUNT(*) category_count
FROM category C
JOIN film_category F ON F.category_id = C.category_id
GROUP BY C.category_id
HAVING category_count >= 70;

# 4. 각 카테고리에 포함된 영화들의 렌탈 횟수 & 카테고리명 출력 // 영화들은 특정 카테고리를 반드시 포함, 해당 카테고리를 포함하고 있는 영화들을 찾아서 해당 영화들이 몇 번 렌탈 조회, 해당 카테고리 명 조회 

-- SELECT 
-- 	C.name,
--     COUNT(*) rental_count
-- FROM category C
-- JOIN film_category F ON F.category_id = C.category_id
-- GROUP BY C.category_id;

-- DESC category; # category_id, name, last_update
-- DESC rental; # rental_id, rental_date, inventory_id, customer_id
-- DESC film_category; # film_id, category_id
-- DESC film; # film_id, rental_duration

-- SELECT * FROM film;
-- SELECT * FROM rental;
-- SELECT * FROM customer;
-- SELECT * FROM film_category;

-- SELECT name, COUNT(*) rental_count
-- FROM 
-- JOIN 

SELECT * FROM category; # category_id
SELECT * FROM film_category; # category_id, film_id
SELECT * FROM inventory; # inventory_id, film_id
SELECT * FROM rental; # inventory_id

SELECT 
	C.name, COUNT(*) category_rental_count
FROM category C ON F.category_id = C.category_id
JOIN 


SELECT 
	C.name,
    COUNT(*) category_rental_count
FROM category C
JOIN film_category F ON F.category_id = C.category_id
JOIN inventory I ON I.film_id = F.
JOIN film_category F ON F.category_id = C.category_id
GROUP BY C.category_id;


SELECT * FROM address; # address_id
SELECT * FROM customer; # address_id

SELECT COUNT(*) AS customer_only
FROM customer C
LEFT JOIN address A ON C.address_id = A.address_id
WHERE C.customer_id IS NULL;


