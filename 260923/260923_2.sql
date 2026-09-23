# Subquery
 
# JOIN을 활용해서 서로 다른 테이블 간 관계 연결
# Subquery를 통해서 원래 서로 다른 테이블간 관계 연결
# Sub(보조) + Query (질의.질문.요청)
# Structured Query Language : DDL, DML, DTL
# 원래 메인 쿼리문이 존재 > 잘 사용하려고 하다보니 추가적인 쿼리문이 또 필요 
# 서브쿼리 = 쿼리문 안에 또다른 쿼리문 작성 구문
# 서브쿼리를 사용하는 방식 3개 
# 1) 단일값 서브쿼리(scalar subquery) : WHERE절 안에 단일 값을 반환하기 위한 목적으로 서브쿼리를 사용함
# 2) 다중행 서브쿼리 : WHERE절 함께 사용, IN(서브쿼리 구문)
# 3) 상관 서브쿼리 : correlated subquery 
# 서브쿼리 구문이 먼저 사용된 메인 쿼리문의 영향을 받음 

# JOIN 구문 사용하는경우가 80%다.
# 그래도 서브쿼리에 익숙해져있거나 간단하게 조회할 경우는 사용

USE bestproducts;
SELECT *
FROM items LIMIT 5;
SELECT *
FROM ranking;

SELECT title
FROM items LIMIT 5;

SELECT *
FROM ranking
WHERE sub_category = "여성신발"
LIMIT 5;

SELECT title
FROM items I
INNER JOIN ranking R USING(item_code)
WHERE sub_category = "여성신발";

SELECT title
FROM items
WHERE item_code IN (
	SELECT item_code FROM ranking
    WHERE sub_category = "여성신발"
);

# sakila DB 
# 영화 카테고리가 장르가 comedy인 영화의 고유한 장르 아이디를 조회
# 해당 장르 아이디보다 낮은 아이디를 갖고 있는 장르를 조회
# 조회한 각 장르별 영화 갯수를 검색
# 영화 1000편 => 100편정도는 액션, 드라마는 40편정도 스포츠는 30편정도 있을 것으로 추정, 이걸 조회하고 싶음
# 액션이라는 장르가 1번 드라마가 2번 스포츠가 3번 코메디가 4번 

USE sakila;
# 영화 장르 : category
SHOW TABLES;

SELECT * FROM category;
# 카테고리가 총 16개 -> 코메디 = comedy는 category_id가 5 

SHOW TABLES; # film_category
SELECT * FROM film_category LIMIT 5;

# 각 카테고리 = 장르별 영화 갯수 
# 코메디보다 값이 큰 아이디를 갖고 있는 장르에 한해서 조회하고 싶다
# 해당 장르별 영화 갯수를 조회

SELECT * FROM film_category
WHERE category_id
> (
SELECT category_id 
FROM category
WHERE name = "comedy"
);



SELECT 
	category_id,
    COUNT(*) film_count
FROM film_category F
WHERE F.category_id> (
	SELECT C.category_id 
	FROM category C
	WHERE name = "comedy")
GROUP BY F.category_id;

# bestproducts 데이터 베이스 안 테이블 활용
# 할인 가격이 10만원 이상인 상품이 메인 카테고리별로 몇 개나 있는지 조회
# 1) JOIN
# 2) Subquery



USE bestproducts;

# 어떤 테이블이 있는지 확인 가격이 어디에 있는지 화긴
SELECT * FROM items;
SELECT * FROM ranking;

DESC items;
DESC ranking;



SELECT main_category, COUNT(*) 
FROM items I
INNER JOIN  R USING()
GROUP BY main_category;

SELECT * FROM items LIMIT 5;

SELECT * FROM items WHERE dis_price >= 100000;
SELECT * FROM items LIMIT 5;

SELECT 
	R.main_category
FROM ranking R
WHERE R.item_code IN(
	SELECT I.item_code FROM items 
    WHERE dis_price >= 100000
);

SELECT 
	R.main_category,
    COUNT(*) category_count
FROM ranking R
WHERE R.item_code IN(
	SELECT I.item_code FROM items I
    WHERE dis_price >= 100000
)
GROUP BY R.main_category;

SELECT 
	R.main_category,
    COUNT(*) category_count
FROM ranking R
JOIN items I USING(item_code)
WHERE I.dis_price >= 100000
GROUP BY R.main_category;

SELECT 
	main_category, 
	COUNT(*) category_count
FROM ranking R 
JOIN items I USING(item_code)
WHERE I.dis_price >= 10000
GROUP BY R.main_category;

# 코드 및 문법을 외우는 행위 하지 말기