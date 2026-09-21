# ctrl + enter : 단문 실행
# 전체 드래그 + ctrl + shift + enter : 복문 실행(전체실행) 

# sakila + ecommerce : DML 문법 활용(주로) + TCL
# DDL, DCL 도 사용하지 않는것이 아니지만 실습의 한계가 있기 때문에 실습의 어려움
# 실습은 초급->중급(JOIN, SUBQUERY)->고급으로(WINDOW)
# 수업 : SQLD 시험 : 2과목 중 1과목은 방어가 가능 
USE sakila;
SHOW TABLES;

# EDA(탐색적 데이터 분석 과정) = Exploratoy Data Analysis 
# EDA는 데이터를 분석하는 기법 중 하나 
# 데이터를 분석하려고 하는 담당자가 어떤 데이터를 부여받았을 때
# 해당 데이터가 어떤 목적으로 왜, 어떤 데이터를 가지고 있는지 등 파악 
# ETL, LDA라는 것도 있다.
# 현장에서는 누군가가 친절하게 해당 데이터를 하나씩 설명을 0해줄까? NOPE!

# Entity -> Table
# Attribute -> column 
# Record -> Row

# ERD = Entity Relationship Diagram
# ERM = Entity Relationship Model (다이어그램을 만들기 위한 목적을 정의) 

# 1) 데이터 조회시 행수 제한
SELECT * FROM film LIMIT 10; # 10개에 한해서 찾아와라 너무 많을 때 쓰기 
# film 테이블 안에 값이 천만개
# 숫자를 안쓰게 되면 모든 내역을 조회해서 값을 찾아오겠다. 

# 별칭 = Alias 

# 2) 전체 데이터가 몇개의 행으로 구성되어 있는지 집계했으면 좋겠다. = COUNT()
SELECT COUNT(*) AS film_count 
FROM film; # 공식적인 곳에서는 AS 씀

# 3) AS, 특정 컬럼을 지칭할 때 사용하는 에약어(생략 가능) 
SELECT COUNT(*) film_count 
FROM film; # 축약 버전

# 4) DISTNCT : 별개의 // 한 컬럼 안에 중복해서 사용중인 값을 중복없이 1번만 출력하고자 할 때

USE sakila;

SHOW TABLES;

SELECT COUNT(*) FROM film; # 1000개의 행

SELECT * FROM film LIMIT 10; # rating 등급 

SELECT DISTINCT rating FROM film; # 모든 영화는 5개의 등급 중 하나

SELECT DISTINCT release_year FROM film; # 1000개의 영화는 모두 2006년 개봉 영화이다.

# 5) 연산함수 : SUM(), AVG(), MAX(), MIN()
# 조회해야하는 값들이 수치화되어있는 정량데이터 
# 결제 데이터 -> 수치화 

SHOW TABLES;

SELECT COUNT(*) FROM customer; # 599명의 고객 데이터 존재
SELECT * FROM customer LIMIT 10;

SELECT COUNT(*) FROM payment; # 16044건의 결제 관련 데이터 존재
SELECT * FROM payment LIMIT 10;

SELECT 
	SUM(amount) amount_sum,
    ROUND(AVG(amount), 2) amount_avg, # 소수점 2째자리까지 출력
    MAX(amount) amount_max,
    MIN(amount) amount_min
FROM payment;

SELECT * FROM payment WHERE amount = 11.99; # 10개를 찾아온건가?

# 6) GROUP BY
# 특정 컬럼값을 기준으로 그룹핑하는 방법

SELECT DISTINCT rating FROM film; 
SELECT DISTINCT rating, COUNT(*) FROM film; /*Error Code: 1140. In aggregated query without GROUP BY, 
expression #1 of SELECT list contains nonaggregated column 'sakila.film.rating'; 
this is incompatible with sql_mode=only_full_group_by 집계가 되지않은 컬럼을 가져와서 세라고 했으니까 불가함*/

SELECT rating FROM film GROUP BY rating;
SELECT 
	rating, 
    COUNT(*) rating_count 
FROM film 
GROUP BY rating; # 현재 FOLDING된 상태, 그래서 집계 함수 가능

# 7) ORDER BY
# 특정 컬럼을 기준으로 정렬을 하고자 할 때 사용가능한 구문
# 정렬 : 오름차순 정렬 | 내림차순 정렬
# 아무런 정렬 명령어를 사용하지 않는다면, 기본적으로 오름차순 정렬 = default 
# 일반적으로 내림차순 정렬 관련 명령어를 주로 사용한다
# 내림차순 : DESC // 오름차순 : ASC

SELECT 
	rating, 
    COUNT(*) rating_count 
FROM film 
GROUP BY rating
ORDER BY rating_count DESC;


# 입력순서
/*
S.ELECT
F.ROM
W.HERE
G.ROUP BY
O.RDER BY
L.IMIT

컴퓨터가 읽는 순서 : FROM -> WHERE -> GROUP BY -> ORDER BY -> SELECT -> LIMIT 
*/

# 문제 : film 테이블에서 release 연도가 2006년 또는 2007년이면서, 
# 영화의 등급이 PG 또는 G 등급인 영화의 제목만 출력!!

SELECT 
	title 
FROM film
WHERE (release_year = 2006 OR release_year = 2007) AND (rating = "PG" OR rating = "G");

SELECT COUNT(*) FROM film
WHERE (release_year = 2006 OR release_year = 2007)
AND (rating = "PG" OR rating = "G");

# film 테이블 참고
# 영화 등급별(rating) 영화갯수, 평균렌탈비용 조회
# -> 논리적으로 생각해보자
/* 내가 한거
SELECT COUNT(*) FROM film;

SELECT COUNT(*) FROM film GROUP BY rating;

SELECT 
	rating, 
    COUNT(*) rating_count 
FROM film 
GROUP BY rating
ORDER BY rating_count DESC;

SELECT rating
    AVG(amount) amount_avg
FROM payment
GROUP BY rating;

SELECT 
	rating, 
	COUNT(*) rating_count 
FROM film 
GROUP BY rating;


SELECT * FROM film; **/


SELECT 
	rating,
    COUNT(*) rating_count,
	ROUND(AVG(rental_rate), 2) rental_avg
FROM film 
GROUP BY rating;

# Divide And Conquer 


