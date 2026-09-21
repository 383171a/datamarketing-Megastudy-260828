# 8) HAVING 절
# GROUP BY를 통해서 그룹의 대상이 된 요소의 조건을 따지고자 할 때
# 우리는 그동안 WHERE 조건절만 썼지

USE sakila;

SELECT * FROM film LIMIT 10;

SELECT rating, COUNT(*) rating_count 
FROM film
-- WHERE COUNT(*) >= 100 WHERE 라는 조건절은 반드시 그룹이 안된 대상만 활용!
GROUP BY rating;

SELECT rating, COUNT(*) rating_count 
FROM film
GROUP BY rating
HAVING COUNT(*) >= 200;
# HAVING절은 그룹화가 된 대상으로 활용, 조건을 적용하고자 할 때,
# HAVING은 반드시 GROUP BY 뒤에 와야한다! 반드시 기억!!! 
/*
작성순서
SELECT -> FROM -> WHERE(1차필터링:그룹핑이 안된 요소들) -> GROUP BY ->  HAVING -> ORDER BY -> LIMIT

처리 순서(실행순서) 
FROM -> WHERE(1차필터링:그룹핑이 안된 요소들) -> GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMIT
*/

SELECT rating, COUNT(*) rating_count 
FROM film
WHERE rental_rate >= 4.99 
GROUP BY rating; # 그룹이 안되었기 때문에 된다! WHERE와 GROUP 같이 가능